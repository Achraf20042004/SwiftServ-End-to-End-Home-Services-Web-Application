package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Client;
import java.util.List;

public class ClientService {

    private GenericDAO<Client> dao = new GenericDAO<>(Client.class);

    public void ajouter(Client client) throws ServiceException {
        try {
            dao.save(client);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout du client", e);
        }
    }

    public Client trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche du client", e);
        }
    }

    public List<Client> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des clients", e);
        }
    }

    public void modifier(Client client) throws ServiceException {
        try {
            dao.update(client);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification du client", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression du client", e);
        }
    }
}
