package com.app.utils;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class PasswordUtilTest {

    @Test
    void aHashIsVerifiedWithTheRightPasswordOnly() {
        String hash = PasswordUtil.hash("motdepasse123");

        assertTrue(PasswordUtil.isHashed(hash));
        assertTrue(PasswordUtil.verify("motdepasse123", hash));
        assertFalse(PasswordUtil.verify("mauvais", hash));
    }

    @Test
    void theSamePasswordGivesDifferentHashes() {
        // Sel aléatoire : deux hash du même mot de passe sont différents
        assertNotEquals(PasswordUtil.hash("secret"), PasswordUtil.hash("secret"));
    }

    @Test
    void aPlainTextValueIsNotConsideredHashed() {
        assertFalse(PasswordUtil.isHashed("secret"));
        assertFalse(PasswordUtil.verify("secret", "secret"));
        assertFalse(PasswordUtil.verify("secret", null));
    }
}
