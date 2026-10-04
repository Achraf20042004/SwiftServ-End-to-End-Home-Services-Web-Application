package com.app.controller;

import com.app.model.Prestataire;
import com.app.service.PrestataireService;
import com.app.service.ServiceException;
import com.app.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/** Gestion des prestataires (réservée aux administrateurs, voir AuthFilter). */
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
                    request.getRequestDispatcher("/WEB-INF/views/prestataire/add.jsp").forward(request, response);
                    break;

                case "edit":
                    request.setAttribute("prestataire", prestataireService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.getRequestDispatcher("/WEB-INF/views/prestataire/edit.jsp").forward(request, response);
                    break;

                default:
                    request.setAttribute("prestataires", prestataireService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/prestataire/list.jsp").forward(request, response);
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
                Prestataire p = new Prestataire();
                remplir(p, request);
                p.setMotDePasse(PasswordUtil.hash(request.getParameter("motDePasse")));
                p.setRole("PRESTATAIRE");
                prestataireService.ajouter(p);
            }
            else if ("edit".equals(action)) {
                Prestataire p = prestataireService.trouver(Integer.parseInt(request.getParameter("id")));
                remplir(p, request);
                prestataireService.modifier(p);
            }
            else if ("delete".equals(action)) {
                prestataireService.supprimer(Integer.parseInt(request.getParameter("id")));
            }
            response.sendRedirect("prestataire?action=list");
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    private void remplir(Prestataire p, HttpServletRequest request) {
        p.setNom(request.getParameter("nom"));
        p.setPrenom(request.getParameter("prenom"));
        p.setEmail(request.getParameter("email"));
        p.setTelephone(request.getParameter("telephone"));
        p.setSpecialite(request.getParameter("specialite"));
        p.setDisponibilite(request.getParameter("disponibilite"));
    }
}
