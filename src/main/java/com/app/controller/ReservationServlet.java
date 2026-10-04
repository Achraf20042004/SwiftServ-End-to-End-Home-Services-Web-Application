package com.app.controller;

import com.app.model.Client;
import com.app.model.Prestataire;
import com.app.model.Reservation;
import com.app.service.ClientService;
import com.app.service.NotificationService;
import com.app.service.PrestataireService;
import com.app.service.ReservationService;
import com.app.service.ServiceDomicileService;
import com.app.service.ServiceException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Set;

/**
 * Réservations : le client réserve un service auprès d'un prestataire, le prestataire
 * accepte ou refuse ses demandes, l'administrateur gère l'ensemble.
 */
@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Set<String> STATUTS = Set.of("EN_ATTENTE", "CONFIRMEE", "EN_COURS", "TERMINEE", "ANNULEE", "REFUSEE");

    private ReservationService reservationService = new ReservationService();
    private ClientService clientService = new ClientService();
    private PrestataireService prestataireService = new PrestataireService();
    private ServiceDomicileService serviceDomicileService = new ServiceDomicileService();
    private NotificationService notificationService = new NotificationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";
        Object user = request.getSession().getAttribute("user");

        try {
            switch (action) {
                case "add":
                    if (user instanceof Client client) {
                        request.setAttribute("clientConnecte", client);
                    } else {
                        request.setAttribute("clients", clientService.lister());
                    }
                    request.setAttribute("prestataires", prestataireService.lister());
                    request.setAttribute("services", serviceDomicileService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/reservation/add.jsp").forward(request, response);
                    break;

                case "edit":
                    request.setAttribute("reservation", reservationService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.setAttribute("clients", clientService.lister());
                    request.setAttribute("prestataires", prestataireService.lister());
                    request.setAttribute("services", serviceDomicileService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/reservation/edit.jsp").forward(request, response);
                    break;

                default: {
                    List<Reservation> liste;
                    if (user instanceof Client client) {
                        liste = reservationService.listerParClient(client.getId());
                    } else if (user instanceof Prestataire prestataire) {
                        liste = reservationService.listerParPrestataire(prestataire.getId());
                    } else {
                        liste = reservationService.lister();
                    }
                    request.setAttribute("reservations", liste);
                    request.getRequestDispatcher("/WEB-INF/views/reservation/list.jsp").forward(request, response);
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
        Object user = request.getSession().getAttribute("user");

        try {
            if ("add".equals(action)) {
                Reservation r = new Reservation();
                r.setPrestataire(prestataireService.trouver(Integer.parseInt(request.getParameter("prestataireId"))));
                r.setService(serviceDomicileService.trouver(Integer.parseInt(request.getParameter("serviceId"))));

                if (user instanceof Client client) {
                    // Un client réserve toujours pour lui-même, et la demande démarre "en attente"
                    r.setClient(client);
                    r.setStatut("EN_ATTENTE");
                } else {
                    r.setClient(clientService.trouver(Integer.parseInt(request.getParameter("clientId"))));
                    r.setStatut(lireStatut(request.getParameter("statut")));
                }

                reservationService.ajouter(r);
                notificationService.creerNotification(r.getClient(),
                        "Votre réservation #" + r.getId() + " pour \"" + r.getService().getNom() + "\" a été créée avec succès.");
                response.sendRedirect("reservation?action=list");
            }
            else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Reservation r = reservationService.trouver(id);
                String ancienStatut = r.getStatut();
                String nouveauStatut = lireStatut(request.getParameter("statut"));

                r.setStatut(nouveauStatut);
                r.setClient(clientService.trouver(Integer.parseInt(request.getParameter("clientId"))));
                r.setPrestataire(prestataireService.trouver(Integer.parseInt(request.getParameter("prestataireId"))));
                r.setService(serviceDomicileService.trouver(Integer.parseInt(request.getParameter("serviceId"))));
                reservationService.modifier(r);

                notifierChangement(r, ancienStatut, nouveauStatut);
                response.sendRedirect("reservation?action=list");
            }
            else if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Reservation r = reservationService.trouver(id);
                String nouveauStatut = lireStatut(request.getParameter("status"));

                // Un prestataire ne traite que les demandes qui lui sont adressées
                if (user instanceof Prestataire prestataire && r.getPrestataire().getId() != prestataire.getId()) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }

                String ancienStatut = r.getStatut();
                reservationService.updateStatus(id, nouveauStatut);
                notifierChangement(r, ancienStatut, nouveauStatut);
                response.sendRedirect("dashboard");
            }
            else if ("delete".equals(action)) {
                reservationService.supprimer(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("reservation?action=list");
            }
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    private String lireStatut(String statut) throws ServletException {
        if (!STATUTS.contains(statut)) {
            throw new ServletException("Statut de réservation invalide");
        }
        return statut;
    }

    private void notifierChangement(Reservation r, String ancienStatut, String nouveauStatut) throws ServiceException {
        if (nouveauStatut.equals(ancienStatut)) {
            return;
        }
        int id = r.getId();
        String service = r.getService().getNom();
        switch (nouveauStatut) {
            case "CONFIRMEE":
                notificationService.notifierReservationConfirmee(r.getClient(), id, service);
                break;
            case "ANNULEE":
                notificationService.notifierReservationAnnulee(r.getClient(), id, service);
                break;
            case "EN_COURS":
                notificationService.creerNotification(r.getClient(),
                        "Votre réservation #" + id + " pour \"" + service + "\" a été acceptée par le prestataire.");
                break;
            case "REFUSEE":
                notificationService.creerNotification(r.getClient(),
                        "Votre réservation #" + id + " pour \"" + service + "\" a été refusée par le prestataire.");
                break;
            case "TERMINEE":
                notificationService.creerNotification(r.getClient(),
                        "Votre réservation #" + id + " pour \"" + service + "\" est terminée. N'hésitez pas à laisser un avis !");
                break;
            default:
                break;
        }
    }
}
