package com.app.service;

import com.app.dao.GenericDAO;
import com.app.model.Admin;
import java.util.List;

public class AdminService {

    private GenericDAO<Admin> dao = new GenericDAO<>(Admin.class);

    public void ajouter(Admin admin) throws ServiceException {
        try {
            dao.save(admin);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'ajout de l'admin", e);
        }
    }

    public Admin trouver(int id) throws ServiceException {
        try {
            return dao.find(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche de l'admin", e);
        }
    }

    public List<Admin> lister() throws ServiceException {
        try {
            return dao.findAll();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération des admins", e);
        }
    }

    public void modifier(Admin admin) throws ServiceException {
        try {
            dao.update(admin);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la modification de l'admin", e);
        }
    }

    public void supprimer(int id) throws ServiceException {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression de l'admin", e);
        }
    }
}
