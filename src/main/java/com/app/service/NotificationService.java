package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Client;
import com.app.model.Notification;
import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.Date;
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

    public List<Notification> listerParClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Notification> q = em.createQuery(
                "SELECT n FROM Notification n WHERE n.client.id = :cid ORDER BY n.dateNotification DESC",
                Notification.class);
            q.setParameter("cid", clientId);
            return q.getResultList();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du listing des notifications du client", e);
        } finally {
            if (em != null) em.close();
        }
    }

    public long countByClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery(
                "SELECT COUNT(n) FROM Notification n WHERE n.client.id = :cid", Long.class)
                .setParameter("cid", clientId)
                .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des notifications", e);
        } finally {
            if (em != null) em.close();
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

   
    
    public void creerNotification(Client client, String message) throws ServiceException {
        Notification notif = new Notification();
        notif.setClient(client);
        notif.setMessage(message);
        notif.setDateNotification(new Date());
        ajouter(notif);
    }

    public void notifierReservationConfirmee(Client client, int reservationId, String serviceName) throws ServiceException {
        String message = "Votre réservation #" + reservationId + " pour \"" + serviceName + "\" a été confirmée.";
        creerNotification(client, message);
    }

    public void notifierReservationAnnulee(Client client, int reservationId, String serviceName) throws ServiceException {
        String message = "Votre réservation #" + reservationId + " pour \"" + serviceName + "\" a été annulée.";
        creerNotification(client, message);
    }

    public void notifierInterventionPlanifiee(Client client, int interventionId, String serviceName, Date dateIntervention) throws ServiceException {
        String message = "Une intervention #" + interventionId + " pour \"" + serviceName + "\" a été planifiée.";
        creerNotification(client, message);
    }

    public void notifierInterventionTerminee(Client client, int interventionId, String serviceName) throws ServiceException {
        String message = "L'intervention #" + interventionId + " pour \"" + serviceName + "\" est terminée. N'hésitez pas à laisser un avis !";
        creerNotification(client, message);
    }
}