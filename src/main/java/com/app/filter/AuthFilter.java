package com.app.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

/**
 * Contrôle d'accès centralisé : authentification obligatoire hors pages publiques,
 * puis vérification du rôle (admin / client / prestataire) selon la page et l'action.
 */
public class AuthFilter implements Filter {

    private static final String ADMIN = "admin";
    private static final String CLIENT = "client";
    private static final String PRESTATAIRE = "prestataire";

    private static final Set<String> PUBLIC_PATHS = Set.of("/", "/index.jsp", "/login", "/register", "/logout");
    private static final Set<String> ADMIN_ONLY = Set.of("/admin", "/client", "/prestataire", "/categorie", "/statistiques");

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String path = request.getServletPath();

        if (PUBLIC_PATHS.contains(path) || path.startsWith("/assets/")) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("role");
        if (role == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "list";
        }

        if (!isAllowed(path, action, role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }

        chain.doFilter(req, res);
    }

    static boolean isAllowed(String path, String action, String role) {
        if (ADMIN.equals(role)) {
            return true;
        }
        if (ADMIN_ONLY.contains(path)) {
            return false;
        }
        switch (path) {
            case "/dashboard":
            case "/profile":
                return true;
            case "/service":
                return "list".equals(action);
            case "/reservation":
                switch (action) {
                    case "list": return true;
                    case "add": return CLIENT.equals(role);
                    case "updateStatus": return PRESTATAIRE.equals(role);
                    default: return false;
                }
            case "/intervention":
                // edit : uniquement ses propres interventions (vérifié dans la servlet)
                return PRESTATAIRE.equals(role) && Set.of("list", "add", "edit").contains(action);
            case "/avis":
                return "list".equals(action) || ("add".equals(action) && CLIENT.equals(role));
            case "/reclamation":
                return CLIENT.equals(role) && Set.of("list", "add").contains(action);
            case "/notification":
                return CLIENT.equals(role) && "list".equals(action);
            default:
                return false;
        }
    }
}
