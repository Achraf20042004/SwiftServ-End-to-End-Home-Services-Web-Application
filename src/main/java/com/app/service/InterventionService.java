package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Intervention;
import java.util.List;

public class InterventionService {

    private GenericDAO<Intervention> dao = new GenericDAO<>(Intervention.class);

    public void ajouter(Intervention intervention) throws ServiceException {
        try {
            dao.save(intervention);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de l'intervention", e);
        }
    }

    public Intervention trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de l'intervention", e);
        }
    }

    public List<Intervention> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des interventions", e);
        }
    }

    public void modifier(Intervention intervention) throws ServiceException {
        try {
            dao.update(intervention);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de l'intervention", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de l'intervention", e);
        }
    }
}
