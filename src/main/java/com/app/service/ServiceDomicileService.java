package com.app.service;

import java.util.logging.Level;
import java.util.logging.Logger;

import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;
import com.app.dao.GenericDAO;
import com.app.model.ServiceDomicile;
import java.util.List;

public class ServiceDomicileService {

    private static final Logger LOGGER = Logger.getLogger(ServiceDomicileService.class.getName());

    private GenericDAO<ServiceDomicile> dao = new GenericDAO<>(ServiceDomicile.class);

    public void ajouter(ServiceDomicile service) throws ServiceException {
        try {
            dao.save(service);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout du service à domicile", e);
        }
    }

    public ServiceDomicile trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche du service à domicile", e);
        }
    }

    public List<ServiceDomicile> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des services à domicile", e);
        }
    }

    public void modifier(ServiceDomicile service) throws ServiceException {
        try {
            dao.update(service);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification du service à domicile", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression du service à domicile", e);
        }
    }

    public List<ServiceDomicile> listerPopulaires(int limit) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            List<ServiceDomicile> services = em.createQuery(
                "SELECT s FROM ServiceDomicile s LEFT JOIN FETCH s.categorie ORDER BY s.id ASC", 
                ServiceDomicile.class)
                .setMaxResults(limit)
                .getResultList();
            return services;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, e.getMessage(), e);
            throw new ServiceException("Erreur lors de la récupération des services populaires", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }
}