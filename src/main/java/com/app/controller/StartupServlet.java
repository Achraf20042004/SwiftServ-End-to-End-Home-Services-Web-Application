package com.app.controller;
import com.app.utils.JpaUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(loadOnStartup = 1, name = "StartupServlet")
public class StartupServlet extends jakarta.servlet.http.HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public void init() throws ServletException {
        // Déclenche l'initialisation d'Hibernate
        System.out.println("Initialisation JPA...");
        JpaUtil.getEntityManagerFactory();
        System.out.println("Hibernate initialisé !");
    }
}
