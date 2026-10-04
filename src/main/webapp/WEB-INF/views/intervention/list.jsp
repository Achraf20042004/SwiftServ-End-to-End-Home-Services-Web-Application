<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Interventions" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-tools text-gradient me-2"></i> Gestion des interventions</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Interventions</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/intervention?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouvelle intervention
            </a>
        </div>
    </div>
</div>

<!-- Stats Cards -->
<div class="row g-3 mb-4 fade-in">
    <div class="col-lg-3 col-md-6">
        <div class="mini-stat-card bg-gradient-primary">
            <div class="stat-content">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div>
                    <h4 class="mb-0">${countPlanifiee}</h4>
					<p class="mb-0">En attente</p>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="mini-stat-card bg-gradient-success">
            <div class="stat-content">
                <div class="stat-icon">
                    <i class="fas fa-play"></i>
                </div>
                <div>
                    <h4 class="mb-0">${countEnCours}</h4>
					<p class="mb-0">En cours</p>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="mini-stat-card bg-gradient-info">
            <div class="stat-content">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div>
                    <h4 class="mb-0">${countTerminee}</h4>
					<p class="mb-0">Terminées</p>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="mini-stat-card bg-gradient-warning">
            <div class="stat-content">
                <div class="stat-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div>
                    <h4 class="mb-0">${countAnnulee}</h4>
					<p class="mb-0">Problèmes signalés</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Timeline View -->
<div class="row fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-header-custom d-flex justify-content-between align-items-center">
                <span><i class="fas fa-list-alt me-2"></i> Interventions planifiées</span>
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-sm btn-light active">
                        <i class="fas fa-list me-1"></i> Liste
                    </button>
                    <button type="button" class="btn btn-sm btn-light">
                        <i class="fas fa-calendar me-1"></i> Calendrier
                    </button>
                </div>
            </div>
            <div class="card-body-custom">
                <c:forEach var="intervention" items="${interventions}">
                    <div class="intervention-timeline-item">
                        <div class="timeline-marker">
                            <c:choose>
                                <c:when test="${intervention.statut == 'PLANIFIEE'}">
                                    <div class="marker-dot bg-warning"></div>
                                </c:when>
                                <c:when test="${intervention.statut == 'EN_COURS'}">
                                    <div class="marker-dot bg-success pulsing"></div>
                                </c:when>
                                <c:when test="${intervention.statut == 'TERMINEE'}">
                                    <div class="marker-dot bg-info"></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="marker-dot bg-danger"></div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="timeline-content">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <div class="d-flex align-items-start">
                                        <div class="intervention-icon me-3">
                                            <i class="fas fa-wrench"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1">
                                                Intervention #${intervention.id}
                                                <c:choose>
                                                    <c:when test="${intervention.statut == 'PLANIFIEE'}">
                                                        <span class="badge-custom badge-warning-custom ms-2">
                                                            <i class="fas fa-clock me-1"></i> Planifiée
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${intervention.statut == 'EN_COURS'}">
                                                        <span class="badge-custom badge-success-custom ms-2">
                                                            <i class="fas fa-spinner fa-spin me-1"></i> En cours
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${intervention.statut == 'TERMINEE'}">
                                                        <span class="badge-custom badge-info-custom ms-2">
                                                            <i class="fas fa-check me-1"></i> Terminée
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-custom badge-danger-custom ms-2">
                                                            <i class="fas fa-times me-1"></i> Annulée
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </h6>
                                            <p class="text-muted small mb-2">
                                                <i class="fas fa-calendar me-1"></i>
                                                <c:out value="${intervention.dateIntervention}" default="Date à définir"/>
                                            </p>
                                            <div class="row g-2 small">
                                                <div class="col-md-6">
                                                    <i class="fas fa-user text-primary me-1"></i>
                                                    <strong>Client:</strong> ${fn:escapeXml(intervention.reservation.client.nom)} ${fn:escapeXml(intervention.reservation.client.prenom)}
                                                </div>
                                                <div class="col-md-6">
                                                    <i class="fas fa-user-tie text-success me-1"></i>
                                                    <strong>Prestataire:</strong> ${fn:escapeXml(intervention.prestataire.nom)} ${fn:escapeXml(intervention.prestataire.prenom)}
                                                </div>
                                                <div class="col-md-6">
                                                    <i class="fas fa-briefcase text-info me-1"></i>
                                                    <strong>Service:</strong> ${fn:escapeXml(intervention.reservation.service.nom)}
                                                </div>
                                                <div class="col-md-6">
                                                    <i class="fas fa-receipt text-warning me-1"></i>
                                                    <strong>Réservation:</strong> #${intervention.reservation.id}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 text-end">
                                    <div class="action-buttons">
                                        <c:if test="${intervention.statut == 'PLANIFIEE'}">
                                            <button class="btn btn-sm btn-success-custom">
                                                <i class="fas fa-play me-1"></i> Démarrer
                                            </button>
                                        </c:if>
                                        <c:if test="${intervention.statut == 'EN_COURS'}">
                                            <button class="btn btn-sm btn-info">
                                                <i class="fas fa-check me-1"></i> Terminer
                                            </button>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/intervention?action=edit&id=${intervention.id}" 
                                           class="btn btn-sm btn-outline-custom">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button class="btn btn-sm btn-outline-custom">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty interventions}">
                    <div class="text-center py-5">
                        <i class="fas fa-calendar-times fa-3x text-muted mb-3 d-block"></i>
                        <h5 class="text-muted mb-2">Aucune intervention planifiée</h5>
                        <p class="text-muted mb-4">Les interventions apparaîtront ici une fois créées</p>
                        <a href="${pageContext.request.contextPath}/intervention?action=add" class="btn btn-primary-custom">
                            <i class="fas fa-plus me-2"></i> Planifier une intervention
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<style>
    .mini-stat-card {
        padding: 1.5rem;
        border-radius: 1rem;
        color: white;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }
    
    .mini-stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
    }
    
    .mini-stat-card .stat-content {
        display: flex;
        align-items: center;
        gap: 1rem;
    }
    
    .mini-stat-card .stat-icon {
        width: 50px;
        height: 50px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
    }
    
    .mini-stat-card h4 {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 0;
    }
    
    .mini-stat-card p {
        font-size: 0.875rem;
        opacity: 0.9;
    }
    
    .bg-gradient-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    
    .bg-gradient-success {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    }
    
    .bg-gradient-info {
        background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
    }
    
    .bg-gradient-warning {
        background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
    }
    
    .intervention-timeline-item {
        position: relative;
        padding-left: 3rem;
        padding-bottom: 2rem;
        border-left: 2px solid #e5e7eb;
    }
    
    .intervention-timeline-item:last-child {
        border-left: none;
        padding-bottom: 0;
    }
    
    .timeline-marker {
        position: absolute;
        left: -8px;
        top: 0;
    }
    
    .marker-dot {
        width: 16px;
        height: 16px;
        border-radius: 50%;
        border: 3px solid white;
        box-shadow: 0 0 0 2px #e5e7eb;
    }
    
    .marker-dot.pulsing {
        animation: pulse 2s infinite;
    }
    
    @keyframes pulse {
        0%, 100% {
            box-shadow: 0 0 0 2px #e5e7eb, 0 0 0 4px rgba(16, 185, 129, 0.4);
        }
        50% {
            box-shadow: 0 0 0 2px #e5e7eb, 0 0 0 8px rgba(16, 185, 129, 0.1);
        }
    }
    
    .timeline-content {
        background: #f9fafb;
        padding: 1.5rem;
        border-radius: 0.75rem;
        border-left: 4px solid var(--primary-color);
        transition: all 0.3s ease;
    }
    
    .timeline-content:hover {
        background: white;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }
    
    .intervention-icon {
        width: 45px;
        height: 45px;
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.25rem;
    }
</style>

<jsp:include page="../shared/footer.jsp"/>
