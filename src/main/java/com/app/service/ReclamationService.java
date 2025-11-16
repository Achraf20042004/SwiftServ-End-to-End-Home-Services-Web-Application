package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Reclamation;
import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ReclamationService {

    private GenericDAO<Reclamation> dao = new GenericDAO<>(Reclamation.class);

    public void ajouter(Reclamation reclamation) throws ServiceException {
        try {
            dao.save(reclamation);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de la réclamation", e);
        }
    }

    public Reclamation trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de la réclamation", e);
        }
    }

    public List<Reclamation> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des réclamations", e);
        }
    }

    public void modifier(Reclamation reclamation) throws ServiceException {
        try {
            dao.update(reclamation);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de la réclamation", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de la réclamation", e);
        }
    }

    // --- Agrégation ---
    public long countByClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery("SELECT COUNT(r) FROM Reclamation r WHERE r.client.id = :cid", Long.class)
                     .setParameter("cid", clientId)
                     .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des réclamations du client", e);
        } finally { if (em != null) em.close(); }
    }
}
