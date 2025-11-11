package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Avis;
import java.util.List;

public class AvisService {

    private GenericDAO<Avis> dao = new GenericDAO<>(Avis.class);

    public void ajouter(Avis avis) throws ServiceException {
        try {
            dao.save(avis);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de l'avis", e);
        }
    }

    public Avis trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de l'avis", e);
        }
    }

    public List<Avis> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des avis", e);
        }
    }

    public void modifier(Avis avis) throws ServiceException {
        try {
            dao.update(avis);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de l'avis", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de l'avis", e);
        }
    }
}
