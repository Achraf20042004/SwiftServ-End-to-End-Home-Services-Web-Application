package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Reservation;
import java.util.List;

public class ReservationService {

    private GenericDAO<Reservation> dao = new GenericDAO<>(Reservation.class);

    public void ajouter(Reservation reservation) throws ServiceException {
        try {
            dao.save(reservation);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de la réservation", e);
        }
    }

    public Reservation trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de la réservation", e);
        }
    }

    public List<Reservation> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des réservations", e);
        }
    }

    public void modifier(Reservation reservation) throws ServiceException {
        try {
            dao.update(reservation);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de la réservation", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de la réservation", e);
        }
    }
}
