<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Intervention" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier l'intervention</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/intervention?action=list">Interventions</a></li>
                    <li class="breadcrumb-item active">Modifier</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <!-- Progress Tracker -->
        <div class="card-modern mb-4">
            <div class="card-body-custom">
                <div class="progress-tracker">
                    <div class="progress-step ${intervention.statut == 'PLANIFIEE' || intervention.statut == 'EN_COURS' || intervention.statut == 'TERMINEE' ? 'completed' : ''}">
                        <div class="progress-icon">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <div class="progress-label">Planifiée</div>
                    </div>
                    <div class="progress-line ${intervention.statut == 'EN_COURS' || intervention.statut == 'TERMINEE' ? 'completed' : ''}"></div>
                    <div class="progress-step ${intervention.statut == 'EN_COURS' || intervention.statut == 'TERMINEE' ? 'completed' : ''} ${intervention.statut == 'EN_COURS' ? 'active' : ''}">
                        <div class="progress-icon">
                            <i class="fas fa-tools"></i>
                        </div>
                        <div class="progress-label">En cours</div>
                    </div>
                    <div class="progress-line ${intervention.statut == 'TERMINEE' ? 'completed' : ''}"></div>
                    <div class="progress-step ${intervention.statut == 'TERMINEE' ? 'completed' : ''}">
                        <div class="progress-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="progress-label">Terminée</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Form -->
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-clipboard-list me-2"></i> Détails de l'intervention #${intervention.id}
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/intervention?action=edit" method="post">
                    <input type="hidden" name="id" value="${intervention.id}">
                    
                    <!-- Intervention Info Card -->
                    <div class="info-banner mb-4">
                        <div class="info-banner-content">
                            <div class="info-item">
                                <i class="fas fa-calendar"></i>
                                <div>
                                    <small>Date de création</small>
                                    <strong><c:out value="${intervention.dateIntervention}" default="Non définie"/></strong>
                                </div>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-user"></i>
                                <div>
                                    <small>Client</small>
                                    <strong>${intervention.reservation.client.nom} ${intervention.reservation.client.prenom}</strong>
                                </div>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-briefcase"></i>
                                <div>
                                    <small>Service</small>
                                    <strong>${intervention.reservation.service.nom}</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Reservation (Read-only) -->
                    <div class="mb-4">
                        <label class="form-label-modern">
                            <i class="fas fa-ticket-alt me-1"></i> Réservation associée
                        </label>
                        <div class="form-control-modern bg-light">
                            <i class="fas fa-link me-2"></i>
                            Réservation #${intervention.reservation.id} - ${intervention.reservation.service.nom}
                        </div>
                    </div>
                    
                    <!-- Prestataire Selection -->
                    <div class="mb-4">
                        <label for="prestataire_id" class="form-label-modern">
                            <i class="fas fa-user-tie me-1"></i> Prestataire assigné *
                        </label>
                        <select class="form-select-modern" id="prestataire_id" name="prestataire_id" required>
                            <c:forEach var="prestataire" items="${prestataires}">
                                <option value="${prestataire.id}" ${intervention.prestataire.id == prestataire.id ? 'selected' : ''}>
                                    ${prestataire.nom} ${prestataire.prenom} - ${prestataire.specialite}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Status Update -->
                    <div class="mb-4">
                        <label class="form-label-modern">
                            <i class="fas fa-flag me-1"></i> Mettre à jour le statut *
                        </label>
                        <div class="status-update-grid">
                            <label class="status-update-card">
                                <input type="radio" name="statut" value="PLANIFIEE" ${intervention.statut == 'PLANIFIEE' ? 'checked' : ''}>
                                <div class="card-content">
                                    <i class="fas fa-calendar-plus text-warning"></i>
                                    <span>Planifiée</span>
                                    <small>Intervention programmée</small>
                                </div>
                            </label>
                            <label class="status-update-card">
                                <input type="radio" name="statut" value="EN_COURS" ${intervention.statut == 'EN_COURS' ? 'checked' : ''}>
                                <div class="card-content">
                                    <i class="fas fa-play-circle text-success"></i>
                                    <span>En cours</span>
                                    <small>Travaux en cours</small>
                                </div>
                            </label>
                            <label class="status-update-card">
                                <input type="radio" name="statut" value="TERMINEE" ${intervention.statut == 'TERMINEE' ? 'checked' : ''}>
                                <div class="card-content">
                                    <i class="fas fa-check-circle text-info"></i>
                                    <span>Terminée</span>
                                    <small>Intervention complétée</small>
                                </div>
                            </label>
                            <label class="status-update-card">
                                <input type="radio" name="statut" value="ANNULEE" ${intervention.statut == 'ANNULEE' ? 'checked' : ''}>
                                <div class="card-content">
                                    <i class="fas fa-times-circle text-danger"></i>
                                    <span>Annulée</span>
                                    <small>Intervention annulée</small>
                                </div>
                            </label>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-between">
                        <a href="${pageContext.request.contextPath}/intervention?action=delete&id=${intervention.id}" 
                           class="btn btn-danger-custom btn-delete-confirm">
                            <i class="fas fa-trash me-2"></i> Supprimer
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/intervention?action=list" 
                               class="btn btn-outline-custom">
                                <i class="fas fa-times me-2"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-primary-custom">
                                <i class="fas fa-save me-2"></i> Enregistrer
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .progress-tracker {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1rem 2rem;
    }
    
    .progress-step {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 0.5rem;
        position: relative;
    }
    
    .progress-icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background: #e5e7eb;
        color: #9ca3af;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        transition: all 0.4s ease;
        border: 4px solid white;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    
    .progress-step.completed .progress-icon {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
    }
    
    .progress-step.active .progress-icon {
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
        color: white;
        animation: pulse-border 2s infinite;
    }
    
    @keyframes pulse-border {
        0%, 100% {
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3), 0 0 0 0 rgba(79, 70, 229, 0.4);
        }
        50% {
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3), 0 0 0 10px rgba(79, 70, 229, 0);
        }
    }
    
    .progress-label {
        font-size: 0.875rem;
        font-weight: 600;
        color: #6b7280;
    }
    
    .progress-step.completed .progress-label,
    .progress-step.active .progress-label {
        color: var(--primary-color);
    }
    
    .progress-line {
        flex: 1;
        height: 3px;
        background: #e5e7eb;
        margin: 0 1rem;
        position: relative;
        top: -15px;
    }
    
    .progress-line.completed {
        background: linear-gradient(90deg, #10b981 0%, #059669 100%);
    }
    
    .info-banner {
        background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        border-radius: 1rem;
        padding: 1.5rem;
        border: 2px solid #bae6fd;
    }
    
    .info-banner-content {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 1.5rem;
    }
    
    .info-item {
        display: flex;
        align-items: center;
        gap: 1rem;
    }
    
    .info-item i {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        background: white;
        color: var(--primary-color);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
    }
    
    .info-item small {
        display: block;
        font-size: 0.75rem;
        color: #0369a1;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }
    
    .info-item strong {
        display: block;
        color: #075985;
    }
    
    .status-update-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
    }
    
    .status-update-card input[type="radio"] {
        display: none;
    }
    
    .status-update-card .card-content {
        padding: 1.5rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.75rem;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        background: white;
    }
    
    .status-update-card .card-content i {
        font-size: 2.5rem;
        margin-bottom: 0.75rem;
        display: block;
    }
    
    .status-update-card .card-content span {
        display: block;
        font-weight: 700;
        font-size: 1.125rem;
        margin-bottom: 0.25rem;
        color: #111827;
    }
    
    .status-update-card .card-content small {
        color: #6b7280;
        font-size: 0.875rem;
    }
    
    .status-update-card input[type="radio"]:checked + .card-content {
        border-color: var(--primary-color);
        background: linear-gradient(135deg, #f0f4ff 0%, #e0e7ff 100%);
        transform: scale(1.05);
        box-shadow: 0 8px 20px rgba(79, 70, 229, 0.2);
    }
    
    @media (max-width: 768px) {
        .info-banner-content {
            grid-template-columns: 1fr;
        }
        
        .status-update-grid {
            grid-template-columns: 1fr;
        }
        
        .progress-tracker {
            flex-wrap: wrap;
        }
    }
</style>

<jsp:include page="../shared/footer.jsp"/>
