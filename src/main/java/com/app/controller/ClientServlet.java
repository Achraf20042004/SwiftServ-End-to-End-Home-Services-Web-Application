package com.app.controller;

import com.app.model.Client;
import com.app.service.ClientService;
import com.app.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/client")
public class ClientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ClientService clientService = new ClientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {

            switch (action) {

                case "add":
                    request.getRequestDispatcher("/WEB-INF/views/client/add.jsp")
                           .forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    Client client = clientService.trouver(idEdit);
                    request.setAttribute("client", client);
                    request.getRequestDispatcher("/WEB-INF/views/client/edit.jsp")
                           .forward(request, response);
                    break;

                case "delete":
                    int idDelete = Integer.parseInt(request.getParameter("id"));
                    clientService.supprimer(idDelete);
                    response.sendRedirect("client?action=list");
                    break;

                default: // LIST
                    List<Client> liste = clientService.lister();
                    request.setAttribute("clients", liste);
                    request.getRequestDispatcher("/WEB-INF/views/client/list.jsp")
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

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                Client client = new Client();
                client.setNom(request.getParameter("nom"));
                client.setPrenom(request.getParameter("prenom"));
                client.setEmail(request.getParameter("email"));
                client.setMotDePasse(request.getParameter("motDePasse"));
                client.setTelephone(request.getParameter("telephone"));
                client.setAdresse(request.getParameter("adresse"));
                client.setVille(request.getParameter("ville"));
                client.setCodePostal(request.getParameter("codePostal"));

                clientService.ajouter(client);
                response.sendRedirect("client?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Client client = clientService.trouver(id);

                client.setNom(request.getParameter("nom"));
                client.setPrenom(request.getParameter("prenom"));
                client.setEmail(request.getParameter("email"));
                client.setTelephone(request.getParameter("telephone"));
                client.setAdresse(request.getParameter("adresse"));
                client.setVille(request.getParameter("ville"));
                client.setCodePostal(request.getParameter("codePostal"));

                clientService.modifier(client);
                response.sendRedirect("client?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
