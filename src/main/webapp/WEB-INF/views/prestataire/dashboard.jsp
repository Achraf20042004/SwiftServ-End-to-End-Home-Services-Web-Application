<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Dashboard Prestataire" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid">
    <!-- Page Header -->
    <div class="page-header fade-in">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1>
                    <i class="fas fa-briefcase text-gradient"></i>
                    Espace Prestataire
                </h1>
                <p class="text-muted mb-0">
                    Bienvenue, ${sessionScope.user.prenom} ${sessionScope.user.nom}
                </p>
            </div>
            <div>
                <span class="badge bg-success fs-6">
                    <i class="fas fa-circle"></i> Disponible
                </span>
            </div>
        </div>
    </div>

    <!-- Statistiques Prestataire -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-primary">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-value">18</div>
                <div class="stat-label">Interventions ce mois</div>
                <div class="mt-2">
                    <small class="text-info">
                        <i class="fas fa-hourglass-half"></i> 3 en cours
                    </small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-warning">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-value">5</div>
                <div class="stat-label">Demandes en Attente</div>
                <div class="mt-2">
                    <small class="text-warning">
                        <i class="fas fa-exclamation-circle"></i> À traiter
                    </small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-success">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-value">4.9</div>
                <div class="stat-label">Note Moyenne</div>
                <div class="mt-2">
                    <small class="text-success">
                        <i class="fas fa-thumbs-up"></i> 45 avis
                    </small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-info">
                    <i class="fas fa-euro-sign"></i>
                </div>
                <div class="stat-value">€2.4K</div>
                <div class="stat-label">Revenus ce mois</div>
                <div class="mt-2">
                    <small class="text-success">
                        <i class="fas fa-arrow-up"></i> +15%
                    </small>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions Rapides -->
    <div class="row g-4 mb-4">
        <div class="col-lg-4">
            <a href="${pageContext.request.contextPath}/reservation?action=list" 
               class="text-decoration-none">
                <div class="card card-modern text-center py-4 h-100" style="cursor: pointer;">
                    <div class="card-body">
                        <i class="fas fa-calendar-alt fa-3x text-primary mb-3"></i>
                        <h4 class="mb-2">Réservations</h4>
                        <p class="text-muted mb-0">
                            Gérez vos réservations clients
                        </p>
                        <span class="badge bg-warning mt-2">5 en attente</span>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-4">
            <a href="${pageContext.request.contextPath}/intervention?action=list" 
               class="text-decoration-none">
                <div class="card card-modern text-center py-4 h-100" style="cursor: pointer;">
                    <div class="card-body">
                        <i class="fas fa-tools fa-3x text-success mb-3"></i>
                        <h4 class="mb-2">Interventions</h4>
                        <p class="text-muted mb-0">
                            Suivez vos interventions en cours
                        </p>
                        <span class="badge bg-info mt-2">3 en cours</span>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-4">
            <a href="${pageContext.request.contextPath}/avis?action=list" 
               class="text-decoration-none">
                <div class="card card-modern text-center py-4 h-100" style="cursor: pointer;">
                    <div class="card-body">
                        <i class="fas fa-star fa-3x text-warning mb-3"></i>
                        <h4 class="mb-2">Mes Avis</h4>
                        <p class="text-muted mb-0">
                            Consultez les avis de vos clients
                        </p>
                        <span class="badge bg-success mt-2">4.9/5</span>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <!-- Demandes en attente et Interventions du jour -->
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-hourglass-half"></i> Demandes en Attente
                </div>
                <div class="card-body-custom">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item px-0">
                            <div class="d-flex justify-content-between align-items-start">
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">
                                        <i class="fas fa-wrench text-primary"></i>
                                        Réparation fuite d'eau
                                    </h6>
                                    <p class="mb-1 text-muted">
                                        <i class="fas fa-user"></i> Jean Martin
                                    </p>
                                    <small class="text-muted">
                                        <i class="fas fa-map-marker-alt"></i> 15 Rue de la Paix, Paris
                                    </small>
                                    <br>
                                    <small class="text-muted">
                                        <i class="fas fa-clock"></i> Demandé le 13 Nov 2025
                                    </small>
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-success mb-1">
                                        <i class="fas fa-check"></i> Accepter
                                    </button>
                                    <button class="btn btn-sm btn-danger">
                                        <i class="fas fa-times"></i> Refuser
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="list-group-item px-0">
                            <div class="d-flex justify-content-between align-items-start">
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">
                                        <i class="fas fa-water text-info"></i>
                                        Installation sanitaire
                                    </h6>
                                    <p class="mb-1 text-muted">
                                        <i class="fas fa-user"></i> Sophie Bernard
                                    </p>
                                    <small class="text-muted">
                                        <i class="fas fa-map-marker-alt"></i> 22 Avenue des Champs, Lyon
                                    </small>
                                    <br>
                                    <small class="text-muted">
                                        <i class="fas fa-clock"></i> Demandé le 12 Nov 2025
                                    </small>
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-success mb-1">
                                        <i class="fas fa-check"></i> Accepter
                                    </button>
                                    <button class="btn btn-sm btn-danger">
                                        <i class="fas fa-times"></i> Refuser
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/reservation?action=list" 
                           class="btn btn-outline-primary">
                            <i class="fas fa-eye"></i> Voir toutes les demandes
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-calendar-day"></i> Interventions d'Aujourd'hui
                </div>
                <div class="card-body-custom">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1">
                                        <i class="fas fa-tools text-success"></i>
                                        Débouchage canalisation
                                    </h6>
                                    <p class="mb-1 text-muted">
                                        <i class="fas fa-user"></i> Pierre Dubois
                                    </p>
                                    <small class="text-muted">
                                        <i class="fas fa-clock"></i> 10h00 - 11h30
                                    </small>
                                </div>
                                <div>
                                    <span class="badge badge-info-custom">EN COURS</span>
                                </div>
                            </div>
                        </div>

                        <div class="list-group-item px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1">
                                        <i class="fas fa-wrench text-primary"></i>
                                        Réparation robinet
                                    </h6>
                                    <p class="mb-1 text-muted">
                                        <i class="fas fa-user"></i> Julie Moreau
                                    </p>
                                    <small class="text-muted">
                                        <i class="fas fa-clock"></i> 14h00 - 15h00
                                    </small>
                                </div>
                                <div>
                                    <span class="badge badge-warning-custom">PLANIFIÉE</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/intervention?action=list" 
                           class="btn btn-outline-success">
                            <i class="fas fa-eye"></i> Voir toutes les interventions
                        </a>
                    </div>
                </div>
            </div>

            <!-- Derniers avis -->
            <div class="card card-modern fade-in mt-4">
                <div class="card-header-custom">
                    <i class="fas fa-star"></i> Derniers Avis Reçus
                </div>
                <div class="card-body-custom">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <strong>Jean Martin</strong>
                                    <div class="text-warning">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <small class="text-muted">"Excellent service, très professionnel!"</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/avis?action=list" 
                       class="btn btn-sm btn-outline-warning w-100 mt-2">
                        Voir tous les avis
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../shared/footer.jsp"/>
