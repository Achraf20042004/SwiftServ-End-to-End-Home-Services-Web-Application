<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Services à Domicile'}</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
            <i class="fas fa-home-lg-alt"></i>
            Services Domicile
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:if test="${sessionScope.role != null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fas fa-tachometer-alt"></i> Tableau de bord
                        </a>
                    </li>
                    
                    <!-- Menu ADMIN -->
                    <c:if test="${sessionScope.role == 'admin'}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-users-cog"></i> Gestion
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin?action=list">
                                    <i class="fas fa-user-shield"></i> Administrateurs
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/client?action=list">
                                    <i class="fas fa-users"></i> Clients
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/prestataire?action=list">
                                    <i class="fas fa-user-tie"></i> Prestataires
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/categorie?action=list">
                                    <i class="fas fa-tags"></i> Catégories
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/service?action=list">
                                    <i class="fas fa-concierge-bell"></i> Services
                                </a></li>
                            </ul>
                        </li>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/statistiques">
                                <i class="fas fa-chart-bar"></i> Statistiques
                            </a>
                        </li>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/reclamation?action=list">
                                <i class="fas fa-exclamation-circle"></i> Réclamations
                            </a>
                        </li>
                    </c:if>
                    
                    <!-- Menu CLIENT -->
                    <c:if test="${sessionScope.role == 'client'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/service?action=list">
                                <i class="fas fa-concierge-bell"></i> Services
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/reservation?action=list">
                                <i class="fas fa-calendar-check"></i> Mes Réservations
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/avis?action=list">
                                <i class="fas fa-star"></i> Mes Avis
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/reclamation?action=list">
                                <i class="fas fa-exclamation-triangle"></i> Réclamations
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/notification?action=list">
                                <i class="fas fa-bell"></i> Notifications
                            </a>
                        </li>
                    </c:if>
                    
                    <!-- Menu PRESTATAIRE -->
                    <c:if test="${sessionScope.role == 'prestataire'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/reservation?action=list">
                                <i class="fas fa-calendar-alt"></i> Réservations
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/intervention?action=list">
                                <i class="fas fa-tools"></i> Interventions
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/avis?action=list">
                                <i class="fas fa-star"></i> Avis Reçus
                            </a>
                        </li>
                    </c:if>
                </c:if>
            </ul>
            
            <!-- User Menu -->
            <ul class="navbar-nav">
                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle user-badge" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i>
                            ${fn:escapeXml(sessionScope.user.prenom)} ${fn:escapeXml(sessionScope.user.nom)}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item disabled">
                                    <small class="text-muted">Rôle: ${sessionScope.role}</small>
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                    <i class="fas fa-user-edit"></i> Mon Profil
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt"></i> Déconnexion
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<!-- Messages Flash -->
<c:if test="${not empty success}">
    <div class="container mt-3">
        <div class="alert alert-success-modern alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="container mt-3">
        <div class="alert alert-danger-modern alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
</c:if>

<!-- Main Content Container -->
<div class="container-fluid mt-4">
