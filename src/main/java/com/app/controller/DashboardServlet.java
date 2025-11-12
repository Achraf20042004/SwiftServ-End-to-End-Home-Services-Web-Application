package com.app.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Vérifier si l’utilisateur est connecté
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login");
            return;
        }

        String role = (String) session.getAttribute("role");

        switch (role.toUpperCase()) {
            case "ADMIN":
                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
                break;
            case "CLIENT":
                request.getRequestDispatcher("/WEB-INF/views/client/dashboard.jsp").forward(request, response);
                break;
            case "PRESTATAIRE":
                request.getRequestDispatcher("/WEB-INF/views/prestataire/dashboard.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("login");
                break;
        }
    }
}
