package com.app.controller;

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

/** Catalogue des services : consultation pour tous, modification réservée aux administrateurs. */
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
                    request.setAttribute("categories", categorieServiceService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/service/add.jsp").forward(request, response);
                    break;

                case "edit":
                    request.setAttribute("categories", categorieServiceService.lister());
                    request.setAttribute("service", serviceDomicileService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.getRequestDispatcher("/WEB-INF/views/service/edit.jsp").forward(request, response);
                    break;

                default:
                    request.setAttribute("services", serviceDomicileService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/service/list.jsp").forward(request, response);
                    break;
            }
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                ServiceDomicile s = new ServiceDomicile();
                remplir(s, request);
                serviceDomicileService.ajouter(s);
            }
            else if ("edit".equals(action)) {
                ServiceDomicile s = serviceDomicileService.trouver(Integer.parseInt(request.getParameter("id")));
                remplir(s, request);
                serviceDomicileService.modifier(s);
            }
            else if ("delete".equals(action)) {
                serviceDomicileService.supprimer(Integer.parseInt(request.getParameter("id")));
            }
            response.sendRedirect("service?action=list");
        } catch (ServiceException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    private void remplir(ServiceDomicile s, HttpServletRequest request) throws ServiceException {
        s.setNom(request.getParameter("nom"));
        s.setPrix(Double.parseDouble(request.getParameter("prix")));
        s.setCategorie(categorieServiceService.trouver(Integer.parseInt(request.getParameter("categorie"))));
    }
}
