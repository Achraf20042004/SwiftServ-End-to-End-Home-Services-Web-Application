package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Statistique;

public class StatistiqueService {

    private final GenericDAO<Statistique> dao = new GenericDAO<>(Statistique.class);
    private final ClientService clientService = new ClientService();
    private final PrestataireService prestataireService = new PrestataireService();
    private final ReservationService reservationService = new ReservationService();

    public void ajouter(Statistique stat) throws ServiceException {
        try {
            dao.save(stat);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout des statistiques", e);
        }
    }

    public Statistique trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche des statistiques", e);
        }
    }

    public void modifier(Statistique stat) throws ServiceException {
        try {
            dao.update(stat);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification des statistiques", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression des statistiques", e);
        }
    }

    // Statistiques dynamiques calculées depuis la base
    public Statistique getStatistiques() throws ServiceException {
        try {
            long totalClients = clientService.count();
            long totalPrestataires = prestataireService.count();
            long totalReservations = reservationService.count();

            Statistique s = new Statistique();
            s.setTotalClients((int) totalClients);
            s.setTotalPrestataires((int) totalPrestataires);
            s.setTotalReservations((int) totalReservations);
            return s;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors du chargement des statistiques dynamiques", e);
        }
    }
}
