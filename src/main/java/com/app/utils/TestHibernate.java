package com.app.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

public class TestHibernate {
    public static void main(String[] args) {

        try {
            EntityManagerFactory emf = JpaUtil.getEntityManagerFactory();
            EntityManager em = emf.createEntityManager();

            System.out.println("✅ Connexion JPA/Hibernate réussie !");

            em.close();
            emf.close();

        } catch (Exception e) {
            System.out.println("❌ Erreur : " + e.getMessage());
            e.printStackTrace();
        }

    }
}
