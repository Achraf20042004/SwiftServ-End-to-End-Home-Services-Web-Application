package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Intervention;
import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

public class InterventionService {

    private GenericDAO<Intervention> dao = new GenericDAO<>(Intervention.class);

    public void ajouter(Intervention intervention) throws ServiceException {
        try {
            dao.save(intervention);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de l'intervention", e);
        }
    }

    public Intervention trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de l'intervention", e);
        }
    }

    public List<Intervention> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des interventions", e);
        }
    }

    public void modifier(Intervention intervention) throws ServiceException {
        try {
            dao.update(intervention);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de l'intervention", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de l'intervention", e);
        }
    }

    public List<Intervention> listerParPrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery(
                    "SELECT i FROM Intervention i WHERE i.prestataire.id = :pid ORDER BY i.dateIntervention DESC",
                    Intervention.class)
                     .setParameter("pid", prestataireId)
                     .getResultList();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du listing des interventions du prestataire", e);
        } finally { if (em != null) em.close(); }
    }

    // --- Agrégations pour Dashboard Prestataire ---
    public long countByPrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Long> q = em.createQuery("SELECT COUNT(i) FROM Intervention i WHERE i.prestataire.id = :pid", Long.class);
            q.setParameter("pid", prestataireId);
            return q.getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des interventions du prestataire", e);
        } finally { if (em != null) em.close(); }
    }

    public long countByPrestataireAndStatus(int prestataireId, String statut) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Long> q = em.createQuery("SELECT COUNT(i) FROM Intervention i WHERE i.prestataire.id = :pid AND i.statut = :st", Long.class);
            q.setParameter("pid", prestataireId);
            q.setParameter("st", statut);
            return q.getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des interventions par statut", e);
        } finally { if (em != null) em.close(); }
    }

    public long countThisMonthByPrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            LocalDate firstDay = LocalDate.now().withDayOfMonth(1);
            LocalDate lastDay = firstDay.withDayOfMonth(firstDay.lengthOfMonth());
            Date start = Date.from(firstDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(lastDay.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            TypedQuery<Long> q = em.createQuery(
                "SELECT COUNT(i) FROM Intervention i WHERE i.prestataire.id = :pid AND i.dateIntervention >= :start AND i.dateIntervention < :end",
                Long.class);
            q.setParameter("pid", prestataireId);
            q.setParameter("start", start);
            q.setParameter("end", end);
            return q.getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des interventions du mois", e);
        } finally { if (em != null) em.close(); }
    }
    
    public long countByStatus(String statut) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Long> q = em.createQuery("SELECT COUNT(i) FROM Intervention i WHERE i.statut = :st", Long.class);
            q.setParameter("st", statut);
            return q.getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des interventions par statut", e);
        } finally { if (em != null) em.close(); }
    }

    public long countTotal() throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Long> q = em.createQuery("SELECT COUNT(i) FROM Intervention i", Long.class);
            return q.getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage total des interventions", e);
        } finally { if (em != null) em.close(); }
    }
}
