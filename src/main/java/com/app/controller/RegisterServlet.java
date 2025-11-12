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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        String role = request.getParameter("role"); // admin / client / prestataire

        if (nom == null || prenom == null || email == null || motDePasse == null || role == null
                || nom.isEmpty() || prenom.isEmpty() || email.isEmpty() || motDePasse.isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs obligatoires !");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        try {
            // Vérification si email déjà utilisé
            boolean emailExistant =
                    adminService.trouverParEmail(email) != null ||
                    clientService.trouverParEmail(email) != null ||
                    prestataireService.trouverParEmail(email) != null;

            if (emailExistant) {
                request.setAttribute("error", "Cet email est déjà utilisé !");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                return;
            }

            // Création de l’utilisateur selon le rôle
         // Création de l’utilisateur selon le rôle
            switch (role.toLowerCase()) {
                case "admin":
                    Admin admin = new Admin();
                    admin.setNom(nom);
                    admin.setPrenom(prenom);
                    admin.setEmail(email);
                    admin.setMotDePasse(motDePasse);
                    admin.setTelephone(telephone);
                    admin.setRole("ADMIN");
                    adminService.ajouter(admin);
                    break;

                case "client":
                    Client client = new Client();
                    client.setNom(nom);
                    client.setPrenom(prenom);
                    client.setEmail(email);
                    client.setMotDePasse(motDePasse);
                    client.setTelephone(telephone);
                    client.setRole("CLIENT");
                    clientService.ajouter(client);
                    break;

                case "prestataire":
                    Prestataire prestataire = new Prestataire();
                    prestataire.setNom(nom);
                    prestataire.setPrenom(prenom);
                    prestataire.setEmail(email);
                    prestataire.setMotDePasse(motDePasse);
                    prestataire.setTelephone(telephone);
                    prestataire.setRole("PRESTATAIRE");
                    prestataireService.ajouter(prestataire);
                    break;

                default:
                    request.setAttribute("error", "Rôle invalide !");
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                    return;
            }


            // Succès
            request.setAttribute("success", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);

        } catch (ServiceException e) {
            throw new ServletException("Erreur lors de l'inscription", e);
        }
    }
}
