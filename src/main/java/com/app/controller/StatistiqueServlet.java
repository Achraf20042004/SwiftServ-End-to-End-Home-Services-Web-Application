package com.app.controller;

import com.app.model.Statistique;
import com.app.service.StatistiqueService;
import com.app.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/statistiques")
public class StatistiqueServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private StatistiqueService statistiqueService = new StatistiqueService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Statistique stats = statistiqueService.getStatistiques();
            request.setAttribute("stats", stats);

            request.getRequestDispatcher("/WEB-INF/views/statistiques/dashboard.jsp")
                   .forward(request, response);

        } catch (ServiceException e) {
            throw new ServletException("Erreur lors du chargement des statistiques", e);
        }
    }
}
