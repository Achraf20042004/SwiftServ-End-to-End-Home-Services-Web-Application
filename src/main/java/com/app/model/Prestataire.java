package com.app.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "prestataires")
public class Prestataire extends Utilisateur {

    @Column(length = 150)
    private String specialite;

    @Column(length = 100)
    private String disponibilite;

    @OneToMany(mappedBy = "prestataire", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Intervention> interventions;

    @OneToMany(mappedBy = "prestataire", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Reservation> reservations;

    @OneToMany(mappedBy = "prestataire", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Avis> avis;

    // Getters et Setters

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public String getDisponibilite() {
        return disponibilite;
    }

    public void setDisponibilite(String disponibilite) {
        this.disponibilite = disponibilite;
    }

    public List<Intervention> getInterventions() {
        return interventions;
    }

    public void setInterventions(List<Intervention> interventions) {
        this.interventions = interventions;
    }

    public List<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(List<Reservation> reservations) {
        this.reservations = reservations;
    }

    public List<Avis> getAvis() {
        return avis;
    }

    public void setAvis(List<Avis> avis) {
        this.avis = avis;
    }
}
