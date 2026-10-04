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
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

/**
 * Protection CSRF : un jeton aléatoire par session, exigé sur toute requête POST
 * (champ caché "_csrf", ajouté dans chaque formulaire JSP).
 */
public class CsrfFilter implements Filter {

    public static final String TOKEN_NAME = "_csrf";
    private static final SecureRandom RANDOM = new SecureRandom();

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        if (isStaticResource(request)) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(true);
        String token = (String) session.getAttribute(TOKEN_NAME);
        if (token == null) {
            byte[] bytes = new byte[32];
            RANDOM.nextBytes(bytes);
            token = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
            session.setAttribute(TOKEN_NAME, token);
        }

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String sent = request.getParameter(TOKEN_NAME);
            if (sent == null || !MessageDigest.isEqual(token.getBytes(StandardCharsets.UTF_8),
                                                       sent.getBytes(StandardCharsets.UTF_8))) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Jeton CSRF invalide ou expiré");
                return;
            }
        }

        chain.doFilter(req, res);
    }

    private boolean isStaticResource(HttpServletRequest request) {
        return request.getServletPath().startsWith("/assets/");
    }
}
