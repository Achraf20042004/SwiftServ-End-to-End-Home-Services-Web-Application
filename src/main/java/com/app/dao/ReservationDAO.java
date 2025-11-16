package com.app.dao;

import com.app.model.Reservation;
import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

public class ReservationDAO {

    public List<Reservation> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT r FROM Reservation r ORDER BY r.dateReservation DESC", Reservation.class)
                    .getResultList();
        } finally { em.close(); }
    }

    public Reservation findById(int id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(Reservation.class, id); } finally { em.close(); }
    }

    public void delete(int id) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Reservation r = em.find(Reservation.class, id);
            if (r != null) em.remove(r);
            tx.commit();
        } finally {
            if (tx.isActive()) tx.rollback();
            em.close();
        }
    }

    public void updateStatus(int id, String status) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Reservation r = em.find(Reservation.class, id);
            if (r != null) {
                r.setStatut(status);
            }
            tx.commit();
        } finally {
            if (tx.isActive()) tx.rollback();
            em.close();
        }
    }

    public List<Reservation> findByPrestataireAndStatus(int prestataireId, String statut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Reservation> q = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.prestataire.id = :pid AND r.statut = :st ORDER BY r.dateReservation DESC",
                Reservation.class);
            q.setParameter("pid", prestataireId);
            q.setParameter("st", statut);
            return q.getResultList();
        } finally { em.close(); }
    }

    // ---- Counts ----
    public long countAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Reservation r", Long.class).getSingleResult();
        } finally { em.close(); }
    }

    public long countByClient(int clientId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.client.id = :cid", Long.class)
                     .setParameter("cid", clientId)
                     .getSingleResult();
        } finally { em.close(); }
    }

    public long countByClientAndStatus(int clientId, String statut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.client.id = :cid AND r.statut = :st", Long.class)
                     .setParameter("cid", clientId)
                     .setParameter("st", statut)
                     .getSingleResult();
        } finally { em.close(); }
    }

    public long countFuturesByClient(int clientId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Date now = new Date();
            return em.createQuery(
                    "SELECT COUNT(r) FROM Reservation r JOIN r.intervention i WHERE r.client.id = :cid AND i.dateIntervention > :now",
                    Long.class)
                    .setParameter("cid", clientId)
                    .setParameter("now", now)
                    .getSingleResult();
        } finally { em.close(); }
    }

    public long countByPrestataireAndStatus(int prestataireId, String statut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.prestataire.id = :pid AND r.statut = :st", Long.class)
                     .setParameter("pid", prestataireId)
                     .setParameter("st", statut)
                     .getSingleResult();
        } finally { em.close(); }
    }

    // ---- Revenus (basés sur Service.prix et statut TERMINEE) ----
    public double revenueAdminThisMonth() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate first = LocalDate.now().withDayOfMonth(1);
            LocalDate last = first.withDayOfMonth(first.lengthOfMonth());
            Date start = Date.from(first.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(last.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

            Double total = em.createQuery(
                "SELECT COALESCE(SUM(s.prix), 0) FROM Reservation r JOIN r.service s " +
                "WHERE r.statut = 'TERMINEE' AND r.dateReservation >= :start AND r.dateReservation < :end",
                Double.class)
                .setParameter("start", start)
                .setParameter("end", end)
                .getSingleResult();
            return total != null ? total : 0d;
        } finally { em.close(); }
    }

    public double revenuePrestataireThisMonth(int prestataireId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate first = LocalDate.now().withDayOfMonth(1);
            LocalDate last = first.withDayOfMonth(first.lengthOfMonth());
            Date start = Date.from(first.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(last.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

            Double total = em.createQuery(
                "SELECT COALESCE(SUM(s.prix), 0) FROM Reservation r JOIN r.service s " +
                "WHERE r.prestataire.id = :pid AND r.statut = 'TERMINEE' " +
                "AND r.dateReservation >= :start AND r.dateReservation < :end",
                Double.class)
                .setParameter("pid", prestataireId)
                .setParameter("start", start)
                .setParameter("end", end)
                .getSingleResult();
            return total != null ? total : 0d;
        } finally { em.close(); }
    }
}
package com.app.dao;

import com.app.model.Reservation;

public class ReservationDAO extends GenericDAO<Reservation> {

    public ReservationDAO() {
        super(Reservation.class);
    }
}
