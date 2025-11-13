<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Réclamations" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-exclamation-triangle text-gradient me-2"></i> Gestion des réclamations</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Réclamations</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/reclamation?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouvelle réclamation
            </a>
        </div>
    </div>
</div>

<!-- Status Overview Cards -->
<div class="row g-4 mb-4 fade-in">
    <div class="col-lg-3 col-md-6">
        <a href="?statut=EN_ATTENTE" class="text-decoration-none">
            <div class="status-card status-pending">
                <div class="status-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="status-info">
                    <h3>12</h3>
                    <p>En attente</p>
                </div>
                <div class="status-badge">
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-lg-3 col-md-6">
        <a href="?statut=EN_COURS" class="text-decoration-none">
            <div class="status-card status-progress">
                <div class="status-icon">
                    <i class="fas fa-sync"></i>
                </div>
                <div class="status-info">
                    <h3>8</h3>
                    <p>En cours</p>
                </div>
                <div class="status-badge">
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-lg-3 col-md-6">
        <a href="?statut=RESOLUE" class="text-decoration-none">
            <div class="status-card status-resolved">
                <div class="status-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="status-info">
                    <h3>45</h3>
                    <p>Résolues</p>
                </div>
                <div class="status-badge">
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-lg-3 col-md-6">
        <a href="?statut=FERMEE" class="text-decoration-none">
            <div class="status-card status-closed">
                <div class="status-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="status-info">
                    <h3>3</h3>
                    <p>Fermées</p>
                </div>
                <div class="status-badge">
                    <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </a>
    </div>
</div>

<!-- Réclamations List -->
<div class="row fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-header-custom d-flex justify-content-between align-items-center">
                <span><i class="fas fa-list me-2"></i> Liste des réclamations</span>
                <div>
                    <button class="btn btn-sm btn-light">
                        <i class="fas fa-filter me-1"></i> Filtrer
                    </button>
                    <button class="btn btn-sm btn-success-custom">
                        <i class="fas fa-file-excel me-1"></i> Exporter
                    </button>
                </div>
            </div>
            <div class="card-body-custom p-0">
                <div class="reclamations-list">
                    <c:forEach var="reclamation" items="${reclamations}">
                        <div class="reclamation-item ${reclamation.statut}">
                            <div class="reclamation-priority">
                                <c:choose>
                                    <c:when test="${reclamation.priorite == 'HAUTE'}">
                                        <span class="priority-badge priority-high">
                                            <i class="fas fa-exclamation-circle"></i>
                                        </span>
                                    </c:when>
                                    <c:when test="${reclamation.priorite == 'MOYENNE'}">
                                        <span class="priority-badge priority-medium">
                                            <i class="fas fa-minus-circle"></i>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="priority-badge priority-low">
                                            <i class="fas fa-arrow-down"></i>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="reclamation-content flex-grow-1">
                                <div class="row align-items-center">
                                    <div class="col-md-6">
                                        <div class="reclamation-header">
                                            <span class="reclamation-id">#${reclamation.id}</span>
                                            <h6 class="reclamation-title mb-1">${reclamation.objet}</h6>
                                            <p class="reclamation-description mb-2 text-muted">
                                                ${reclamation.description}
                                            </p>
                                            <div class="reclamation-meta">
                                                <span class="meta-item">
                                                    <i class="fas fa-user text-muted me-1"></i>
                                                    ${reclamation.client.nom} ${reclamation.client.prenom}
                                                </span>
                                                <span class="meta-item">
                                                    <i class="fas fa-calendar text-muted me-1"></i>
                                                    <c:out value="${reclamation.dateReclamation}" default="Aujourd'hui"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 text-center">
                                        <c:choose>
                                            <c:when test="${reclamation.statut == 'EN_ATTENTE'}">
                                                <span class="badge-custom badge-warning-custom">
                                                    <i class="fas fa-clock me-1"></i> En attente
                                                </span>
                                            </c:when>
                                            <c:when test="${reclamation.statut == 'EN_COURS'}">
                                                <span class="badge-custom badge-primary-custom">
                                                    <i class="fas fa-sync me-1"></i> En cours
                                                </span>
                                            </c:when>
                                            <c:when test="${reclamation.statut == 'RESOLUE'}">
                                                <span class="badge-custom badge-success-custom">
                                                    <i class="fas fa-check-circle me-1"></i> Résolue
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-custom badge-danger-custom">
                                                    <i class="fas fa-times-circle me-1"></i> Fermée
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-3 text-end">
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/reclamation?action=edit&id=${reclamation.id}" 
                                               class="btn btn-sm btn-primary-custom">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/reclamation?action=delete&id=${reclamation.id}" 
                                               class="btn btn-sm btn-danger-custom btn-delete-confirm">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty reclamations}">
                        <div class="text-center py-5">
                            <i class="fas fa-inbox fa-3x text-muted mb-3 d-block"></i>
                            <h5 class="text-muted mb-2">Aucune réclamation trouvée</h5>
                            <p class="text-muted mb-4">Les réclamations apparaîtront ici</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .status-card {
        background: white;
        border-radius: 0.75rem;
        padding: 1.5rem;
        display: flex;
        align-items: center;
        gap: 1rem;
        box-shadow: var(--shadow-sm);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }
    
    .status-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
    }
    
    .status-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-lg);
    }
    
    .status-pending::before { background: linear-gradient(90deg, #f59e0b, #fbbf24); }
    .status-progress::before { background: linear-gradient(90deg, #4f46e5, #6366f1); }
    .status-resolved::before { background: linear-gradient(90deg, #10b981, #34d399); }
    .status-closed::before { background: linear-gradient(90deg, #ef4444, #f87171); }
    
    .status-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
    }
    
    .status-pending .status-icon { background: linear-gradient(135deg, #f59e0b, #fbbf24); }
    .status-progress .status-icon { background: linear-gradient(135deg, #4f46e5, #6366f1); }
    .status-resolved .status-icon { background: linear-gradient(135deg, #10b981, #34d399); }
    .status-closed .status-icon { background: linear-gradient(135deg, #ef4444, #f87171); }
    
    .status-info h3 {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 0;
        color: var(--text-primary);
    }
    
    .status-info p {
        margin-bottom: 0;
        color: var(--text-secondary);
    }
    
    .status-badge {
        margin-left: auto;
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background: #f3f4f6;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--text-secondary);
    }
    
    .reclamations-list {
        display: flex;
        flex-direction: column;
    }
    
    .reclamation-item {
        display: flex;
        gap: 1.5rem;
        padding: 1.5rem;
        border-bottom: 1px solid #f3f4f6;
        transition: all 0.3s ease;
    }
    
    .reclamation-item:hover {
        background: #f9fafb;
    }
    
    .reclamation-item:last-child {
        border-bottom: none;
    }
    
    .priority-badge {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
        color: white;
    }
    
    .priority-high {
        background: linear-gradient(135deg, #ef4444, #f87171);
        animation: pulse 2s infinite;
    }
    
    .priority-medium {
        background: linear-gradient(135deg, #f59e0b, #fbbf24);
    }
    
    .priority-low {
        background: linear-gradient(135deg, #6b7280, #9ca3af);
    }
    
    @keyframes pulse {
        0%, 100% {
            box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.7);
        }
        50% {
            box-shadow: 0 0 0 10px rgba(239, 68, 68, 0);
        }
    }
    
    .reclamation-id {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
        color: white;
        padding: 0.25rem 0.75rem;
        border-radius: 0.375rem;
        font-weight: 700;
        font-size: 0.75rem;
    }
    
    .reclamation-title {
        margin-top: 0.5rem;
        color: var(--text-primary);
    }
    
    .reclamation-description {
        font-size: 0.875rem;
        line-height: 1.5;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    
    .reclamation-meta {
        display: flex;
        gap: 1rem;
        flex-wrap: wrap;
    }
    
    .meta-item {
        font-size: 0.875rem;
        color: var(--text-secondary);
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
