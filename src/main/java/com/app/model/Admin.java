package com.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "admins")
public class Admin extends Utilisateur {

    @Column(nullable = false, length = 50)
    private String role = "ADMIN";

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
