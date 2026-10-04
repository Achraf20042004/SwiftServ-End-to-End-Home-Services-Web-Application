package com.app.controller;

import com.app.model.Client;
import com.app.model.Reclamation;
import com.app.service.ClientService;
import com.app.service.ReclamationService;
import com.app.service.ServiceException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Set;

/** Réclamations : le client dépose et suit les siennes ; l'administrateur les traite. */
@WebServlet("/reclamation")
public class ReclamationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Set<String> STATUTS = Set.of("EN_ATTENTE", "EN_COURS", "RESOLUE", "FERMEE");

    private ReclamationService reclamationService = new ReclamationService();
    private ClientService clientService = new ClientService();

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
                    request.getRequestDispatcher("/WEB-INF/views/reclamation/add.jsp").forward(request, response);
                    break;

                case "edit":
                    request.setAttribute("reclamation", reclamationService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.setAttribute("clients", clientService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/reclamation/edit.jsp").forward(request, response);
                    break;

                default: {
                    List<Reclamation> liste = user instanceof Client client
                            ? reclamationService.listerParClient(client.getId())
                            : reclamationService.lister();

                    request.setAttribute("reclamations", liste);
                    request.setAttribute("countEnAttente", liste.stream().filter(r -> "EN_ATTENTE".equals(r.getStatut())).count());
                    request.setAttribute("countEnCours", liste.stream().filter(r -> "EN_COURS".equals(r.getStatut())).count());
                    request.setAttribute("countResolue", liste.stream().filter(r -> "RESOLUE".equals(r.getStatut())).count());
                    request.getRequestDispatcher("/WEB-INF/views/reclamation/list.jsp").forward(request, response);
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
                Reclamation r = new Reclamation();
                r.setDescription(composerDescription(request.getParameter("objet"), request.getParameter("description")));
                // Le client dépose toujours la réclamation en son nom, avec le statut initial
                r.setClient(user instanceof Client client
                        ? client
                        : clientService.trouver(Integer.parseInt(request.getParameter("clientId"))));
                reclamationService.ajouter(r);
            }
            else if ("edit".equals(action)) {
                Reclamation r = reclamationService.trouver(Integer.parseInt(request.getParameter("id")));
                r.setDescription(request.getParameter("description"));
                r.setClient(clientService.trouver(Integer.parseInt(request.getParameter("clientId"))));
                String statut = request.getParameter("statut");
                if (STATUTS.contains(statut)) {
                    r.setStatut(statut);
                }
                reclamationService.modifier(r);
            }
            else if ("delete".equals(action)) {
                reclamationService.supprimer(Integer.parseInt(request.getParameter("id")));
            }
            response.sendRedirect("reclamation?action=list");
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    /** "Objet : description", limité à la taille de la colonne (500). */
    private String composerDescription(String objet, String description) throws ServletException {
        if (description == null || description.isBlank()) {
            throw new ServletException("La description est obligatoire");
        }
        String texte = (objet == null || objet.isBlank()) ? description.trim() : objet.trim() + " : " + description.trim();
        return texte.length() > 500 ? texte.substring(0, 500) : texte;
    }
}
