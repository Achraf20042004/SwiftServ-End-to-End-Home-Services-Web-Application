package com.app.dao;

import com.app.model.Admin;
import com.app.utils.JpaUtil;
import jakarta.persistence.EntityManager;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

public class AdminDAO extends GenericDAO<Admin> {

    public AdminDAO() {
        super(Admin.class);
    }

    public long countAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(a) FROM Admin a", Long.class).getSingleResult();
        } finally { em.close(); }
    }

    public long countThisMonth() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate first = LocalDate.now().withDayOfMonth(1);
            Date start = Date.from(first.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date end = Date.from(first.plusMonths(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            return em.createQuery("SELECT COUNT(a) FROM Admin a WHERE a.dateInscription >= :s AND a.dateInscription < :e", Long.class)
                    .setParameter("s", start).setParameter("e", end).getSingleResult();
        } finally { em.close(); }
    }
}