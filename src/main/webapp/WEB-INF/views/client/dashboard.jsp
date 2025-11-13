<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Dashboard Client" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid">
    <!-- Page Header -->
    <div class="page-header fade-in">
        <h1>
            <i class="fas fa-home text-gradient"></i>
            Bienvenue, ${sessionScope.user.prenom} !
        </h1>
        <p class="text-muted mb-0">Gérez vos réservations et découvrez nos services</p>
    </div>

    <!-- Statistiques Client -->
    <div class="row g-4 mb-4">
        <div class="col-lg-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-primary">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-value">12</div>
                <div class="stat-label">Réservations</div>
                <div class="mt-2">
                    <small class="text-info">
                        <i class="fas fa-clock"></i> 2 en cours
                    </small>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-value">8</div>
                <div class="stat-label">Services Complétés</div>
                <div class="mt-2">
                    <small class="text-success">
                        <i class="fas fa-thumbs-up"></i> Terminés
                    </small>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-warning">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-value">4.8</div>
                <div class="stat-label">Note Moyenne</div>
                <div class="mt-2">
                    <small class="text-warning">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                    </small>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-info">
                    <i class="fas fa-euro-sign"></i>
                </div>
                <div class="stat-value">€850</div>
                <div class="stat-label">Dépenses Totales</div>
                <div class="mt-2">
                    <small class="text-muted">
                        <i class="fas fa-calendar"></i> Cette année
                    </small>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions Rapides -->
    <div class="row g-4 mb-4">
        <div class="col-lg-4">
            <a href="${pageContext.request.contextPath}/service?action=list" 
               class="text-decoration-none">
                <div class="card card-modern text-center py-4 h-100" style="cursor: pointer;">
                    <div class="card-body">
                        <i class="fas fa-search fa-3x text-primary mb-3"></i>
                        <h4 class="mb-2">Rechercher un Service</h4>
                        <p class="text-muted mb-0">
                            Parcourez notre catalogue de services disponibles
                        </p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-4">
            <a href="${pageContext.request.contextPath}/reservation?action=add" 
               class="text-decoration-none">
                <div class="card card-modern text-center py-4 h-100" style="cursor: pointer;">
                    <div class="card-body">
                        <i class="fas fa-plus-circle fa-3x text-success mb-3"></i>
                        <h4 class="mb-2">Nouvelle Réservation</h4>
                        <p class="text-muted mb-0">
                            Réservez un nouveau service rapidement
                        </p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-4">
            <a href="${pageContext.request.contextPath}/reservation?action=list" 
               class="text-decoration-none">
                <div class="card card-modern text-center py-4 h-100" style="cursor: pointer;">
                    <div class="card-body">
                        <i class="fas fa-list fa-3x text-info mb-3"></i>
                        <h4 class="mb-2">Mes Réservations</h4>
                        <p class="text-muted mb-0">
                            Consultez l'historique de vos réservations
                        </p>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <!-- Réservations en cours -->
    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-calendar-alt"></i> Réservations en Cours
                </div>
                <div class="card-body-custom">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">
                                        <i class="fas fa-wrench text-primary"></i>
                                        Réparation Plomberie
                                    </h5>
                                    <p class="mb-1 text-muted">
                                        <i class="fas fa-user-tie"></i> Thomas Lefebvre
                                    </p>
                                    <small class="text-muted">
                                        <i class="fas fa-calendar"></i> Prévu le 15 Nov 2025 à 14h00
                                    </small>
                                </div>
                                <div>
                                    <span class="badge badge-warning-custom">EN ATTENTE</span>
                                </div>
                            </div>
                        </div>

                        <div class="list-group-item px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">
                                        <i class="fas fa-broom text-success"></i>
                                        Ménage Complet
                                    </h5>
                                    <p class="mb-1 text-muted">
                                        <i class="fas fa-user-tie"></i> Lucas Simon
                                    </p>
                                    <small class="text-muted">
                                        <i class="fas fa-calendar"></i> Prévu le 14 Nov 2025 à 10h00
                                    </small>
                                </div>
                                <div>
                                    <span class="badge badge-success-custom">CONFIRMÉE</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/reservation?action=list" 
                           class="btn btn-outline-primary">
                            <i class="fas fa-eye"></i> Voir toutes mes réservations
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-star"></i> Services Populaires
                </div>
                <div class="card-body-custom">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-wrench text-primary"></i>
                                    <strong class="ms-2">Plomberie</strong>
                                </div>
                                <small class="text-muted">à partir de 60€</small>
                            </div>
                        </div>
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-bolt text-warning"></i>
                                    <strong class="ms-2">Électricité</strong>
                                </div>
                                <small class="text-muted">à partir de 50€</small>
                            </div>
                        </div>
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-broom text-success"></i>
                                    <strong class="ms-2">Ménage</strong>
                                </div>
                                <small class="text-muted">à partir de 35€</small>
                            </div>
                        </div>
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-leaf text-info"></i>
                                    <strong class="ms-2">Jardinage</strong>
                                </div>
                                <small class="text-muted">à partir de 40€</small>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/service?action=list" 
                       class="btn btn-sm btn-outline-primary w-100 mt-3">
                        Voir tous les services
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../shared/footer.jsp"/>
