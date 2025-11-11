package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Statistique;
import java.util.List;

public class StatistiqueService {

    private GenericDAO<Statistique> dao = new GenericDAO<>(Statistique.class);

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

    public List<Statistique> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des statistiques", e);
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
}
