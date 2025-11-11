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

@WebServlet("/notification")
public class NotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private NotificationService notificationService = new NotificationService();
    private ClientService clientService = new ClientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {

                case "add": {
                    List<Client> clients = clientService.lister();
                    request.setAttribute("clients", clients);
                    request.getRequestDispatcher("/WEB-INF/views/notification/add.jsp")
                           .forward(request, response);
                    break;
                }

                case "edit": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Notification notification = notificationService.trouver(id);

                    List<Client> clients = clientService.lister();

                    request.setAttribute("notification", notification);
                    request.setAttribute("clients", clients);

                    request.getRequestDispatcher("/WEB-INF/views/notification/edit.jsp")
                           .forward(request, response);
                    break;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    notificationService.supprimer(id);
                    response.sendRedirect("notification?action=list");
                    break;
                }

                default: {
                    List<Notification> liste = notificationService.lister();
                    request.setAttribute("notifications", liste);
                    request.getRequestDispatcher("/WEB-INF/views/notification/list.jsp")
                           .forward(request, response);
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

                Notification n = new Notification();
                n.setMessage(request.getParameter("message"));

                int clientId = Integer.parseInt(request.getParameter("clientId"));
                n.setClient(clientService.trouver(clientId));

                notificationService.ajouter(n);
                response.sendRedirect("notification?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Notification n = notificationService.trouver(id);

                n.setMessage(request.getParameter("message"));

                int clientId = Integer.parseInt(request.getParameter("clientId"));
                n.setClient(clientService.trouver(clientId));

                notificationService.modifier(n);
                response.sendRedirect("notification?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
