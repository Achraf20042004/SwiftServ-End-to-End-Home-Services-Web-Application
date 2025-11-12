package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Prestataire;
import com.app.utils.JpaUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class PrestataireService {

    private GenericDAO<Prestataire> dao = new GenericDAO<>(Prestataire.class);

    public void ajouter(Prestataire prestataire) throws ServiceException {
        try {
            dao.save(prestataire);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout du prestataire", e);
        }
    }

    public Prestataire trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche du prestataire", e);
        }
    }

    public List<Prestataire> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des prestataires", e);
        }
    }

    public void modifier(Prestataire prestataire) throws ServiceException {
        try {
            dao.update(prestataire);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification du prestataire", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression du prestataire", e);
        }
    }
    
    
    public Prestataire trouverParEmail(String email) throws ServiceException {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Prestataire> query = em.createQuery(
                    "SELECT p FROM Prestataire p WHERE p.email = :email", Prestataire.class);
            query.setParameter("email", email);
            return query.getResultStream().findFirst().orElse(null);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche d'un prestataire par email", e);
        } finally {
            em.close();
        }
    }

}
