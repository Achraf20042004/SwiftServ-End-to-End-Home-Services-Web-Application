package com.app.dao;

import com.app.model.Intervention;
import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

public class InterventionDAO extends GenericDAO<Intervention> {

    public InterventionDAO() {
        super(Intervention.class);
    }

    public long countByPrestataire(int prestataireId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(i) FROM Intervention i WHERE i.prestataire.id = :pid", Long.class)
                     .setParameter("pid", prestataireId)
                     .getSingleResult();
        } finally { em.close(); }
    }

    public long countByPrestataireAndStatus(int prestataireId, String statut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(i) FROM Intervention i WHERE i.prestataire.id = :pid AND i.statut = :st", Long.class)
                     .setParameter("pid", prestataireId)
                     .setParameter("st", statut)
                     .getSingleResult();
        } finally { em.close(); }
    }

    public long countThisMonthByPrestataire(int prestataireId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate first = LocalDate.now().withDayOfMonth(1);
            LocalDate last = first.withDayOfMonth(first.lengthOfMonth());
            Date start = Date.from(first.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(last.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            return em.createQuery("SELECT COUNT(i) FROM Intervention i WHERE i.prestataire.id = :pid AND i.dateIntervention >= :start AND i.dateIntervention < :end", Long.class)
                     .setParameter("pid", prestataireId)
                     .setParameter("start", start)
                     .setParameter("end", end)
                     .getSingleResult();
        } finally { em.close(); }
    }
}
