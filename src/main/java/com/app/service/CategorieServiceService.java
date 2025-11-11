package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.CategorieService;
import java.util.List;

public class CategorieServiceService {

    private GenericDAO<CategorieService> dao = new GenericDAO<>(CategorieService.class);

    public void ajouter(CategorieService categorie) throws ServiceException {
        try {
            dao.save(categorie);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de la catégorie", e);
        }
    }

    public CategorieService trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de la catégorie", e);
        }
    }

    public List<CategorieService> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des catégories", e);
        }
    }

    public void modifier(CategorieService categorie) throws ServiceException {
        try {
            dao.update(categorie);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de la catégorie", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de la catégorie", e);
        }
    }
}
