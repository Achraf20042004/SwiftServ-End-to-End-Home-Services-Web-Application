package com.app.dao;

import com.app.model.Reservation;

public class ReservationDAO extends GenericDAO<Reservation> {

    public ReservationDAO() {
        super(Reservation.class);
    }
}
