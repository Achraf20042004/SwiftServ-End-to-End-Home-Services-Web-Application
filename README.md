# Home Services Management Platform (Jakarta EE)

A web application that connects **clients** with **service providers** for home services (cleaning, repairs…), with a full **administration** back office.

## Features
**Client**
- Browse the service catalogue and book a provider
- Follow bookings, receive notifications when their status changes
- Rate providers (after a completed booking) and file complaints
- Personal dashboard

**Provider**
- Accept or refuse booking requests
- Plan and track interventions
- See received reviews, satisfaction rate and monthly revenue

**Administrator**
- Manage admins, clients, providers, service categories and services
- Manage bookings, interventions, reviews, complaints and notifications
- Statistics dashboard: revenue (day / week / month), bookings per month (current vs previous year), top services and providers, platform commission

## Architecture
```
JSP + JSTL (views)
   │
Servlets (controllers)   ←  Filters: UTF-8 encoding → CSRF → authentication & roles
   │
Services (business logic, ServiceException)
   │
DAO (GenericDAO<T>)  →  JPA / Hibernate  →  MySQL
```

**Data model:** `Admin`, `Client` and `Prestataire` share the `Utilisateur` base class; `CategorieService` 1–n `ServiceDomicile`; `Reservation` links a client, a provider and a service; each reservation can have one `Intervention`; plus `Avis` (reviews), `Reclamation` (complaints) and `Notification`.

## Security
- Passwords hashed with **PBKDF2-HMAC-SHA256** (random salt; legacy plain-text passwords are upgraded at first login)
- **Role-based access control** in a single filter, plus ownership checks (a client only sees and creates their own data, a provider only manages their own requests and interventions)
- **CSRF token** on every POST request; data-changing actions never use GET
- **XSS protection**: user input escaped in the views (`fn:escapeXml`)
- Session regenerated at login, HttpOnly session cookie
- Database credentials read from environment variables, not stored in the code

## Tech stack
Java 17 · Jakarta EE 10 (Servlets 6, JSP, JSTL 3) · JPA / Hibernate 6 · MySQL 8 · Maven · Tomcat 10 · Bootstrap 5 · Chart.js · JUnit 5 · Docker

## Run with Docker
```bash
mvn package                 # builds target/services-domicile.war and runs the tests
docker compose up -d        # MySQL + Tomcat
```
Open http://localhost:8080/services-domicile.

The first administrator is created at startup from `ADMIN_EMAIL` / `ADMIN_PASSWORD` (see `docker-compose.yml`; override them with environment variables or a `.env` file). Clients and providers sign up from the registration page.

## Run without Docker
Deploy the WAR on Tomcat 10.1 (Java 17+) and set the environment variables:

| Variable | Default |
|---|---|
| `DB_URL` | `jdbc:mysql://localhost:3307/services_domicile?...` |
| `DB_USER` / `DB_PASSWORD` | `root` / empty |
| `ADMIN_EMAIL` / `ADMIN_PASSWORD` | not set (no admin created) |

Tables are created automatically by Hibernate.

## Tests
`mvn test` runs the unit tests (password hashing, access rules).
