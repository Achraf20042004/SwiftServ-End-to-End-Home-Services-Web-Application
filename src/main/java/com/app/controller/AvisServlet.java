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

import java.io.IOException;
import java.util.List;

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

        try {
            switch (action) {

                case "add": {
                    List<Client> clients = clientService.lister();
                    List<Prestataire> prestataires = prestataireService.lister();
                    request.setAttribute("clients", clients);
                    request.setAttribute("prestataires", prestataires);

                    request.getRequestDispatcher("/WEB-INF/views/avis/add.jsp")
                           .forward(request, response);
                    break;
                }

                case "edit": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Avis avis = avisService.trouver(id);

                    List<Client> clients = clientService.lister();
                    List<Prestataire> prestataires = prestataireService.lister();

                    request.setAttribute("avis", avis);
                    request.setAttribute("clients", clients);
                    request.setAttribute("prestataires", prestataires);

                    request.getRequestDispatcher("/WEB-INF/views/avis/edit.jsp")
                           .forward(request, response);
                    break;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    avisService.supprimer(id);
                    response.sendRedirect("avis?action=list");
                    break;
                }

                default: {
                    List<Avis> liste = avisService.lister();
                    request.setAttribute("avisList", liste);
                    request.getRequestDispatcher("/WEB-INF/views/avis/list.jsp")
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

                Avis avis = new Avis();
                avis.setNote(Integer.parseInt(request.getParameter("note")));
                avis.setCommentaire(request.getParameter("commentaire"));

                int clientId = Integer.parseInt(request.getParameter("clientId"));
                int prestataireId = Integer.parseInt(request.getParameter("prestataireId"));

                avis.setClient(clientService.trouver(clientId));
                avis.setPrestataire(prestataireService.trouver(prestataireId));

                avisService.ajouter(avis);
                response.sendRedirect("avis?action=list");
            }

            else if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Avis avis = avisService.trouver(id);

                avis.setNote(Integer.parseInt(request.getParameter("note")));
                avis.setCommentaire(request.getParameter("commentaire"));

                int clientId = Integer.parseInt(request.getParameter("clientId"));
                int prestataireId = Integer.parseInt(request.getParameter("prestataireId"));

                avis.setClient(clientService.trouver(clientId));
                avis.setPrestataire(prestataireService.trouver(prestataireId));

                avisService.modifier(avis);
                response.sendRedirect("avis?action=list");
            }

        } catch (ServiceException e) {
            throw new ServletException(e);
        }
    }
}
