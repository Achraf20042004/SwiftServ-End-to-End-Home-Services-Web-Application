package com.app.controller;

import com.app.model.Client;
import com.app.service.ClientService;
import com.app.service.ServiceException;
import com.app.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/** Gestion des clients (réservée aux administrateurs, voir AuthFilter). */
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
                    request.getRequestDispatcher("/WEB-INF/views/client/add.jsp").forward(request, response);
                    break;

                case "edit":
                    request.setAttribute("client", clientService.trouver(Integer.parseInt(request.getParameter("id"))));
                    request.getRequestDispatcher("/WEB-INF/views/client/edit.jsp").forward(request, response);
                    break;

                default:
                    request.setAttribute("clients", clientService.lister());
                    request.getRequestDispatcher("/WEB-INF/views/client/list.jsp").forward(request, response);
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
                Client client = new Client();
                remplir(client, request);
                client.setMotDePasse(PasswordUtil.hash(request.getParameter("motDePasse")));
                client.setRole("CLIENT");
                clientService.ajouter(client);
            }
            else if ("edit".equals(action)) {
                Client client = clientService.trouver(Integer.parseInt(request.getParameter("id")));
                remplir(client, request);
                clientService.modifier(client);
            }
            else if ("delete".equals(action)) {
                clientService.supprimer(Integer.parseInt(request.getParameter("id")));
            }
            response.sendRedirect("client?action=list");
        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }

    private void remplir(Client client, HttpServletRequest request) {
        client.setNom(request.getParameter("nom"));
        client.setPrenom(request.getParameter("prenom"));
        client.setEmail(request.getParameter("email"));
        client.setTelephone(request.getParameter("telephone"));
        client.setAdresse(request.getParameter("adresse"));
        client.setVille(request.getParameter("ville"));
        client.setCodePostal(request.getParameter("codePostal"));
    }
}
