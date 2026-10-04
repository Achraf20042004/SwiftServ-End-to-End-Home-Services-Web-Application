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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Interventions : le prestataire planifie et suit les interventions de ses propres réservations ;
 * l'administrateur gère toutes les interventions.
 */
@WebServlet("/intervention")
public class InterventionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String[] STATUTS = {"PLANIFIEE", "EN_COURS", "TERMINEE", "ANNULEE"};

    private InterventionService interventionService = new InterventionService();
    private PrestataireService prestataireService = new PrestataireService();
    private ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";
        Prestataire prestataire = prestataireConnecte(request);

        try {
            switch (action) {
                case "add":
                    if (prestataire != null) {
                        request.setAttribute("reservations", reservationService.listerParPrestataireDisponibles(prestataire.getId()));
                        request.setAttribute("prestataireConnecte", prestataire);
                    } else {
                        request.setAttribute("prestataires", prestataireService.lister());
                        request.setAttribute("reservations", reservationService.lister());
                    }
                    request.getRequestDispatcher("/WEB-INF/views/intervention/add.jsp").forward(request, response);
                    break;

                case "edit": {
                    Intervention intervention = interventionService.trouver(Integer.parseInt(request.getParameter("id")));
                    if (!peutModifier(prestataire, intervention)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    request.setAttribute("intervention", intervention);
                    request.setAttribute("prestataires", prestataire != null ? List.of(prestataire) : prestataireService.lister());
                    request.setAttribute("reservations", prestataire != null
                            ? reservationService.listerParPrestataire(prestataire.getId())
                            : reservationService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/intervention/edit.jsp").forward(request, response);
                    break;
                }

                default: {
                    if (prestataire != null) {
                        int pid = prestataire.getId();
                        request.setAttribute("interventions", interventionService.listerParPrestataire(pid));
                        request.setAttribute("countPlanifiee", interventionService.countByPrestataireAndStatus(pid, "PLANIFIEE"));
                        request.setAttribute("countEnCours", interventionService.countByPrestataireAndStatus(pid, "EN_COURS"));
                        request.setAttribute("countTerminee", interventionService.countByPrestataireAndStatus(pid, "TERMINEE"));
                        request.setAttribute("countAnnulee", interventionService.countByPrestataireAndStatus(pid, "ANNULEE"));
                    } else {
                        request.setAttribute("interventions", interventionService.lister());
                        request.setAttribute("countPlanifiee", interventionService.countByStatus("PLANIFIEE"));
                        request.setAttribute("countEnCours", interventionService.countByStatus("EN_COURS"));
                        request.setAttribute("countTerminee", interventionService.countByStatus("TERMINEE"));
                        request.setAttribute("countAnnulee", interventionService.countByStatus("ANNULEE"));
                    }
                    request.getRequestDispatcher("/WEB-INF/views/intervention/list.jsp").forward(request, response);
                }
            }
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        Prestataire prestataire = prestataireConnecte(request);

        try {
            if ("add".equals(action)) {
                Reservation reservation = reservationService.trouver(Integer.parseInt(request.getParameter("reservation_id")));

                Intervention intervention = new Intervention();
                intervention.setStatut(lireStatut(request));
                intervention.setDateIntervention(lireDate(request.getParameter("dateIntervention")));
                intervention.setReservation(reservation);

                if (prestataire != null) {
                    // Un prestataire ne planifie que ses propres réservations
                    if (reservation.getPrestataire().getId() != prestataire.getId()) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    intervention.setPrestataire(prestataire);
                } else {
                    intervention.setPrestataire(prestataireService.trouver(Integer.parseInt(request.getParameter("prestataire_id"))));
                }
                interventionService.ajouter(intervention);
            }
            else if ("edit".equals(action)) {
                Intervention intervention = interventionService.trouver(Integer.parseInt(request.getParameter("id")));
                if (!peutModifier(prestataire, intervention)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                intervention.setStatut(lireStatut(request));
                String date = request.getParameter("dateIntervention");
                if (date != null && !date.isEmpty()) {
                    intervention.setDateIntervention(lireDate(date));
                }
                // Seul l'administrateur peut réaffecter une intervention
                if (prestataire == null) {
                    intervention.setPrestataire(prestataireService.trouver(Integer.parseInt(request.getParameter("prestataire_id"))));
                    intervention.setReservation(reservationService.trouver(Integer.parseInt(request.getParameter("reservation_id"))));
                }
                interventionService.modifier(intervention);
            }
            else if ("delete".equals(action)) {
                interventionService.supprimer(Integer.parseInt(request.getParameter("id")));
            }
            response.sendRedirect("intervention?action=list");
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    private Prestataire prestataireConnecte(HttpServletRequest request) {
        Object user = request.getSession().getAttribute("user");
        return user instanceof Prestataire p ? p : null;
    }

    /** L'administrateur peut tout modifier ; un prestataire seulement ses interventions. */
    private boolean peutModifier(Prestataire prestataire, Intervention intervention) {
        return intervention != null
                && (prestataire == null || intervention.getPrestataire().getId() == prestataire.getId());
    }

    private String lireStatut(HttpServletRequest request) throws ServletException {
        String statut = request.getParameter("statut");
        for (String s : STATUTS) {
            if (s.equals(statut)) {
                return s;
            }
        }
        throw new ServletException("Statut d'intervention invalide");
    }

    private java.util.Date lireDate(String value) throws ServletException {
        try {
            return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(value);
        } catch (ParseException | NullPointerException e) {
            throw new ServletException("Format de date invalide", e);
        }
    }
}
