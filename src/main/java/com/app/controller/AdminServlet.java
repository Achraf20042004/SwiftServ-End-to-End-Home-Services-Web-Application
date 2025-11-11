package com.app.controller;

import com.app.model.Admin;
import com.app.service.AdminService;
import com.app.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {

                case "add":
                    request.getRequestDispatcher("/WEB-INF/views/admin/add.jsp")
                           .forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    Admin admin = adminService.trouver(idEdit);
                    request.setAttribute("admin", admin);
                    request.getRequestDispatcher("/WEB-INF/views/admin/edit.jsp")
                           .forward(request, response);
                    break;

                case "delete":
                    int idDelete = Integer.parseInt(request.getParameter("id"));
                    adminService.supprimer(idDelete);
                    response.sendRedirect("admin?action=list");
                    break;

                default: // LIST
                    List<Admin> liste = adminService.lister();
                    request.setAttribute("admins", liste);
                    request.getRequestDispatcher("/WEB-INF/views/admin/list.jsp")
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

                Admin admin = new Admin();
                admin.setNom(request.getParameter("nom"));
                admin.setPrenom(request.getParameter("prenom"));
                admin.setEmail(request.getParameter("email"));
                admin.setMotDePasse(request.getParameter("motDePasse"));
                admin.setTelephone(request.getParameter("telephone"));
                admin.setRole("ADMIN");

                adminService.ajouter(admin);
                response.sendRedirect("admin?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Admin admin = adminService.trouver(id);

                admin.setNom(request.getParameter("nom"));
                admin.setPrenom(request.getParameter("prenom"));
                admin.setEmail(request.getParameter("email"));
                admin.setTelephone(request.getParameter("telephone"));

                adminService.modifier(admin);
                response.sendRedirect("admin?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
