package com.app.controller;

import com.app.model.CategorieService;
import com.app.service.CategorieServiceService;
import com.app.service.ServiceException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/** Gestion des catégories de services (réservée aux administrateurs, voir AuthFilter). */
@WebServlet("/categorie")
public class CategorieServiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CategorieServiceService categorieService = new CategorieServiceService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    request.getRequestDispatcher("/WEB-INF/views/categories/add.jsp").forward(request, response);
                    break;

                case "edit":
                    request.setAttribute("categorie", categorieService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.getRequestDispatcher("/WEB-INF/views/categories/edit.jsp").forward(request, response);
                    break;

                default:
                    request.setAttribute("categories", categorieService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/categories/list.jsp").forward(request, response);
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
                CategorieService c = new CategorieService();
                c.setNom(request.getParameter("nom"));
                c.setDescription(request.getParameter("description"));
                categorieService.ajouter(c);
            }
            else if ("edit".equals(action)) {
                CategorieService c = categorieService.trouver(Integer.parseInt(request.getParameter("id")));
                c.setNom(request.getParameter("nom"));
                c.setDescription(request.getParameter("description"));
                categorieService.modifier(c);
            }
            else if ("delete".equals(action)) {
                categorieService.supprimer(Integer.parseInt(request.getParameter("id")));
            }
            response.sendRedirect("categorie?action=list");
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
