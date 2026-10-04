<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Dashboard Client" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid px-4">
    <!-- Welcome Section -->
    <div class="welcome-section fade-in mb-4">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <div class="welcome-content">
                    <h1 class="welcome-title">
                        Bonjour, <span class="text-gradient">${fn:escapeXml(sessionScope.user.prenom)}</span> ! 👋
                    </h1>
                    <p class="welcome-subtitle">
                        Bienvenue sur votre espace personnel. Gérez vos réservations et découvrez nos services.
                    </p>
                    <div class="welcome-date">
                        <i class="fas fa-calendar-alt me-2"></i>
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="EEEE dd MMMM yyyy" />
                    </div>
                </div>
            </div>
            <div class="col-lg-4 text-end d-none d-lg-block">
                <div class="welcome-illustration">
                    <i class="fas fa-home-lg-alt"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistiques Client -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="stat-card-modern fade-in" style="animation-delay: 0.1s;">
                <div class="stat-card-icon bg-gradient-primary">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-card-content">
                    <div class="stat-card-value">${reservationsTotal != null ? reservationsTotal : 0}</div>
                    <div class="stat-card-label">Total Réservations</div>
                    <div class="stat-card-trend trend-up">
                        <i class="fas fa-arrow-up me-1"></i>
                        <span>+12% ce mois</span>
                    </div>
                </div>
                <div class="stat-card-progress">
                    <div class="progress-bar" style="width: 75%;"></div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card-modern fade-in" style="animation-delay: 0.2s;">
                <div class="stat-card-icon bg-gradient-success">
                    <i class="fas fa-spinner"></i>
                </div>
                <div class="stat-card-content">
                    <div class="stat-card-value">${reservationsEnCours != null ? reservationsEnCours : 0}</div>
                    <div class="stat-card-label">En Cours</div>
                    <div class="stat-card-trend trend-neutral">
                        <i class="fas fa-clock me-1"></i>
                        <span>En traitement</span>
                    </div>
                </div>
                <div class="stat-card-progress">
                    <div class="progress-bar bg-success" style="width: 45%;"></div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card-modern fade-in" style="animation-delay: 0.3s;">
                <div class="stat-card-icon bg-gradient-warning">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="stat-card-content">
                    <div class="stat-card-value">${reservationsFutures != null ? reservationsFutures : 0}</div>
                    <div class="stat-card-label">À Venir</div>
                    <div class="stat-card-trend trend-up">
                        <i class="fas fa-calendar-plus me-1"></i>
                        <span>Planifiées</span>
                    </div>
                </div>
                <div class="stat-card-progress">
                    <div class="progress-bar bg-warning" style="width: 60%;"></div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card-modern fade-in" style="animation-delay: 0.4s;">
                <div class="stat-card-icon bg-gradient-info">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-card-content">
                    <div class="stat-card-value">${avisEnvoyes != null ? avisEnvoyes : 0}</div>
                    <div class="stat-card-label">Avis Donnés</div>
                    <div class="stat-card-trend trend-up">
                        <i class="fas fa-thumbs-up me-1"></i>
                        <span>Merci !</span>
                    </div>
                </div>
                <div class="stat-card-progress">
                    <div class="progress-bar bg-info" style="width: 30%;"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions Rapides -->
    <div class="row g-4 mb-4">
        <div class="col-12">
            <h5 class="section-title fade-in">
                <i class="fas fa-bolt me-2"></i>Actions Rapides
            </h5>
        </div>
        
        <div class="col-lg-4 col-md-6">
            <a href="${pageContext.request.contextPath}/service?action=list" class="text-decoration-none">
                <div class="action-card fade-in" style="animation-delay: 0.1s;">
                    <div class="action-card-icon">
                        <i class="fas fa-search"></i>
                    </div>
                    <div class="action-card-content">
                        <h5>Rechercher un Service</h5>
                        <p>Parcourez notre catalogue de services disponibles</p>
                    </div>
                    <div class="action-card-arrow">
                        <i class="fas fa-chevron-right"></i>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-4 col-md-6">
            <a href="${pageContext.request.contextPath}/reservation?action=add" class="text-decoration-none">
                <div class="action-card fade-in" style="animation-delay: 0.2s;">
                    <div class="action-card-icon success">
                        <i class="fas fa-plus"></i>
                    </div>
                    <div class="action-card-content">
                        <h5>Nouvelle Réservation</h5>
                        <p>Réservez un nouveau service rapidement</p>
                    </div>
                    <div class="action-card-arrow">
                        <i class="fas fa-chevron-right"></i>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-4 col-md-6">
            <a href="${pageContext.request.contextPath}/reservation?action=list" class="text-decoration-none">
                <div class="action-card fade-in" style="animation-delay: 0.3s;">
                    <div class="action-card-icon info">
                        <i class="fas fa-list-alt"></i>
                    </div>
                    <div class="action-card-content">
                        <h5>Mes Réservations</h5>
                        <p>Consultez l'historique de vos réservations</p>
                    </div>
                    <div class="action-card-arrow">
                        <i class="fas fa-chevron-right"></i>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <!-- Contenu Principal -->
    <div class="row g-4">
        <!-- Réservations Récentes -->
        <div class="col-lg-8">
            <div class="card-modern fade-in">
                <div class="card-header-custom d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-calendar-alt me-2"></i>Réservations Récentes</span>
                    <a href="${pageContext.request.contextPath}/reservation?action=list" class="btn btn-sm btn-light">
                        Voir tout <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
                <div class="card-body-custom p-0">
                    <c:choose>
                        <c:when test="${not empty reservationsRecentes}">
                            <div class="reservation-list">
                                <c:forEach var="reservation" items="${reservationsRecentes}" varStatus="status">
                                    <div class="reservation-item">
                                        <div class="reservation-icon">
                                            <i class="fas fa-concierge-bell"></i>
                                        </div>
                                        <div class="reservation-details">
                                            <h6 class="reservation-title">${fn:escapeXml(reservation.service.nom)}</h6>
                                            <div class="reservation-meta">
                                                <span><i class="fas fa-user-tie me-1"></i>${fn:escapeXml(reservation.prestataire.nom)} ${fn:escapeXml(reservation.prestataire.prenom)}</span>
                                                <span><i class="fas fa-calendar me-1"></i><fmt:formatDate value="${reservation.dateReservation}" pattern="dd MMM yyyy"/></span>
                                            </div>
                                        </div>
                                        <div class="reservation-status">
                                            <c:choose>
                                                <c:when test="${reservation.statut == 'EN_ATTENTE'}">
                                                    <span class="status-badge pending">En attente</span>
                                                </c:when>
                                                <c:when test="${reservation.statut == 'CONFIRMEE'}">
                                                    <span class="status-badge confirmed">Confirmée</span>
                                                </c:when>
                                                <c:when test="${reservation.statut == 'TERMINEE'}">
                                                    <span class="status-badge completed">Terminée</span>
                                                </c:when>
                                                <c:when test="${reservation.statut == 'ANNULEE'}">
                                                    <span class="status-badge cancelled">Annulée</span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-state-icon">
                                    <i class="fas fa-calendar-times"></i>
                                </div>
                                <h5>Aucune réservation</h5>
                                <p>Vous n'avez pas encore effectué de réservation</p>
                                <a href="${pageContext.request.contextPath}/service?action=list" class="btn btn-primary-custom btn-sm">
                                    <i class="fas fa-plus me-2"></i>Réserver maintenant
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- Notifications Récentes -->
            <div class="card-modern fade-in mt-4">
                <div class="card-header-custom d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-bell me-2"></i>Notifications</span>
                    <a href="${pageContext.request.contextPath}/notification?action=list" class="btn btn-sm btn-light">
                        Voir tout <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
                <div class="card-body-custom p-0">
                    <c:choose>
                        <c:when test="${not empty notificationsRecentes}">
                            <div class="notification-list">
                                <c:forEach var="notif" items="${notificationsRecentes}">
                                    <div class="notification-item">
                                        <div class="notification-icon">
                                            <i class="fas fa-info-circle"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>${fn:escapeXml(notif.message)}</p>
                                            <small><fmt:formatDate value="${notif.dateNotification}" pattern="dd/MM/yyyy HH:mm"/></small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state-small">
                                <i class="fas fa-bell-slash"></i>
                                <span>Aucune notification</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Services Populaires -->
            <!-- Services Populaires -->
<div class="card-modern fade-in mb-4">
    <div class="card-header-custom">
        <i class="fas fa-fire me-2"></i>Services Populaires
    </div>
    <div class="card-body-custom">
        <div class="popular-services">
            <c:forEach var="service" items="${servicesPopulaires}">
                <div class="service-item">
                    <div class="service-icon" style="background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);">
                        <i class="fas fa-concierge-bell"></i>
                    </div>
                    <div class="service-info">
                        <h6>${fn:escapeXml(service.nom)}</h6>
                        <span class="service-price">à partir de ${service.prix}€</span>
                    </div>
                    <div class="service-rating">
                        <i class="fas fa-star"></i> 4.8
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty servicesPopulaires}">
                <div class="text-center text-muted py-3">
                    <i class="fas fa-info-circle me-2"></i>Aucun service disponible
                </div>
            </c:if>
        </div>
        
        <a href="${pageContext.request.contextPath}/service?action=list" class="btn btn-outline-custom w-100 mt-3">
            <i class="fas fa-th-large me-2"></i>Tous les services
        </a>
    </div>
</div>
            
            <!-- Besoin d'aide -->
            <div class="card-modern fade-in help-card">
                <div class="card-body-custom text-center">
                    <div class="help-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h5>Besoin d'aide ?</h5>
                    <p class="text-muted">Notre équipe est disponible pour vous aider</p>
                    <a href="${pageContext.request.contextPath}/reclamation?action=add" class="btn btn-primary-custom btn-sm">
                        <i class="fas fa-envelope me-2"></i>Nous contacter
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    /* Welcome Section */
    .welcome-section {
        background: linear-gradient(135deg, rgba(79, 70, 229, 0.1) 0%, rgba(99, 102, 241, 0.05) 100%);
        border-radius: 1rem;
        padding: 2rem;
        position: relative;
        overflow: hidden;
    }
    
    .welcome-section::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(79, 70, 229, 0.1) 0%, transparent 70%);
        border-radius: 50%;
    }
    
    .welcome-title {
        font-size: 2rem;
        font-weight: 800;
        color: var(--text-primary);
        margin-bottom: 0.5rem;
    }
    
    .welcome-subtitle {
        color: var(--text-secondary);
        font-size: 1.1rem;
        margin-bottom: 1rem;
    }
    
    .welcome-date {
        color: var(--text-secondary);
        font-size: 0.9rem;
    }
    
    .welcome-illustration {
        font-size: 5rem;
        color: rgba(79, 70, 229, 0.2);
        animation: float 3s ease-in-out infinite;
    }
    
    @keyframes float {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
    }
    
    /* Section Title */
    .section-title {
        font-size: 1.1rem;
        font-weight: 600;
        color: var(--text-primary);
        margin-bottom: 0;
    }
    
    /* Stat Cards Modern */
    .stat-card-modern {
        background: white;
        border-radius: 1rem;
        padding: 1.5rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        position: relative;
        overflow: hidden;
        transition: all 0.3s ease;
    }
    
    .stat-card-modern:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
    }
    
    .stat-card-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
        color: white;
        margin-bottom: 1rem;
    }
    
    .bg-gradient-primary { background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%); }
    .bg-gradient-success { background: linear-gradient(135deg, #10b981 0%, #34d399 100%); }
    .bg-gradient-warning { background: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%); }
    .bg-gradient-info { background: linear-gradient(135deg, #3b82f6 0%, #60a5fa 100%); }
    
    .stat-card-value {
        font-size: 2rem;
        font-weight: 800;
        color: var(--text-primary);
        line-height: 1;
    }
    
    .stat-card-label {
        font-size: 0.875rem;
        color: var(--text-secondary);
        margin-top: 0.25rem;
    }
    
    .stat-card-trend {
        font-size: 0.75rem;
        margin-top: 0.75rem;
        padding: 0.25rem 0.5rem;
        border-radius: 0.25rem;
        display: inline-block;
    }
    
    .trend-up {
        background: rgba(16, 185, 129, 0.1);
        color: #059669;
    }
    
    .trend-neutral {
        background: rgba(107, 114, 128, 0.1);
        color: #6b7280;
    }
    
    .stat-card-progress {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: #f3f4f6;
    }
    
    .stat-card-progress .progress-bar {
        height: 100%;
        background: linear-gradient(90deg, #4f46e5 0%, #6366f1 100%);
        border-radius: 0 0 1rem 1rem;
    }
    
    /* Action Cards */
    .action-card {
        background: white;
        border-radius: 1rem;
        padding: 1.5rem;
        display: flex;
        align-items: center;
        gap: 1rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        cursor: pointer;
    }
    
    .action-card:hover {
        transform: translateX(5px);
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
    }
    
    .action-card-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.25rem;
        flex-shrink: 0;
    }
    
    .action-card-icon.success {
        background: linear-gradient(135deg, #10b981 0%, #34d399 100%);
    }
    
    .action-card-icon.info {
        background: linear-gradient(135deg, #3b82f6 0%, #60a5fa 100%);
    }
    
    .action-card-content {
        flex: 1;
    }
    
    .action-card-content h5 {
        margin: 0;
        font-size: 1rem;
        font-weight: 600;
        color: var(--text-primary);
    }
    
    .action-card-content p {
        margin: 0.25rem 0 0;
        font-size: 0.8rem;
        color: var(--text-secondary);
    }
    
    .action-card-arrow {
        color: var(--text-secondary);
        transition: transform 0.3s ease;
    }
    
    .action-card:hover .action-card-arrow {
        transform: translateX(5px);
        color: var(--primary-color);
    }
    
    /* Reservation List */
    .reservation-list {
        display: flex;
        flex-direction: column;
    }
    
    .reservation-item {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 1rem 1.5rem;
        border-bottom: 1px solid #f3f4f6;
        transition: background 0.3s ease;
    }
    
    .reservation-item:hover {
        background: #f9fafb;
    }
    
    .reservation-item:last-child {
        border-bottom: none;
    }
    
    .reservation-icon {
        width: 45px;
        height: 45px;
        border-radius: 10px;
        background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        flex-shrink: 0;
    }
    
    .reservation-details {
        flex: 1;
    }
    
    .reservation-title {
        margin: 0;
        font-size: 0.95rem;
        font-weight: 600;
        color: var(--text-primary);
    }
    
    .reservation-meta {
        display: flex;
        gap: 1rem;
        font-size: 0.8rem;
        color: var(--text-secondary);
        margin-top: 0.25rem;
    }
    
    .status-badge {
        padding: 0.35rem 0.75rem;
        border-radius: 2rem;
        font-size: 0.7rem;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .status-badge.pending {
        background: #fef3c7;
        color: #92400e;
    }
    
    .status-badge.confirmed {
        background: #d1fae5;
        color: #065f46;
    }
    
    .status-badge.completed {
        background: #dbeafe;
        color: #1e40af;
    }
    
    .status-badge.cancelled {
        background: #fee2e2;
        color: #991b1b;
    }
    
    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 3rem 2rem;
    }
    
    .empty-state-icon {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: #f3f4f6;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1rem;
        font-size: 2rem;
        color: #9ca3af;
    }
    
    .empty-state h5 {
        color: var(--text-primary);
        margin-bottom: 0.5rem;
    }
    
    .empty-state p {
        color: var(--text-secondary);
        font-size: 0.9rem;
        margin-bottom: 1rem;
    }
    
    .empty-state-small {
        text-align: center;
        padding: 2rem;
        color: var(--text-secondary);
    }
    
    .empty-state-small i {
        font-size: 1.5rem;
        margin-right: 0.5rem;
    }
    
    /* Notification List */
    .notification-list {
        display: flex;
        flex-direction: column;
    }
    
    .notification-item {
        display: flex;
        gap: 1rem;
        padding: 1rem 1.5rem;
        border-bottom: 1px solid #f3f4f6;
    }
    
    .notification-item:last-child {
        border-bottom: none;
    }
    
    .notification-icon {
        width: 35px;
        height: 35px;
        border-radius: 8px;
        background: #e0e7ff;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #4f46e5;
        flex-shrink: 0;
    }
    
    .notification-content {
        flex: 1;
    }
    
    .notification-content p {
        margin: 0;
        font-size: 0.9rem;
        color: var(--text-primary);
    }
    
    .notification-content small {
        color: var(--text-secondary);
    }
    
    /* Popular Services */
    .popular-services {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    
    .service-item {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 0.75rem;
        border-radius: 0.75rem;
        transition: background 0.3s ease;
    }
    
    .service-item:hover {
        background: #f9fafb;
    }
    
    .service-icon {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        flex-shrink: 0;
    }
    
    .service-icon.plomberie { background: linear-gradient(135deg, #3b82f6 0%, #60a5fa 100%); }
    .service-icon.electricite { background: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%); }
    .service-icon.menage { background: linear-gradient(135deg, #10b981 0%, #34d399 100%); }
    .service-icon.jardinage { background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%); }
    
    .service-info {
        flex: 1;
    }
    
    .service-info h6 {
        margin: 0;
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--text-primary);
    }
    
    .service-price {
        font-size: 0.75rem;
        color: var(--text-secondary);
    }
    
    .service-rating {
        font-size: 0.8rem;
        color: #f59e0b;
        font-weight: 600;
    }
    
    /* Help Card */
    .help-card {
        background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
        color: white;
    }
    
    .help-card h5, .help-card p {
        color: white;
    }
    
    .help-card .text-muted {
        color: rgba(255, 255, 255, 0.8) !important;
    }
    
    .help-icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1rem;
        font-size: 1.5rem;
    }
    
    .help-card .btn {
        background: white;
        color: #4f46e5;
        border: none;
    }
    
    .help-card .btn:hover {
        background: #f3f4f6;
    }
</style>

<jsp:include page="../shared/footer.jsp"/>