package com.app.controller;

import com.app.model.Admin;
import com.app.service.AdminService;
import com.app.service.ServiceException;
import com.app.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/** Gestion des administrateurs (réservée aux administrateurs, voir AuthFilter). */
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
                    request.getRequestDispatcher("/WEB-INF/views/admin/add.jsp").forward(request, response);
                    break;

                case "edit":
                    request.setAttribute("admin", adminService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.getRequestDispatcher("/WEB-INF/views/admin/edit.jsp").forward(request, response);
                    break;

                default:
                    request.setAttribute("admins", adminService.lister());
                    request.setAttribute("totalAdmins", adminService.compterTotal());
                    request.setAttribute("adminsActifs", adminService.compterTotal());
                    request.setAttribute("adminsCeMois", adminService.compterCeMois());
                    request.getRequestDispatcher("/WEB-INF/views/admin/list.jsp").forward(request, response);
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
                Admin admin = new Admin();
                admin.setNom(request.getParameter("nom"));
                admin.setPrenom(request.getParameter("prenom"));
                admin.setEmail(request.getParameter("email"));
                admin.setMotDePasse(PasswordUtil.hash(request.getParameter("motDePasse")));
                admin.setTelephone(request.getParameter("telephone"));
                admin.setRole("ADMIN");
                adminService.ajouter(admin);
            }
            else if ("edit".equals(action)) {
                Admin admin = adminService.trouver(Integer.parseInt(request.getParameter("id")));
                admin.setNom(request.getParameter("nom"));
                admin.setPrenom(request.getParameter("prenom"));
                admin.setEmail(request.getParameter("email"));
                admin.setTelephone(request.getParameter("telephone"));
                adminService.modifier(admin);
            }
            else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Admin connecte = (Admin) request.getSession().getAttribute("user");
                // Un administrateur ne peut pas supprimer son propre compte
                if (connecte.getId() != id) {
                    adminService.supprimer(id);
                }
            }
            response.sendRedirect("admin?action=list");
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
