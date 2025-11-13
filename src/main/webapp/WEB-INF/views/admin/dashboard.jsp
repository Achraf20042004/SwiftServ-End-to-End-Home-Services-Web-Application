<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Dashboard Administrateur" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid">
    <!-- Page Header -->
    <div class="page-header fade-in">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1>
                    <i class="fas fa-tachometer-alt text-gradient"></i>
                    Dashboard Administrateur
                </h1>
                <p class="text-muted mb-0">
                    Bienvenue, ${sessionScope.user.prenom} ${sessionScope.user.nom}
                </p>
            </div>
            <div>
                <span class="badge bg-success fs-6">
                    <i class="fas fa-circle pulse"></i> Système opérationnel
                </span>
            </div>
        </div>
    </div>

    <!-- Statistiques Cards -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-primary">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value">245</div>
                <div class="stat-label">Clients Actifs</div>
                <div class="mt-2">
                    <small class="text-success">
                        <i class="fas fa-arrow-up"></i> +12% ce mois
                    </small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-success">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div class="stat-value">78</div>
                <div class="stat-label">Prestataires</div>
                <div class="mt-2">
                    <small class="text-success">
                        <i class="fas fa-arrow-up"></i> +5 nouveaux
                    </small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-warning">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-value">432</div>
                <div class="stat-label">Réservations</div>
                <div class="mt-2">
                    <small class="text-warning">
                        <i class="fas fa-clock"></i> 23 en attente
                    </small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-info">
                    <i class="fas fa-euro-sign"></i>
                </div>
                <div class="stat-value">€15.2K</div>
                <div class="stat-label">Revenus ce mois</div>
                <div class="mt-2">
                    <small class="text-success">
                        <i class="fas fa-arrow-up"></i> +8% vs mois dernier
                    </small>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions Rapides -->
    <div class="row g-4 mb-4">
        <div class="col-lg-8">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-bolt"></i> Actions Rapides
                </div>
                <div class="card-body-custom">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/client?action=list" 
                               class="btn btn-outline-primary w-100 py-3">
                                <i class="fas fa-users fa-2x mb-2 d-block"></i>
                                Gérer Clients
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/prestataire?action=list" 
                               class="btn btn-outline-success w-100 py-3">
                                <i class="fas fa-user-tie fa-2x mb-2 d-block"></i>
                                Gérer Prestataires
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/service?action=list" 
                               class="btn btn-outline-info w-100 py-3">
                                <i class="fas fa-concierge-bell fa-2x mb-2 d-block"></i>
                                Gérer Services
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/categorie?action=list" 
                               class="btn btn-outline-warning w-100 py-3">
                                <i class="fas fa-tags fa-2x mb-2 d-block"></i>
                                Catégories
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/reclamation?action=list" 
                               class="btn btn-outline-danger w-100 py-3">
                                <i class="fas fa-exclamation-circle fa-2x mb-2 d-block"></i>
                                Réclamations
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/statistiques" 
                               class="btn btn-outline-secondary w-100 py-3">
                                <i class="fas fa-chart-bar fa-2x mb-2 d-block"></i>
                                Statistiques
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-bell"></i> Notifications Récentes
                </div>
                <div class="card-body-custom">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-user-plus text-success fa-lg"></i>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <strong>Nouveau prestataire</strong>
                                    <p class="mb-0 text-muted small">Il y a 2 heures</p>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-exclamation-triangle text-warning fa-lg"></i>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <strong>Nouvelle réclamation</strong>
                                    <p class="mb-0 text-muted small">Il y a 3 heures</p>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-calendar-check text-info fa-lg"></i>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <strong>15 réservations aujourd'hui</strong>
                                    <p class="mb-0 text-muted small">Il y a 5 heures</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/notification?action=list" 
                       class="btn btn-sm btn-outline-primary w-100 mt-3">
                        Voir toutes les notifications
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Réclamations en attente -->
    <div class="row g-4">
        <div class="col-12">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-exclamation-triangle"></i> Réclamations en Attente
                </div>
                <div class="card-body-custom">
                    <div class="table-responsive">
                        <table class="table table-modern">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Client</th>
                                    <th>Description</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#1</td>
                                    <td>Jean Martin</td>
                                    <td>Service non conforme aux attentes</td>
                                    <td>13/11/2025</td>
                                    <td>
                                        <button class="btn btn-sm btn-primary">
                                            <i class="fas fa-eye"></i> Voir
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" class="text-center text-muted">
                                        <a href="${pageContext.request.contextPath}/reclamation?action=list" 
                                           class="text-decoration-none">
                                            Voir toutes les réclamations →
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.pulse {
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.5; }
}
</style>

<jsp:include page="../shared/footer.jsp"/>
