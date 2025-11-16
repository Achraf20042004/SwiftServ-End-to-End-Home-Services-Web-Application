package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Reservation;
import com.app.utils.JpaUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

public class ReservationService {

    private GenericDAO<Reservation> dao = new GenericDAO<>(Reservation.class);

    // CRUD de base
    public void ajouter(Reservation reservation) throws ServiceException {
        try {
            dao.save(reservation);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de la réservation", e);
        }
    }

    public Reservation trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de la réservation", e);
        }
    }

    public List<Reservation> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des réservations", e);
        }
    }

    public void modifier(Reservation reservation) throws ServiceException {
        try {
            dao.update(reservation);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de la réservation", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de la réservation", e);
        }
    }

    public void updateStatus(int id, String status) throws ServiceException {
        try {
            Reservation r = trouver(id);
            r.setStatut(status);
            modifier(r);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la mise à jour du statut", e);
        }
    }

    public long count() throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery("SELECT COUNT(r) FROM Reservation r", Long.class)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du comptage des réservations", e);
        } finally { if (em != null) em.close(); }
    }

    // ------------------ CLIENT ------------------

    public List<Reservation> listerParClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Reservation> q = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.client.id = :cid ORDER BY r.dateReservation DESC",
                Reservation.class);
            q.setParameter("cid", clientId);
            return q.getResultList();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du listing des réservations du client", e);
        } finally {
            if (em != null) em.close();
        }
    }

    public long countByClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery(
                    "SELECT COUNT(r) FROM Reservation r WHERE r.client.id = :cid",
                    Long.class)
                    .setParameter("cid", clientId)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur comptage client", e);
        } finally { if (em != null) em.close(); }
    }

    public long countByClientAndStatus(int clientId, String statut)
            throws ServiceException {

        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery(
                    "SELECT COUNT(r) FROM Reservation r WHERE r.client.id = :cid AND r.statut = :st",
                    Long.class)
                    .setParameter("cid", clientId)
                    .setParameter("st", statut)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur comptage reservations client", e);
        } finally { if (em != null) em.close(); }
    }

    public long countFuturesByClient(int clientId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            Date now = new Date();
            return em.createQuery(
                    "SELECT COUNT(r) FROM Reservation r LEFT JOIN r.intervention i "
                            + "WHERE r.client.id = :cid AND (i.dateIntervention > :now OR i IS NULL)",
                    Long.class)
                    .setParameter("cid", clientId)
                    .setParameter("now", now)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur comptage futures réservations client", e);
        } finally { if (em != null) em.close(); }
    }

    // ------------------ PRESTATAIRE ------------------

    public List<Reservation> listerParPrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Reservation> q = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.prestataire.id = :pid ORDER BY r.dateReservation DESC",
                Reservation.class);
            q.setParameter("pid", prestataireId);
            return q.getResultList();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du listing des réservations du prestataire", e);
        } finally {
            if (em != null) em.close();
        }
    }

    public long countByPrestataire(int prestataireId) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery(
                    "SELECT COUNT(r) FROM Reservation r WHERE r.prestataire.id = :pid",
                    Long.class)
                    .setParameter("pid", prestataireId)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur comptage prestataire", e);
        } finally { if (em != null) em.close(); }
    }

    public long countByPrestataireAndStatus(int prestataireId, String statut)
            throws ServiceException {

        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            return em.createQuery(
                    "SELECT COUNT(r) FROM Reservation r WHERE r.prestataire.id = :pid AND r.statut = :st",
                    Long.class)
                    .setParameter("pid", prestataireId)
                    .setParameter("st", statut)
                    .getSingleResult();
        } catch (Exception e) {
            throw new ServiceException("Erreur comptage prestataire", e);
        } finally { if (em != null) em.close(); }
    }

    public List<Reservation> listByPrestataireAndStatus(int prestataireId, String statut) throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Reservation> q = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.prestataire.id = :pid AND r.statut = :st ORDER BY r.dateReservation DESC",
                Reservation.class);
            q.setParameter("pid", prestataireId);
            q.setParameter("st", statut);
            return q.getResultList();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du listing des réservations du prestataire par statut", e);
        } finally {
            if (em != null) em.close();
        }
    }

    public double getPrestataireRevenueCurrentMonth(int prestataireId)
            throws ServiceException {

        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();

            LocalDate first = LocalDate.now().withDayOfMonth(1);
            LocalDate last = first.withDayOfMonth(first.lengthOfMonth());

            Date start = Date.from(first.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(last.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

            TypedQuery<Double> q = em.createQuery(
                "SELECT COALESCE(SUM(s.prix), 0) FROM Reservation r JOIN r.service s " +
                "WHERE r.prestataire.id = :pid AND r.statut = 'TERMINEE' " +
                "AND r.dateReservation >= :start AND r.dateReservation < :end",
                Double.class);
            q.setParameter("pid", prestataireId);
            q.setParameter("start", start);
            q.setParameter("end", end);
            return q.getSingleResult();

        } catch (Exception e) {
            throw new ServiceException("Erreur revenu prestataire", e);
        } finally { if (em != null) em.close(); }
    }

    // ------------------ ADMIN ------------------

    public double getAdminRevenueCurrentMonth() throws ServiceException {
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();

            LocalDate first = LocalDate.now().withDayOfMonth(1);
            LocalDate last = first.withDayOfMonth(first.lengthOfMonth());

            Date start = Date.from(first.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(last.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

            TypedQuery<Double> q = em.createQuery(
                "SELECT COALESCE(SUM(s.prix), 0) FROM Reservation r JOIN r.service s " +
                "WHERE r.statut = 'TERMINEE' AND r.dateReservation >= :start AND r.dateReservation < :end",
                Double.class);
            q.setParameter("start", start);
            q.setParameter("end", end);
            Double total = q.getSingleResult();

            return total * 0.015;
        } catch (Exception e) {
            throw new ServiceException("Erreur revenu admin", e);
        } finally { if (em != null) em.close(); }
    }
}