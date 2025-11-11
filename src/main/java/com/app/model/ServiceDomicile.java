package com.app.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "services")
public class ServiceDomicile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, length = 150)
    private String nom;

    @Column(nullable = false)
    private double prix;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "categorie_id", nullable = false)
    private CategorieService categorie;

    @OneToMany(mappedBy = "service", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Reservation> reservations;

    // Getters et Setters

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public CategorieService getCategorie() {
        return categorie;
    }

    public void setCategorie(CategorieService categorie) {
        this.categorie = categorie;
    }

    public List<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(List<Reservation> reservations) {
        this.reservations = reservations;
    }
}
