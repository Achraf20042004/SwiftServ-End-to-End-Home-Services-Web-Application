package com.app.controller;

import com.app.model.Intervention;
import com.app.model.Prestataire;
import com.app.model.Reservation;
import com.app.service.InterventionService;
import com.app.service.PrestataireService;
import com.app.service.ReservationService;
import com.app.service.ServiceException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/intervention")
public class InterventionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private InterventionService interventionService = new InterventionService();
    private PrestataireService prestataireService = new PrestataireService();
    private ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {

                case "add":
                    List<Prestataire> prestataires = prestataireService.lister();
                    List<Reservation> reservations = reservationService.lister();

                    request.setAttribute("prestataires", prestataires);
                    request.setAttribute("reservations", reservations);

                    request.getRequestDispatcher("/WEB-INF/views/intervention/add.jsp")
                           .forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    Intervention intervention = interventionService.trouver(idEdit);

                    request.setAttribute("intervention", intervention);
                    request.setAttribute("prestataires", prestataireService.lister());
                    request.setAttribute("reservations", reservationService.lister());

                    request.getRequestDispatcher("/WEB-INF/views/intervention/edit.jsp")
                           .forward(request, response);
                    break;

                case "delete":
                    int idDelete = Integer.parseInt(request.getParameter("id"));
                    interventionService.supprimer(idDelete);
                    response.sendRedirect("intervention?action=list");
                    break;

                default: // LIST
                    List<Intervention> liste = interventionService.lister();
                    request.setAttribute("interventions", liste);
                    request.getRequestDispatcher("/WEB-INF/views/intervention/list.jsp")
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

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {
                Intervention intervention = new Intervention();

                intervention.setStatut(request.getParameter("statut"));
                intervention.setPrestataire(
                        prestataireService.trouver(Integer.parseInt(request.getParameter("prestataire_id")))
                );
                intervention.setReservation(
                        reservationService.trouver(Integer.parseInt(request.getParameter("reservation_id")))
                );

                interventionService.ajouter(intervention);
                response.sendRedirect("intervention?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Intervention intervention = interventionService.trouver(id);

                intervention.setStatut(request.getParameter("statut"));
                intervention.setPrestataire(
                        prestataireService.trouver(Integer.parseInt(request.getParameter("prestataire_id")))
                );
                intervention.setReservation(
                        reservationService.trouver(Integer.parseInt(request.getParameter("reservation_id")))
                );

                interventionService.modifier(intervention);
                response.sendRedirect("intervention?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
