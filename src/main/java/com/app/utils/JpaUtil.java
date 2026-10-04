package com.app.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Classe utilitaire pour gérer l'EntityManagerFactory et les EntityManagers JPA
 * Pattern Singleton pour éviter les multiples créations d'EntityManagerFactory
 */
public class JpaUtil {

    private static final Logger LOGGER = Logger.getLogger(JpaUtil.class.getName());
    private static final String PERSISTENCE_UNIT_NAME = "servicesPU";
    private static EntityManagerFactory entityManagerFactory;

    // Initialisation statique de l'EntityManagerFactory
    static {
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME, connectionOverrides());
            LOGGER.info("✅ EntityManagerFactory créé avec succès");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "❌ Erreur lors de la création de l'EntityManagerFactory", e);
            throw new ExceptionInInitializerError(e);
        }
    }

    /**
     * Paramètres de connexion lus dans les variables d'environnement, pour ne pas
     * garder d'identifiants dans le code (sinon : valeurs de persistence.xml).
     */
    private static Map<String, String> connectionOverrides() {
        Map<String, String> props = new HashMap<>();
        putIfSet(props, "jakarta.persistence.jdbc.url", "DB_URL");
        putIfSet(props, "jakarta.persistence.jdbc.user", "DB_USER");
        putIfSet(props, "jakarta.persistence.jdbc.password", "DB_PASSWORD");
        return props;
    }

    private static void putIfSet(Map<String, String> props, String property, String envVar) {
        String value = System.getenv(envVar);
        if (value != null) {
            props.put(property, value);
        }
    }

    /**
     * Retourne un nouvel EntityManager
     * IMPORTANT: L'appelant doit fermer l'EntityManager après utilisation
     */
    public static EntityManager getEntityManager() {
        if (entityManagerFactory == null || !entityManagerFactory.isOpen()) {
            throw new IllegalStateException("EntityManagerFactory n'est pas initialisé ou est fermé");
        }
        return entityManagerFactory.createEntityManager();
    }

    /**
     * Retourne l'EntityManagerFactory (pour tests ou usages avancés)
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }

    /**
     * Ferme l'EntityManagerFactory
     * À appeler lors de l'arrêt de l'application
     */
    public static void close() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            try {
                entityManagerFactory.close();
                LOGGER.info("✅ EntityManagerFactory fermé avec succès");
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "❌ Erreur lors de la fermeture de l'EntityManagerFactory", e);
            }
        }
    }

    /**
     * Ferme un EntityManager en toute sécurité
     */
    public static void closeEntityManager(EntityManager em) {
        if (em != null && em.isOpen()) {
            try {
                em.close();
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "Erreur lors de la fermeture de l'EntityManager", e);
            }
        }
    }

    /**
     * Vérifie si l'EntityManagerFactory est ouvert
     */
    public static boolean isOpen() {
        return entityManagerFactory != null && entityManagerFactory.isOpen();
    }

    // Constructeur privé pour empêcher l'instanciation
    private JpaUtil() {
        throw new AssertionError("Cette classe ne doit pas être instanciée");
    }
}