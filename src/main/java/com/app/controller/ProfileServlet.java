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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminService adminService = new AdminService();
    private ClientService clientService = new ClientService();
    private PrestataireService prestataireService = new PrestataireService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        String role = (String) session.getAttribute("role");
        Object user = session.getAttribute("user");

        request.setAttribute("user", user);

        switch (role.toLowerCase()) {
            case "admin":
                request.getRequestDispatcher("/WEB-INF/views/admin/profile.jsp").forward(request, response);
                break;
            case "client":
                request.getRequestDispatcher("/WEB-INF/views/client/profile.jsp").forward(request, response);
                break;
            case "prestataire":
                request.getRequestDispatcher("/WEB-INF/views/prestataire/profile.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("login");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String role = (String) session.getAttribute("role");
        Object user = session.getAttribute("user");

        try {
            switch (role.toLowerCase()) {
                case "admin":
                    Admin admin = (Admin) user;
                    admin.setNom(request.getParameter("nom"));
                    admin.setPrenom(request.getParameter("prenom"));
                    admin.setEmail(request.getParameter("email"));
                    admin.setTelephone(request.getParameter("telephone"));
                    
                    String newPassword = request.getParameter("newPassword");
                    if (newPassword != null && !newPassword.isEmpty()) {
                        admin.setMotDePasse(newPassword);
                    }
                    
                    adminService.modifier(admin);
                    session.setAttribute("user", admin);
                    request.setAttribute("success", "Profil mis à jour avec succès !");
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
                    
                    String clientNewPassword = request.getParameter("newPassword");
                    if (clientNewPassword != null && !clientNewPassword.isEmpty()) {
                        client.setMotDePasse(clientNewPassword);
                    }
                    
                    clientService.modifier(client);
                    session.setAttribute("user", client);
                    request.setAttribute("success", "Profil mis à jour avec succès !");
                    break;

                case "prestataire":
                    Prestataire prestataire = (Prestataire) user;
                    prestataire.setNom(request.getParameter("nom"));
                    prestataire.setPrenom(request.getParameter("prenom"));
                    prestataire.setEmail(request.getParameter("email"));
                    prestataire.setTelephone(request.getParameter("telephone"));
                    prestataire.setSpecialite(request.getParameter("specialite"));
                    prestataire.setDisponibilite(request.getParameter("disponibilite"));
                    
                    String prestataireNewPassword = request.getParameter("newPassword");
                    if (prestataireNewPassword != null && !prestataireNewPassword.isEmpty()) {
                        prestataire.setMotDePasse(prestataireNewPassword);
                    }
                    
                    prestataireService.modifier(prestataire);
                    session.setAttribute("user", prestataire);
                    request.setAttribute("success", "Profil mis à jour avec succès !");
                    break;
            }

            doGet(request, response);

        } catch (ServiceException e) {
            request.setAttribute("error", "Erreur lors de la mise à jour du profil");
            doGet(request, response);
        }
    }
}