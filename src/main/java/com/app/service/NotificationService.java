package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Notification;
import java.util.List;

public class NotificationService {

    private GenericDAO<Notification> dao = new GenericDAO<>(Notification.class);

    public void ajouter(Notification notif) throws ServiceException {
        try {
            dao.save(notif);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de la notification", e);
        }
    }

    public Notification trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de la notification", e);
        }
    }

    public List<Notification> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des notifications", e);
        }
    }

    public void modifier(Notification notif) throws ServiceException {
        try {
            dao.update(notif);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de la notification", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de la notification", e);
        }
    }
}
