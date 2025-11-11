package com.app.controller;

import com.app.model.CategorieService;
import com.app.model.ServiceDomicile;
import com.app.service.CategorieServiceService;
import com.app.service.ServiceDomicileService;
import com.app.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/service")
public class ServiceDomicileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ServiceDomicileService serviceDomicileService = new ServiceDomicileService();
    private CategorieServiceService categorieServiceService = new CategorieServiceService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {

                case "add":
                    // On doit charger les catégories dans le formulaire
                    List<CategorieService> categoriesAdd = categorieServiceService.lister();
                    request.setAttribute("categories", categoriesAdd);

                    request.getRequestDispatcher("/WEB-INF/views/service/add.jsp")
                           .forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    ServiceDomicile s = serviceDomicileService.trouver(idEdit);

                    // Charger les catégories pour le select
                    List<CategorieService> categoriesEdit = categorieServiceService.lister();
                    request.setAttribute("categories", categoriesEdit);

                    request.setAttribute("service", s);
                    request.getRequestDispatcher("/WEB-INF/views/service/edit.jsp")
                           .forward(request, response);
                    break;

                case "delete":
                    int idDelete = Integer.parseInt(request.getParameter("id"));
                    serviceDomicileService.supprimer(idDelete);
                    response.sendRedirect("service?action=list");
                    break;

                default: // LIST
                    List<ServiceDomicile> liste = serviceDomicileService.lister();
                    request.setAttribute("services", liste);

                    request.getRequestDispatcher("/WEB-INF/views/service/list.jsp")
                           .forward(request, response);
                    break;
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                ServiceDomicile s = new ServiceDomicile();
                s.setNom(request.getParameter("nom"));
                s.setPrix(Double.parseDouble(request.getParameter("prix")));

                // Récupérer catégorie
                int categorieId = Integer.parseInt(request.getParameter("categorie"));
                CategorieService c = categorieServiceService.trouver(categorieId);
                s.setCategorie(c);

                serviceDomicileService.ajouter(s);
                response.sendRedirect("service?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                ServiceDomicile s = serviceDomicileService.trouver(id);

                s.setNom(request.getParameter("nom"));
                s.setPrix(Double.parseDouble(request.getParameter("prix")));

                int categorieId = Integer.parseInt(request.getParameter("categorie"));
                CategorieService c = categorieServiceService.trouver(categorieId);
                s.setCategorie(c);

                serviceDomicileService.modifier(s);
                response.sendRedirect("service?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
