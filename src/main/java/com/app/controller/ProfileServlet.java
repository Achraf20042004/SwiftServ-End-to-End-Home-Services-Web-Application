package com.app.controller;

import com.app.model.Admin;
import com.app.model.Client;
import com.app.model.Prestataire;
import com.app.service.AdminService;
import com.app.service.ClientService;
import com.app.service.PrestataireService;
import com.app.service.ServiceException;
import com.app.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int MIN_PASSWORD_LENGTH = 8;

    private AdminService adminService = new AdminService();
    private ClientService clientService = new ClientService();
    private PrestataireService prestataireService = new PrestataireService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");
        request.setAttribute("user", session.getAttribute("user"));

        switch (role) {
            case "admin":
                request.getRequestDispatcher("/WEB-INF/views/admin/profile.jsp").forward(request, response);
                break;
            case "client":
                request.getRequestDispatcher("/WEB-INF/views/client/profile.jsp").forward(request, response);
                break;
            default:
                request.getRequestDispatcher("/WEB-INF/views/prestataire/profile.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");
        Object user = session.getAttribute("user");

        String newPassword = request.getParameter("newPassword");
        boolean changePassword = newPassword != null && !newPassword.isEmpty();
        if (changePassword && newPassword.length() < MIN_PASSWORD_LENGTH) {
            request.setAttribute("error", "Le nouveau mot de passe doit contenir au moins " + MIN_PASSWORD_LENGTH + " caractères.");
            doGet(request, response);
            return;
        }

        try {
            switch (role) {
                case "admin":
                    Admin admin = (Admin) user;
                    admin.setNom(request.getParameter("nom"));
                    admin.setPrenom(request.getParameter("prenom"));
                    admin.setEmail(request.getParameter("email"));
                    admin.setTelephone(request.getParameter("telephone"));
                    if (changePassword) {
                        admin.setMotDePasse(PasswordUtil.hash(newPassword));
                    }
                    adminService.modifier(admin);
                    session.setAttribute("user", admin);
                    break;

                case "client":
                    Client client = (Client) user;
                    client.setNom(request.getParameter("nom"));
                    client.setPrenom(request.getParameter("prenom"));
                    client.setEmail(request.getParameter("email"));
                    client.setTelephone(request.getParameter("telephone"));
                    client.setAdresse(request.getParameter("adresse"));
                    client.setVille(request.getParameter("ville"));
                    client.setCodePostal(request.getParameter("codePostal"));
                    if (changePassword) {
                        client.setMotDePasse(PasswordUtil.hash(newPassword));
                    }
                    clientService.modifier(client);
                    session.setAttribute("user", client);
                    break;

                default:
                    Prestataire prestataire = (Prestataire) user;
                    prestataire.setNom(request.getParameter("nom"));
                    prestataire.setPrenom(request.getParameter("prenom"));
                    prestataire.setEmail(request.getParameter("email"));
                    prestataire.setTelephone(request.getParameter("telephone"));
                    prestataire.setSpecialite(request.getParameter("specialite"));
                    prestataire.setDisponibilite(request.getParameter("disponibilite"));
                    if (changePassword) {
                        prestataire.setMotDePasse(PasswordUtil.hash(newPassword));
                    }
                    prestataireService.modifier(prestataire);
                    session.setAttribute("user", prestataire);
                    break;
            }
            request.setAttribute("success", "Profil mis à jour avec succès !");
        } catch (ServiceException e) {
            request.setAttribute("error", "Erreur lors de la mise à jour du profil");
        }
        doGet(request, response);
    }
}
