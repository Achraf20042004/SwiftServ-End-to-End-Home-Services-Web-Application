package com.app.service;

import com.app.dao.StatistiqueDAO;
import com.app.model.Statistique;

import java.time.Year;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class StatistiqueService {

    private StatistiqueDAO dao = new StatistiqueDAO();

    public Statistique getStatistiques() throws ServiceException {
        try {
            Statistique stats = new Statistique();

            stats.setTotalClients(dao.countClients());
            stats.setTotalPrestataires(dao.countPrestataires());
            stats.setTotalReservations(dao.countReservations());

            stats.setReservationsTerminees(dao.countByStatut("TERMINEE"));
            stats.setReservationsEnCours(dao.countByStatut("EN_COURS"));
            stats.setReservationsEnAttente(dao.countByStatut("EN_ATTENTE"));
            stats.setReservationsAnnulees(dao.countByStatut("ANNULEE"));

            stats.setReservationsToday(dao.countReservationsToday());
            stats.setReservationsThisWeek(dao.countReservationsThisWeek());
            stats.setReservationsThisMonth(dao.countReservationsThisMonth());

            stats.setRevenueToday(dao.revenueToday());
            stats.setRevenueThisWeek(dao.revenueThisWeek());
            stats.setRevenueThisMonth(dao.revenueThisMonth());

            long terminees = stats.getReservationsTerminees();
            stats.setPanierMoyen(terminees > 0 ? stats.getRevenueThisMonth() / terminees : 0);
            stats.setAverageRating(dao.getAverageRating());

            stats.setTopServices(dao.getTopServices(6));
            stats.setTopPrestataires(dao.getTopPrestataires(4));

            // Année courante et précédente (au lieu d'années écrites en dur)
            int annee = Year.now().getValue();
            stats.setAnneeCourante(annee);
            stats.setReservationsAnneeCourante(reservationsParMois(annee));
            stats.setReservationsAnneePrecedente(reservationsParMois(annee - 1));

            return stats;
        } catch (Exception e) {
            throw new ServiceException("Erreur chargement statistiques", e);
        }
    }

    /** 12 valeurs (janvier à décembre), 0 pour les mois sans réservation. */
    private List<Long> reservationsParMois(int annee) {
        List<Long> parMois = new ArrayList<>(Collections.nCopies(12, 0L));
        for (Object[] row : dao.getReservationsByMonth(annee)) {
            int mois = ((Number) row[0]).intValue();
            long total = ((Number) row[1]).longValue();
            parMois.set(mois - 1, total);
        }
        return parMois;
    }
}
