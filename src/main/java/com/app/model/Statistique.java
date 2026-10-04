package com.app.model;

import java.util.List;

/** Indicateurs du tableau de bord statistique (objet de transfert, non persisté). */
public class Statistique {

    private long totalClients;
    private long totalPrestataires;
    private long totalReservations;

    private long reservationsTerminees;
    private long reservationsEnCours;
    private long reservationsEnAttente;
    private long reservationsAnnulees;

    private long reservationsToday;
    private long reservationsThisWeek;
    private long reservationsThisMonth;

    private double revenueToday;
    private double revenueThisWeek;
    private double revenueThisMonth;

    private double averageRating;
    private double panierMoyen;

    private List<Object[]> topServices;
    private List<Object[]> topPrestataires;

    // Réservations par mois (12 valeurs, janvier à décembre)
    private int anneeCourante;
    private List<Long> reservationsAnneeCourante;
    private List<Long> reservationsAnneePrecedente;

    public long getTotalClients() { return totalClients; }
    public void setTotalClients(long totalClients) { this.totalClients = totalClients; }

    public long getTotalPrestataires() { return totalPrestataires; }
    public void setTotalPrestataires(long totalPrestataires) { this.totalPrestataires = totalPrestataires; }

    public long getTotalReservations() { return totalReservations; }
    public void setTotalReservations(long totalReservations) { this.totalReservations = totalReservations; }

    public long getReservationsTerminees() { return reservationsTerminees; }
    public void setReservationsTerminees(long reservationsTerminees) { this.reservationsTerminees = reservationsTerminees; }

    public long getReservationsEnCours() { return reservationsEnCours; }
    public void setReservationsEnCours(long reservationsEnCours) { this.reservationsEnCours = reservationsEnCours; }

    public long getReservationsEnAttente() { return reservationsEnAttente; }
    public void setReservationsEnAttente(long reservationsEnAttente) { this.reservationsEnAttente = reservationsEnAttente; }

    public long getReservationsAnnulees() { return reservationsAnnulees; }
    public void setReservationsAnnulees(long reservationsAnnulees) { this.reservationsAnnulees = reservationsAnnulees; }

    public long getReservationsToday() { return reservationsToday; }
    public void setReservationsToday(long reservationsToday) { this.reservationsToday = reservationsToday; }

    public long getReservationsThisWeek() { return reservationsThisWeek; }
    public void setReservationsThisWeek(long reservationsThisWeek) { this.reservationsThisWeek = reservationsThisWeek; }

    public long getReservationsThisMonth() { return reservationsThisMonth; }
    public void setReservationsThisMonth(long reservationsThisMonth) { this.reservationsThisMonth = reservationsThisMonth; }

    public double getRevenueToday() { return revenueToday; }
    public void setRevenueToday(double revenueToday) { this.revenueToday = revenueToday; }

    public double getRevenueThisWeek() { return revenueThisWeek; }
    public void setRevenueThisWeek(double revenueThisWeek) { this.revenueThisWeek = revenueThisWeek; }

    public double getRevenueThisMonth() { return revenueThisMonth; }
    public void setRevenueThisMonth(double revenueThisMonth) { this.revenueThisMonth = revenueThisMonth; }

    public double getAverageRating() { return averageRating; }
    public void setAverageRating(double averageRating) { this.averageRating = averageRating; }

    public double getPanierMoyen() { return panierMoyen; }
    public void setPanierMoyen(double panierMoyen) { this.panierMoyen = panierMoyen; }

    public List<Object[]> getTopServices() { return topServices; }
    public void setTopServices(List<Object[]> topServices) { this.topServices = topServices; }

    public List<Object[]> getTopPrestataires() { return topPrestataires; }
    public void setTopPrestataires(List<Object[]> topPrestataires) { this.topPrestataires = topPrestataires; }

    public int getAnneeCourante() { return anneeCourante; }
    public void setAnneeCourante(int anneeCourante) { this.anneeCourante = anneeCourante; }

    public List<Long> getReservationsAnneeCourante() { return reservationsAnneeCourante; }
    public void setReservationsAnneeCourante(List<Long> reservationsAnneeCourante) { this.reservationsAnneeCourante = reservationsAnneeCourante; }

    public List<Long> getReservationsAnneePrecedente() { return reservationsAnneePrecedente; }
    public void setReservationsAnneePrecedente(List<Long> reservationsAnneePrecedente) { this.reservationsAnneePrecedente = reservationsAnneePrecedente; }
}
