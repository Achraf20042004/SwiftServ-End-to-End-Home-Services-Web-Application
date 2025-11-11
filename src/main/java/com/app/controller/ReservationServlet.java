package com.app.controller;

import java.io.IOException;
import java.util.List;

import com.app.model.Reservation;
import com.app.service.ClientService;
import com.app.service.PrestataireService;
import com.app.service.ReservationService;
import com.app.service.ServiceDomicileService;
import com.app.service.ServiceException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationService reservationService = new ReservationService();
    private ClientService clientService = new ClientService();
    private PrestataireService prestataireService = new PrestataireService();
    private ServiceDomicileService serviceDomicileService = new ServiceDomicileService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {

            switch (action) {

                case "add":
                    // Charger clients + prestataires + services pour formulaire
                    request.setAttribute("clients", clientService.lister());
                    request.setAttribute("prestataires", prestataireService.lister());
                    request.setAttribute("services", serviceDomicileService.lister());

                    request.getRequestDispatcher("/WEB-INF/views/reservation/add.jsp")
                           .forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    Reservation r = reservationService.trouver(idEdit);

                    request.setAttribute("reservation", r);
                    request.setAttribute("clients", clientService.lister());
                    request.setAttribute("prestataires", prestataireService.lister());
                    request.setAttribute("services", serviceDomicileService.lister());

                    request.getRequestDispatcher("/WEB-INF/views/reservation/edit.jsp")
                           .forward(request, response);
                    break;

                case "delete":
                    int idDelete = Integer.parseInt(request.getParameter("id"));
                    reservationService.supprimer(idDelete);
                    response.sendRedirect("reservation?action=list");
                    break;

                default: // list
                    List<Reservation> liste = reservationService.lister();
                    request.setAttribute("reservations", liste);

                    request.getRequestDispatcher("/WEB-INF/views/reservation/list.jsp")
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

                Reservation r = new Reservation();
                r.setStatut(request.getParameter("statut"));

                int clientId = Integer.parseInt(request.getParameter("clientId"));
                int prestataireId = Integer.parseInt(request.getParameter("prestataireId"));
                int serviceId = Integer.parseInt(request.getParameter("serviceId"));

                r.setClient(clientService.trouver(clientId));
                r.setPrestataire(prestataireService.trouver(prestataireId));
                r.setService(serviceDomicileService.trouver(serviceId));

                reservationService.ajouter(r);
                response.sendRedirect("reservation?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Reservation r = reservationService.trouver(id);

                r.setStatut(request.getParameter("statut"));

                int clientId = Integer.parseInt(request.getParameter("clientId"));
                int prestataireId = Integer.parseInt(request.getParameter("prestataireId"));
                int serviceId = Integer.parseInt(request.getParameter("serviceId"));

                r.setClient(clientService.trouver(clientId));
                r.setPrestataire(prestataireService.trouver(prestataireId));
                r.setService(serviceDomicileService.trouver(serviceId));

                reservationService.modifier(r);
                response.sendRedirect("reservation?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
