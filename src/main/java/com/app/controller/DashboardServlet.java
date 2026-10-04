package com.app.controller;

import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.app.service.ClientService;
import com.app.service.PrestataireService;
import com.app.service.ServiceException;
import com.app.service.ReservationService;
import com.app.service.AvisService;
import com.app.service.InterventionService;
import com.app.service.ReclamationService;
import com.app.service.NotificationService;
import com.app.model.Client;
import com.app.model.Prestataire;
import com.app.model.Reservation;
import com.app.model.Avis;
import com.app.model.Notification;
import com.app.service.ServiceDomicileService;
import com.app.model.ServiceDomicile;


@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DashboardServlet.class.getName());

    private static final long serialVersionUID = 1L;

    private ClientService clientService = new ClientService();
    private PrestataireService prestataireService = new PrestataireService();
    private ReservationService reservationService = new ReservationService();
    private AvisService avisService = new AvisService();
    private InterventionService interventionService = new InterventionService();
    private ReclamationService reclamationService = new ReclamationService();
    private NotificationService notificationService = new NotificationService();
    private ServiceDomicileService serviceDomicileService = new ServiceDomicileService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login");
            return;
        }

        String role = ((String) session.getAttribute("role")).toUpperCase();

        switch (role) {

            case "ADMIN":
                try {
                    long totalClients = clientService.count();
                    long totalPrestataires = prestataireService.count();
                    long totalReservations = reservationService.count();
                    double revenuMoisAdmin = reservationService.getAdminRevenueCurrentMonth();

                    request.setAttribute("totalClients", totalClients);
                    request.setAttribute("totalPrestataires", totalPrestataires);
                    request.setAttribute("totalReservations", totalReservations);
                    request.setAttribute("revenuMoisAdmin", revenuMoisAdmin);

                } catch (ServiceException e) {
                    request.setAttribute("error", "Erreur lors du chargement des statistiques.");
                }

                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                       .forward(request, response);
                break;

            case "CLIENT":
                Client client = (Client) session.getAttribute("user");
                
                try {
                    // Statistiques réservations
                    request.setAttribute("reservationsTotal",
                            reservationService.countByClient(client.getId()));
                    request.setAttribute("reservationsEnCours",
                            reservationService.countByClientAndStatus(client.getId(), "EN_COURS"));
                    request.setAttribute("reservationsFutures",
                            reservationService.countFuturesByClient(client.getId()));
                } catch (ServiceException e) {
                    LOGGER.log(Level.WARNING, e.getMessage(), e);
                }
                
                try {
                    // Statistiques avis
                    long totalAvis = avisService.countByClient(client.getId());
                    double moyenneAvis = avisService.moyenneNoteClient(client.getId());
                    request.setAttribute("avisEnvoyes", totalAvis);
                    request.setAttribute("moyenneAvis", moyenneAvis);
                } catch (ServiceException e) {
                    LOGGER.log(Level.WARNING, e.getMessage(), e);
                }
                
                try {
                    // Réclamations
                    request.setAttribute("reclamationsTotal",
                            reclamationService.countByClient(client.getId()));
                } catch (ServiceException e) {
                    LOGGER.log(Level.WARNING, e.getMessage(), e);
                }
                
                try {
                    // Réservations récentes
                    List<Reservation> reservationsRecentes = reservationService.listerParClient(client.getId());
                    request.setAttribute("reservationsRecentes", reservationsRecentes);
                } catch (ServiceException e) {
                    LOGGER.log(Level.WARNING, e.getMessage(), e);
                }
                
                try {
                    // Notifications récentes
                    List<Notification> notificationsRecentes = notificationService.listerParClient(client.getId());
                    request.setAttribute("notificationsRecentes", notificationsRecentes);
                } catch (ServiceException e) {
                    LOGGER.log(Level.WARNING, e.getMessage(), e);
                }
                
                try {
                    // Avis
                    List<Avis> mesAvis = avisService.listerParClient(client.getId());
                    request.setAttribute("mesAvis", mesAvis);
                } catch (ServiceException e) {
                    LOGGER.log(Level.WARNING, e.getMessage(), e);
                }
                
                try {
                    // Services populaires
                    List<ServiceDomicile> servicesPopulaires = serviceDomicileService.lister();
                    if (servicesPopulaires.size() > 4) {
                        servicesPopulaires = servicesPopulaires.subList(0, 4);
                    }
                    request.setAttribute("servicesPopulaires", servicesPopulaires);
                } catch (ServiceException e) {
                    LOGGER.log(Level.WARNING, e.getMessage(), e);
                }
                
                request.getRequestDispatcher("/WEB-INF/views/client/dashboard.jsp")
                       .forward(request, response);
                break;

            case "PRESTATAIRE":
                try {
                    Prestataire p = (Prestataire) session.getAttribute("user");

                    // Statistiques réservations
                    request.setAttribute("demandesEnAttente",
                            reservationService.countByPrestataireAndStatus(p.getId(), "EN_ATTENTE"));

                    // Statistiques interventions
                    request.setAttribute("interventionsMois",
                            interventionService.countThisMonthByPrestataire(p.getId()));

                    request.setAttribute("interventionsEnCours",
                            interventionService.countByPrestataireAndStatus(p.getId(), "EN_COURS"));

                    request.setAttribute("interventionsTerminees",
                            interventionService.countByPrestataireAndStatus(p.getId(), "TERMINEE"));

                    // Revenu
                    request.setAttribute("revenuMoisPrestataire",
                            reservationService.getPrestataireRevenueCurrentMonth(p.getId()));

                    // Statistiques avis
                    long totalAvisPrestataire = avisService.countByPrestataire(p.getId());
                    double noteMoyenne = avisService.moyenneNotePrestataire(p.getId());
                    double tauxSatisfaction = avisService.tauxSatisfactionPrestataire(p.getId());
                    
                    request.setAttribute("totalAvis", totalAvisPrestataire);
                    request.setAttribute("noteMoyenne", noteMoyenne);
                    request.setAttribute("tauxSatisfaction", tauxSatisfaction);

                    // Listes pour affichage
                    List<Reservation> demandesEnAttenteList = 
                            reservationService.listByPrestataireAndStatus(p.getId(), "EN_ATTENTE");
                    List<Avis> avisRecus = avisService.listerParPrestataire(p.getId());
                    
                    request.setAttribute("demandesEnAttenteList", demandesEnAttenteList);
                    request.setAttribute("avisRecus", avisRecus);

                } catch (ServiceException e) {
                    LOGGER.log(Level.WARNING, e.getMessage(), e);
                    request.setAttribute("error", "Erreur lors du chargement des statistiques client: " + e.getMessage());
                }
                request.getRequestDispatcher("/WEB-INF/views/prestataire/dashboard.jsp")
                       .forward(request, response);
                break;

            default:
                response.sendRedirect("login");
                break;
        }
    }
}