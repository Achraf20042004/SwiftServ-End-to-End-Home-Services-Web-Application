package com.app.utils;

import com.app.model.Admin;
import com.app.service.AdminService;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Démarrage / arrêt de l'application : initialise JPA (création des tables),
 * crée le premier administrateur (ADMIN_EMAIL / ADMIN_PASSWORD) s'il n'en existe aucun,
 * et ferme l'EntityManagerFactory à l'arrêt.
 */
@WebListener
public class AppStartupListener implements ServletContextListener {

    private static final Logger LOGGER = Logger.getLogger(AppStartupListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent event) {
        JpaUtil.getEntityManagerFactory();
        creerAdministrateurInitial();
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        JpaUtil.close();
    }

    private void creerAdministrateurInitial() {
        String email = System.getenv("ADMIN_EMAIL");
        String password = System.getenv("ADMIN_PASSWORD");
        if (email == null || password == null || password.isEmpty()) {
            return;
        }
        try {
            AdminService adminService = new AdminService();
            if (adminService.compterTotal() > 0) {
                return;
            }
            Admin admin = new Admin();
            admin.setNom("Administrateur");
            admin.setPrenom("Principal");
            admin.setEmail(email);
            admin.setMotDePasse(PasswordUtil.hash(password));
            admin.setRole("ADMIN");
            adminService.ajouter(admin);
            LOGGER.info("Administrateur initial créé : " + email);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Impossible de créer l'administrateur initial", e);
        }
    }
}
