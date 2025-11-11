package com.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "statistiques")
public class Statistique {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private int totalReservations;

    @Column(nullable = false)
    private int totalPrestataires;

    @Column(nullable = false)
    private int totalClients;

    // Getters et Setters

    public int getId() {
        return id;
    }

    public int getTotalReservations() {
        return totalReservations;
    }

    public void setTotalReservations(int totalReservations) {
        this.totalReservations = totalReservations;
    }

    public int getTotalPrestataires() {
        return totalPrestataires;
    }

    public void setTotalPrestataires(int totalPrestataires) {
        this.totalPrestataires = totalPrestataires;
    }

    public int getTotalClients() {
        return totalClients;
    }

    public void setTotalClients(int totalClients) {
        this.totalClients = totalClients;
    }
}
