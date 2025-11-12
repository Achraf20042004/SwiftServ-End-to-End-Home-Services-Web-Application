<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Services à Domicile'}</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
            <i class="fas fa-home-heart"></i>
            <span>Services Domicile</span>
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                
                <c:if test="${sessionScope.role == 'admin'}">
                    <li class="nav-item">
                        <a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fas fa-chart-line me-1"></i> Tableau de bord
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="gestionDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-cog me-1"></i> Gestion
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/client?action=list">
                                <i class="fas fa-users text-primary me-2"></i> Clients
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/prestataire?action=list">
                                <i class="fas fa-user-tie text-success me-2"></i> Prestataires
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/categorie?action=list">
                                <i class="fas fa-tags text-warning me-2"></i> Catégories
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/service?action=list">
                                <i class="fas fa-briefcase text-info me-2"></i> Services
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/reservation?action=list">
                                <i class="fas fa-calendar-check text-primary me-2"></i> Réservations
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/intervention?action=list">
                                <i class="fas fa-tools text-success me-2"></i> Interventions
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/avis?action=list">
                                <i class="fas fa-star text-warning me-2"></i> Avis
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/reclamation?action=list">
                                <i class="fas fa-exclamation-triangle text-danger me-2"></i> Réclamations
                            </a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/statistiques">
                            <i class="fas fa-chart-bar me-1"></i> Statistiques
                        </a>
                    </li>
                </c:if>
                
                <c:if test="${sessionScope.role == 'client'}">
                    <li class="nav-item">
                        <a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fas fa-home me-1"></i> Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/reservation?action=list">
                            <i class="fas fa-calendar-alt me-1"></i> Mes Réservations
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/avis?action=list">
                            <i class="fas fa-star me-1"></i> Mes Avis
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/reclamation?action=list">
                            <i class="fas fa-exclamation-circle me-1"></i> Réclamations
                        </a>
                    </li>
                </c:if>
                
                <c:if test="${sessionScope.role == 'prestataire'}">
                    <li class="nav-item">
                        <a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fas fa-home me-1"></i> Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/intervention?action=list">
                            <i class="fas fa-clipboard-list me-1"></i> Mes Interventions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/avis?action=list">
                            <i class="fas fa-star me-1"></i> Mes Avis
                        </a>
                    </li>
                </c:if>
                
                <li class="nav-item dropdown ms-3">
                    <a class="nav-link dropdown-toggle user-badge" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user-circle"></i>
                        <span>${sessionScope.user.prenom} ${sessionScope.user.nom}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profil">
                            <i class="fas fa-user text-primary me-2"></i> Mon Profil
                        </a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/notification?action=list">
                            <i class="fas fa-bell text-warning me-2"></i> Notifications
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-2"></i> Déconnexion
                        </a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content Container -->
<div class="container-fluid px-4 py-4">
