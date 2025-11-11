package com.app.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "categories")
public class CategorieService {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, length = 150)
    private String nom;

    @Column(length = 500)
    private String description;

    @OneToMany(mappedBy = "categorie", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ServiceDomicile> services;

    // Getters et setters

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<ServiceDomicile> getServices() {
        return services;
    }

    public void setServices(List<ServiceDomicile> services) {
        this.services = services;
    }
}
