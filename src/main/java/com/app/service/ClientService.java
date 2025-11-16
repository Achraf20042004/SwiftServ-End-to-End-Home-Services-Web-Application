package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Client;
import com.app.utils.JpaUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

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
    
    public Client trouverParEmail(String email) throws ServiceException {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Client> query = em.createQuery(
                    "SELECT c FROM Client c WHERE c.email = :email", Client.class);
            query.setParameter("email", email);

            // retourne le client s’il existe
            return query.getResultStream().findFirst().orElse(null);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche par email", e);
        } finally {
            em.close();
        }
    }
    public long count() throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(c) FROM Client c", Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des clients", e);
        } finally {
            if (em != null) em.close();
        }
    }

}
