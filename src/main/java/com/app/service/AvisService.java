package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Avis;
import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class AvisService {

    private GenericDAO<Avis> dao = new GenericDAO<>(Avis.class);

    public void ajouter(Avis avis) throws ServiceException {
        try {
            dao.save(avis);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de l'avis", e);
        }
    }

    public Avis trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de l'avis", e);
        }
    }

    public List<Avis> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des avis", e);
        }
    }

    public List<Avis> listerParClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Avis> q = em.createQuery(
                "SELECT a FROM Avis a LEFT JOIN FETCH a.client LEFT JOIN FETCH a.prestataire WHERE a.client.id = :cid ORDER BY a.id DESC",
                Avis.class);
            q.setParameter("cid", clientId);
            return q.getResultList();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du listing des avis du client", e);
        } finally {
            if (em != null) em.close();
        }
    }

    public List<Avis> listerParPrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Avis> q = em.createQuery(
                "SELECT a FROM Avis a LEFT JOIN FETCH a.client LEFT JOIN FETCH a.prestataire WHERE a.prestataire.id = :pid ORDER BY a.id DESC",
                Avis.class);
            q.setParameter("pid", prestataireId);
            return q.getResultList();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du listing des avis du prestataire", e);
        } finally {
            if (em != null) em.close();
        }
    }

    public void modifier(Avis avis) throws ServiceException {
        try {
            dao.update(avis);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de l'avis", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de l'avis", e);
        }
    }

  
    public long countTotal() throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery("SELECT COUNT(a) FROM Avis a", Long.class)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage total des avis", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }

    public double moyenneGenerale() throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            Double avg = em.createQuery(
                    "SELECT AVG(a.note) FROM Avis a", Double.class)
                    .getSingleResult();
            return avg != null ? Math.round(avg * 10.0) / 10.0 : 0.0;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du calcul de la note moyenne générale", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }

    public double tauxSatisfaction() throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            
            Long total = em.createQuery("SELECT COUNT(a) FROM Avis a", Long.class)
                    .getSingleResult();
            
            if (total == 0) return 0.0;
            
            Long satisfaits = em.createQuery(
                    "SELECT COUNT(a) FROM Avis a WHERE a.note >= 4", Long.class)
                    .getSingleResult();
            
            return Math.round((satisfaits * 100.0 / total) * 10.0) / 10.0;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du calcul du taux de satisfaction", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }

   
    public long countByClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery(
                    "SELECT COUNT(a) FROM Avis a WHERE a.client.id = :cid", Long.class)
                    .setParameter("cid", clientId)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des avis du client", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }

    public double moyenneNoteClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            Double avg = em.createQuery(
                    "SELECT AVG(a.note) FROM Avis a WHERE a.client.id = :cid", Double.class)
                    .setParameter("cid", clientId)
                    .getSingleResult();
            return avg != null ? Math.round(avg * 10.0) / 10.0 : 0.0;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du calcul de la note moyenne du client", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }


    public long countByPrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery(
                    "SELECT COUNT(a) FROM Avis a WHERE a.prestataire.id = :pid", Long.class)
                    .setParameter("pid", prestataireId)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des avis du prestataire", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }

    public double moyenneNotePrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            Double avg = em.createQuery(
                    "SELECT AVG(a.note) FROM Avis a WHERE a.prestataire.id = :pid", Double.class)
                    .setParameter("pid", prestataireId)
                    .getSingleResult();
            return avg != null ? Math.round(avg * 10.0) / 10.0 : 0.0;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du calcul de la note moyenne du prestataire", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }

    public double tauxSatisfactionPrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            
            Long total = em.createQuery(
                    "SELECT COUNT(a) FROM Avis a WHERE a.prestataire.id = :pid", Long.class)
                    .setParameter("pid", prestataireId)
                    .getSingleResult();
            
            if (total == 0) return 0.0;
            
            Long satisfaits = em.createQuery(
                    "SELECT COUNT(a) FROM Avis a WHERE a.prestataire.id = :pid AND a.note >= 4", Long.class)
                    .setParameter("pid", prestataireId)
                    .getSingleResult();
            
            return Math.round((satisfaits * 100.0 / total) * 10.0) / 10.0;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du calcul du taux de satisfaction du prestataire", e);
        } finally { 
            if (em != null) em.close(); 
        }
    }
}