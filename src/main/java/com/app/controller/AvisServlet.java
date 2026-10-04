package com.app.controller;

import com.app.model.Avis;
import com.app.model.Client;
import com.app.model.Prestataire;
import com.app.service.AvisService;
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
import java.util.List;

/**
 * Avis : un client note les prestataires avec qui il a eu une réservation terminée ;
 * le prestataire voit les avis reçus ; l'administrateur gère tous les avis.
 */
@WebServlet("/avis")
public class AvisServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AvisService avisService = new AvisService();
    private ClientService clientService = new ClientService();
    private PrestataireService prestataireService = new PrestataireService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        try {
            switch (action) {
                case "add": {
                    if (user instanceof Client client) {
                        request.setAttribute("clientConnecte", client);
                        request.setAttribute("prestataires", prestataireService.listerParClient(client.getId()));
                    } else {
                        request.setAttribute("clients", clientService.lister());
                        request.setAttribute("prestataires", prestataireService.lister());
                    }
                    request.getRequestDispatcher("/WEB-INF/views/avis/add.jsp").forward(request, response);
                    break;
                }

                case "edit": {
                    request.setAttribute("avis", avisService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.setAttribute("clients", clientService.lister());
                    request.setAttribute("prestataires", prestataireService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/avis/edit.jsp").forward(request, response);
                    break;
                }

                default: {
                    List<Avis> liste;
                    double noteMoyenne;
                    long totalAvis;
                    double tauxSatisfaction;

                    if (user instanceof Client client) {
                        liste = avisService.listerParClient(client.getId());
                        noteMoyenne = avisService.moyenneNoteClient(client.getId());
                        totalAvis = avisService.countByClient(client.getId());
                        tauxSatisfaction = liste.isEmpty() ? 0
                                : liste.stream().filter(a -> a.getNote() >= 4).count() * 100.0 / liste.size();
                    } else if (user instanceof Prestataire prestataire) {
                        liste = avisService.listerParPrestataire(prestataire.getId());
                        noteMoyenne = avisService.moyenneNotePrestataire(prestataire.getId());
                        totalAvis = avisService.countByPrestataire(prestataire.getId());
                        tauxSatisfaction = avisService.tauxSatisfactionPrestataire(prestataire.getId());
                    } else {
                        liste = avisService.lister();
                        noteMoyenne = avisService.moyenneGenerale();
                        totalAvis = avisService.countTotal();
                        tauxSatisfaction = avisService.tauxSatisfaction();
                    }

                    request.setAttribute("avisList", liste);
                    request.setAttribute("noteMoyenne", noteMoyenne);
                    request.setAttribute("totalAvis", totalAvis);
                    request.setAttribute("tauxSatisfaction", tauxSatisfaction);
                    request.getRequestDispatcher("/WEB-INF/views/avis/list.jsp").forward(request, response);
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
                int note = lireNote(request);
                int prestataireId = Integer.parseInt(request.getParameter("prestataireId"));

                Avis avis = new Avis();
                avis.setNote(note);
                avis.setCommentaire(request.getParameter("commentaire"));

                if (user instanceof Client client) {
                    // Un client ne peut noter qu'un prestataire avec qui il a une réservation terminée
                    boolean autorise = prestataireService.listerParClient(client.getId()).stream()
                            .anyMatch(p -> p.getId() == prestataireId);
                    if (!autorise) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    avis.setClient(client);
                } else {
                    avis.setClient(clientService.trouver(Integer.parseInt(request.getParameter("clientId"))));
                }
                avis.setPrestataire(prestataireService.trouver(prestataireId));
                avisService.ajouter(avis);
            }
            else if ("edit".equals(action)) {
                Avis avis = avisService.trouver(Integer.parseInt(request.getParameter("id")));
                avis.setNote(lireNote(request));
                avis.setCommentaire(request.getParameter("commentaire"));
                avis.setClient(clientService.trouver(Integer.parseInt(request.getParameter("clientId"))));
                avis.setPrestataire(prestataireService.trouver(Integer.parseInt(request.getParameter("prestataireId"))));
                avisService.modifier(avis);
            }
            else if ("delete".equals(action)) {
                avisService.supprimer(Integer.parseInt(request.getParameter("id")));
            }
            response.sendRedirect("avis?action=list");
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    /** Note entre 1 et 5. */
    private int lireNote(HttpServletRequest request) throws ServletException {
        int note = Integer.parseInt(request.getParameter("note"));
        if (note < 1 || note > 5) {
            throw new ServletException("La note doit être comprise entre 1 et 5");
        }
        return note;
    }
}
