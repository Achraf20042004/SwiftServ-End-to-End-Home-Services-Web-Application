package com.app.controller;

import com.app.model.Client;
import com.app.model.Notification;
import com.app.service.ClientService;
import com.app.service.NotificationService;
import com.app.service.ServiceException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/** Notifications : le client voit les siennes ; l'administrateur en envoie et les gère toutes. */
@WebServlet("/notification")
public class NotificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int MAX_LENGTH = 300; // taille de la colonne "message"

    private NotificationService notificationService = new NotificationService();
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
                    request.setAttribute("clients", clientService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/notification/add.jsp").forward(request, response);
                    break;

                case "edit":
                    request.setAttribute("notification", notificationService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.setAttribute("clients", clientService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/notification/edit.jsp").forward(request, response);
                    break;

                default: {
                    List<Notification> liste;
                    if (user instanceof Client client) {
                        liste = notificationService.listerParClient(client.getId());
                    } else {
                        liste = notificationService.lister();
                    }
                    request.setAttribute("notifications", liste);
                    request.setAttribute("totalNotifications", (long) liste.size());
                    request.getRequestDispatcher("/WEB-INF/views/notification/list.jsp").forward(request, response);
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

        try {
            if ("add".equals(action)) {
                String message = composerMessage(request.getParameter("titre"), request.getParameter("message"));

                if ("all".equals(request.getParameter("recipientType"))) {
                    for (Client client : clientService.lister()) {
                        notificationService.creerNotification(client, message);
                    }
                } else {
                    Client client = clientService.trouver(Integer.parseInt(request.getParameter("userId")));
                    notificationService.creerNotification(client, message);
                }
            }
            else if ("edit".equals(action)) {
                Notification n = notificationService.trouver(Integer.parseInt(request.getParameter("id")));
                n.setMessage(composerMessage(null, request.getParameter("message")));
                n.setClient(clientService.trouver(Integer.parseInt(request.getParameter("clientId"))));
                notificationService.modifier(n);
            }
            else if ("delete".equals(action)) {
                notificationService.supprimer(Integer.parseInt(request.getParameter("id")));
            }
            response.sendRedirect("notification?action=list");
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    /** "Titre : message", tronqué à la taille de la colonne. */
    private String composerMessage(String titre, String message) throws ServletException {
        if (message == null || message.isBlank()) {
            throw new ServletException("Le message est obligatoire");
        }
        String complet = (titre == null || titre.isBlank()) ? message.trim() : titre.trim() + " : " + message.trim();
        return complet.length() > MAX_LENGTH ? complet.substring(0, MAX_LENGTH) : complet;
    }
}
