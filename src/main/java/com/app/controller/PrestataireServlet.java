package com.app.controller;

import com.app.model.Prestataire;
import com.app.service.PrestataireService;
import com.app.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/prestataire")
public class PrestataireServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private PrestataireService prestataireService = new PrestataireService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {

            switch (action) {

                case "add":
                    request.getRequestDispatcher("/WEB-INF/views/prestataire/add.jsp")
                           .forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    Prestataire p = prestataireService.trouver(idEdit);
                    request.setAttribute("prestataire", p);
                    request.getRequestDispatcher("/WEB-INF/views/prestataire/edit.jsp")
                           .forward(request, response);
                    break;

                case "delete":
                    int idDelete = Integer.parseInt(request.getParameter("id"));
                    prestataireService.supprimer(idDelete);
                    response.sendRedirect("prestataire?action=list");
                    break;

                default: // LIST
                    List<Prestataire> liste = prestataireService.lister();
                    request.setAttribute("prestataires", liste);
                    request.getRequestDispatcher("/WEB-INF/views/prestataire/list.jsp")
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

                Prestataire p = new Prestataire();
                p.setNom(request.getParameter("nom"));
                p.setPrenom(request.getParameter("prenom"));
                p.setEmail(request.getParameter("email"));
                p.setMotDePasse(request.getParameter("motDePasse"));
                p.setTelephone(request.getParameter("telephone"));
                p.setSpecialite(request.getParameter("specialite"));
                p.setDisponibilite(request.getParameter("disponibilite"));

                prestataireService.ajouter(p);
                response.sendRedirect("prestataire?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Prestataire p = prestataireService.trouver(id);

                p.setNom(request.getParameter("nom"));
                p.setPrenom(request.getParameter("prenom"));
                p.setEmail(request.getParameter("email"));
                p.setTelephone(request.getParameter("telephone"));
                p.setSpecialite(request.getParameter("specialite"));
                p.setDisponibilite(request.getParameter("disponibilite"));

                prestataireService.modifier(p);
                response.sendRedirect("prestataire?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
