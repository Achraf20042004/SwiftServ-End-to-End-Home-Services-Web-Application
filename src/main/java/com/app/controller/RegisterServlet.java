package com.app.controller;

import com.app.model.Client;
import com.app.model.Prestataire;
import com.app.service.AdminService;
import com.app.service.ClientService;
import com.app.service.PrestataireService;
import com.app.service.ServiceException;
import com.app.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int MIN_PASSWORD_LENGTH = 8;

    private final AdminService adminService = new AdminService();
    private final ClientService clientService = new ClientService();
    private final PrestataireService prestataireService = new PrestataireService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String motDePasse = request.getParameter("motDePasse");
        String role = request.getParameter("role"); // client / prestataire (jamais admin)

        if (isBlank(nom) || isBlank(prenom) || isBlank(email) || isBlank(motDePasse) || isBlank(role)) {
            erreur(request, response, "Veuillez remplir tous les champs obligatoires !");
            return;
        }
        if (motDePasse.length() < MIN_PASSWORD_LENGTH) {
            erreur(request, response, "Le mot de passe doit contenir au moins " + MIN_PASSWORD_LENGTH + " caractères.");
            return;
        }
        email = email.trim();

        try {
            boolean emailExistant =
                    adminService.trouverParEmail(email) != null ||
                    clientService.trouverParEmail(email) != null ||
                    prestataireService.trouverParEmail(email) != null;

            if (emailExistant) {
                erreur(request, response, "Cet email est déjà utilisé !");
                return;
            }

            String hash = PasswordUtil.hash(motDePasse);

            switch (role.toLowerCase()) {
                case "client":
                    Client client = new Client();
                    client.setNom(nom);
                    client.setPrenom(prenom);
                    client.setEmail(email);
                    client.setMotDePasse(hash);
                    client.setTelephone(telephone);
                    client.setRole("CLIENT");
                    clientService.ajouter(client);
                    break;

                case "prestataire":
                    Prestataire prestataire = new Prestataire();
                    prestataire.setNom(nom);
                    prestataire.setPrenom(prenom);
                    prestataire.setEmail(email);
                    prestataire.setMotDePasse(hash);
                    prestataire.setTelephone(telephone);
                    prestataire.setRole("PRESTATAIRE");
                    prestataireService.ajouter(prestataire);
                    break;

                default:
                    // Un compte administrateur ne peut pas être créé depuis l'inscription publique
                    erreur(request, response, "Rôle invalide !");
                    return;
            }

            request.setAttribute("success", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);

        } catch (ServiceException e) {
            throw new ServletException("Erreur lors de l'inscription", e);
        }
    }

    private static boolean isBlank(String value) {
        return value == null || value.isBlank();
    }

    private void erreur(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }
}
