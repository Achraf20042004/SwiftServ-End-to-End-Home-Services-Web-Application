package com.app.filter;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class AuthFilterTest {

    @Test
    void theAdminCanAccessEverything() {
        assertTrue(AuthFilter.isAllowed("/client", "delete", "admin"));
        assertTrue(AuthFilter.isAllowed("/statistiques", "list", "admin"));
    }

    @Test
    void managementPagesAreReservedToTheAdmin() {
        for (String path : new String[] {"/admin", "/client", "/prestataire", "/categorie", "/statistiques"}) {
            assertFalse(AuthFilter.isAllowed(path, "list", "client"), path);
            assertFalse(AuthFilter.isAllowed(path, "list", "prestataire"), path);
        }
    }

    @Test
    void aClientCanBookAndComplainButNotDelete() {
        assertTrue(AuthFilter.isAllowed("/reservation", "add", "client"));
        assertTrue(AuthFilter.isAllowed("/reclamation", "add", "client"));
        assertTrue(AuthFilter.isAllowed("/avis", "add", "client"));
        assertTrue(AuthFilter.isAllowed("/service", "list", "client"));

        assertFalse(AuthFilter.isAllowed("/reservation", "delete", "client"));
        assertFalse(AuthFilter.isAllowed("/reservation", "updateStatus", "client"));
        assertFalse(AuthFilter.isAllowed("/service", "add", "client"));
        assertFalse(AuthFilter.isAllowed("/intervention", "list", "client"));
    }

    @Test
    void aProviderManagesItsRequestsAndInterventions() {
        assertTrue(AuthFilter.isAllowed("/reservation", "updateStatus", "prestataire"));
        assertTrue(AuthFilter.isAllowed("/intervention", "add", "prestataire"));
        assertTrue(AuthFilter.isAllowed("/intervention", "edit", "prestataire"));

        assertFalse(AuthFilter.isAllowed("/intervention", "delete", "prestataire"));
        assertFalse(AuthFilter.isAllowed("/reservation", "add", "prestataire"));
        assertFalse(AuthFilter.isAllowed("/notification", "list", "prestataire"));
        assertFalse(AuthFilter.isAllowed("/reclamation", "list", "prestataire"));
    }
}
