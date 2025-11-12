package com.app.controller;

import com.app.model.Admin;
import com.app.model.Client;
import com.app.model.Prestataire;
import com.app.service.AdminService;
import com.app.service.ClientService;
import com.app.service.PrestataireService;
import com.app.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AdminService adminService = new AdminService();
    private final ClientService clientService = new ClientService();
    private final PrestataireService prestataireService = new PrestataireService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Si déjà connecté → redirige vers tableau de bord
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("dashboard");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");

        if (email == null || motDePasse == null || email.isEmpty() || motDePasse.isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs !");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        try {
            Object utilisateur = authentifier(email, motDePasse);
            if (utilisateur != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", utilisateur);

                // Déterminer le rôle et rediriger
                String role = utilisateur instanceof Admin ? "admin"
                             : utilisateur instanceof Client ? "client"
                             : "prestataire";

                session.setAttribute("role", role);
                response.sendRedirect("dashboard");
            } else {
                request.setAttribute("error", "Identifiants incorrects !");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            }
        } catch (ServiceException e) {
            throw new ServletException("Erreur lors de la connexion", e);
        }
    }

    private Object authentifier(String email, String motDePasse) throws ServiceException {
        Admin admin = adminService.trouverParEmail(email);
        if (admin != null && admin.getMotDePasse().equals(motDePasse)) return admin;

        Client client = clientService.trouverParEmail(email);
        if (client != null && client.getMotDePasse().equals(motDePasse)) return client;

        Prestataire prestataire = prestataireService.trouverParEmail(email);
        if (prestataire != null && prestataire.getMotDePasse().equals(motDePasse)) return prestataire;

        return null;
    }
}
