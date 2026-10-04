package com.app.controller;

import com.app.model.Admin;
import com.app.model.Client;
import com.app.model.Prestataire;
import com.app.model.Utilisateur;
import com.app.service.AdminService;
import com.app.service.ClientService;
import com.app.service.PrestataireService;
import com.app.service.ServiceException;
import com.app.utils.PasswordUtil;

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

        if (email == null || motDePasse == null || email.isBlank() || motDePasse.isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs !");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        try {
            Utilisateur utilisateur = authentifier(email.trim(), motDePasse);

            if (utilisateur == null) {
                request.setAttribute("error", "Identifiants incorrects !");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            // Nouvelle session après connexion (protection contre la fixation de session)
            HttpSession ancienne = request.getSession(false);
            if (ancienne != null) {
                ancienne.invalidate();
            }
            HttpSession session = request.getSession(true);
            session.setAttribute("user", utilisateur);
            session.setAttribute("role", utilisateur instanceof Admin ? "admin"
                                       : utilisateur instanceof Client ? "client"
                                       : "prestataire");

            response.sendRedirect("dashboard");

        } catch (ServiceException e) {
            throw new ServletException("Erreur lors de la connexion", e);
        }
    }

    private Utilisateur authentifier(String email, String motDePasse) throws ServiceException {
        Admin admin = adminService.trouverParEmail(email);
        if (admin != null && verifier(admin, motDePasse)) {
            mettreAJourHashSiNecessaire(admin, motDePasse);
            return admin;
        }

        Client client = clientService.trouverParEmail(email);
        if (client != null && verifier(client, motDePasse)) {
            mettreAJourHashSiNecessaire(client, motDePasse);
            return client;
        }

        Prestataire prestataire = prestataireService.trouverParEmail(email);
        if (prestataire != null && verifier(prestataire, motDePasse)) {
            mettreAJourHashSiNecessaire(prestataire, motDePasse);
            return prestataire;
        }

        return null;
    }

    private boolean verifier(Utilisateur utilisateur, String motDePasse) {
        String stocke = utilisateur.getMotDePasse();
        // Comptes créés avant le hachage : mot de passe encore en clair en base
        return PasswordUtil.isHashed(stocke)
                ? PasswordUtil.verify(motDePasse, stocke)
                : motDePasse.equals(stocke);
    }

    /** Remplace un ancien mot de passe en clair par son hash dès la première connexion réussie. */
    private void mettreAJourHashSiNecessaire(Utilisateur utilisateur, String motDePasse) throws ServiceException {
        if (PasswordUtil.isHashed(utilisateur.getMotDePasse())) {
            return;
        }
        utilisateur.setMotDePasse(PasswordUtil.hash(motDePasse));
        if (utilisateur instanceof Admin admin) {
            adminService.modifier(admin);
        } else if (utilisateur instanceof Client client) {
            clientService.modifier(client);
        } else if (utilisateur instanceof Prestataire prestataire) {
            prestataireService.modifier(prestataire);
        }
    }
}
