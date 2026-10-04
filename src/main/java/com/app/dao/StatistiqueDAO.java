package com.app.dao;

import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

public class StatistiqueDAO {

    public long countClients() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM Client c", Long.class).getSingleResult();
        } finally { em.close(); }
    }

    public long countPrestataires() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(p) FROM Prestataire p", Long.class).getSingleResult();
        } finally { em.close(); }
    }

    public long countReservations() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Reservation r", Long.class).getSingleResult();
        } finally { em.close(); }
    }

    public long countByStatut(String statut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.statut = :s", Long.class)
                    .setParameter("s", statut).getSingleResult();
        } finally { em.close(); }
    }

 
    public long countReservationsToday() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate today = LocalDate.now();
            Date start = Date.from(today.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(today.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            return em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.dateReservation >= :s AND r.dateReservation < :e", Long.class)
                    .setParameter("s", start).setParameter("e", end).getSingleResult();
        } finally { em.close(); }
    }

  
    public long countReservationsThisWeek() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate today = LocalDate.now();
            LocalDate startOfWeek = today.minusDays(today.getDayOfWeek().getValue() - 1);
            Date start = Date.from(startOfWeek.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(today.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            return em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.dateReservation >= :s AND r.dateReservation < :e", Long.class)
                    .setParameter("s", start).setParameter("e", end).getSingleResult();
        } finally { em.close(); }
    }

   
    public long countReservationsThisMonth() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate first = LocalDate.now().withDayOfMonth(1);
            Date start = Date.from(first.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(first.plusMonths(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            return em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.dateReservation >= :s AND r.dateReservation < :e", Long.class)
                    .setParameter("s", start).setParameter("e", end).getSingleResult();
        } finally { em.close(); }
    }


    public double revenueThisMonth() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate first = LocalDate.now().withDayOfMonth(1);
            Date start = Date.from(first.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(first.plusMonths(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            Double total = em.createQuery(
                "SELECT COALESCE(SUM(s.prix), 0) FROM Reservation r JOIN r.service s WHERE r.statut = 'TERMINEE' AND r.dateReservation >= :s AND r.dateReservation < :e", Double.class)
                .setParameter("s", start).setParameter("e", end).getSingleResult();
            return total != null ? total : 0;
        } finally { em.close(); }
    }

 
    public double revenueThisWeek() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate today = LocalDate.now();
            LocalDate startOfWeek = today.minusDays(today.getDayOfWeek().getValue() - 1);
            Date start = Date.from(startOfWeek.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(today.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            Double total = em.createQuery(
                "SELECT COALESCE(SUM(s.prix), 0) FROM Reservation r JOIN r.service s WHERE r.statut = 'TERMINEE' AND r.dateReservation >= :s AND r.dateReservation < :e", Double.class)
                .setParameter("s", start).setParameter("e", end).getSingleResult();
            return total != null ? total : 0;
        } finally { em.close(); }
    }

  
    public double revenueToday() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate today = LocalDate.now();
            Date start = Date.from(today.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(today.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            Double total = em.createQuery(
                "SELECT COALESCE(SUM(s.prix), 0) FROM Reservation r JOIN r.service s WHERE r.statut = 'TERMINEE' AND r.dateReservation >= :s AND r.dateReservation < :e", Double.class)
                .setParameter("s", start).setParameter("e", end).getSingleResult();
            return total != null ? total : 0;
        } finally { em.close(); }
    }

   
    @SuppressWarnings("unchecked")
    public List<Object[]> getTopServices(int limit) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s.nom, COUNT(r) FROM Reservation r JOIN r.service s GROUP BY s.nom ORDER BY COUNT(r) DESC")
                    .setMaxResults(limit).getResultList();
        } finally { em.close(); }
    }

   
    @SuppressWarnings("unchecked")
    public List<Object[]> getTopPrestataires(int limit) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p.nom, p.prenom, p.specialite, COUNT(r), COALESCE(AVG(a.note), 0) " +
                "FROM Prestataire p LEFT JOIN p.reservations r LEFT JOIN p.avis a " +
                "GROUP BY p.id, p.nom, p.prenom, p.specialite ORDER BY COUNT(r) DESC")
                .setMaxResults(limit).getResultList();
        } finally { em.close(); }
    }



    @SuppressWarnings("unchecked")
    public List<Object[]> getReservationsByMonth(int year) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createNativeQuery(
                "SELECT MONTH(dateReservation) as mois, COUNT(*) as total " +
                "FROM reservations " +
                "WHERE YEAR(dateReservation) = :y " +
                "GROUP BY MONTH(dateReservation) " +
                "ORDER BY MONTH(dateReservation)")
                .setParameter("y", year)
                .getResultList();
        } finally { 
            em.close(); 
        }
    }

   
    public double getAverageRating() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Double avg = em.createQuery("SELECT COALESCE(AVG(a.note), 0) FROM Avis a", Double.class).getSingleResult();
            return avg != null ? avg : 0;
        } finally { em.close(); }
    }
    
 // Dans com.app.dao.StatistiqueDAO
    public long countReclamationsByStatut(String statut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Reclamation r WHERE r.statut = :s", Long.class)
                     .setParameter("s", statut)
                     .getSingleResult();
        } finally {
            em.close();
        }
    }
    
}