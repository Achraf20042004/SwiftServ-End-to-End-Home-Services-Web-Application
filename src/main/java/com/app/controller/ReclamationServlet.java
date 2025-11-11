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

@WebServlet("/reclamation")
public class ReclamationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ReclamationService reclamationService = new ReclamationService();
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

                    request.getRequestDispatcher("/WEB-INF/views/reclamation/add.jsp")
                           .forward(request, response);
                    break;
                }

                case "edit": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Reclamation rec = reclamationService.trouver(id);

                    List<Client> clients = clientService.lister();

                    request.setAttribute("reclamation", rec);
                    request.setAttribute("clients", clients);

                    request.getRequestDispatcher("/WEB-INF/views/reclamation/edit.jsp")
                           .forward(request, response);
                    break;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    reclamationService.supprimer(id);
                    response.sendRedirect("reclamation?action=list");
                    break;
                }

                default: { // LIST
                    List<Reclamation> liste = reclamationService.lister();
                    request.setAttribute("reclamations", liste);

                    request.getRequestDispatcher("/WEB-INF/views/reclamation/list.jsp")
                           .forward(request, response);
                    break;
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

                Reclamation r = new Reclamation();
                r.setDescription(request.getParameter("description"));

                int clientId = Integer.parseInt(request.getParameter("clientId"));
                r.setClient(clientService.trouver(clientId));

                reclamationService.ajouter(r);
                response.sendRedirect("reclamation?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Reclamation r = reclamationService.trouver(id);

                r.setDescription(request.getParameter("description"));

                int clientId = Integer.parseInt(request.getParameter("clientId"));
                r.setClient(clientService.trouver(clientId));

                reclamationService.modifier(r);
                response.sendRedirect("reclamation?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
