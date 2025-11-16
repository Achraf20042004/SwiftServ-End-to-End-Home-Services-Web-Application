<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouvelle Intervention" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-wrench text-gradient me-2"></i> Planifier une nouvelle intervention</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/intervention?action=list">Interventions</a></li>
                    <li class="breadcrumb-item active">Nouvelle</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-clipboard-list me-2"></i> Détails de l'intervention
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/intervention?action=add" method="post">
                    
                    <!-- Step Indicator -->
                    <div class="steps-indicator mb-4">
                        <div class="step active">
                            <div class="step-number">1</div>
                            <div class="step-label">Réservation</div>
                        </div>
                        <div class="step">
                            <div class="step-number">2</div>
                            <div class="step-label">Prestataire</div>
                        </div>
                        <div class="step">
                            <div class="step-number">3</div>
                            <div class="step-label">Planification</div>
                        </div>
                    </div>
                    
                    <!-- Reservation Selection -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-calendar-check me-2"></i> Réservation associée
                        </h5>
                        <hr>
                        <label for="reservation_id" class="form-label-modern">
                            <i class="fas fa-ticket-alt me-1"></i> Sélectionner une réservation *
                        </label>
                        <select class="form-select-modern" id="reservation_id" name="reservation_id" required>
                            <option value="">Choisir une réservation confirmée</option>
                            <c:forEach var="reservation" items="${reservations}">
                                <option value="${reservation.id}" 
                                        data-client="${reservation.client.nom} ${reservation.client.prenom}"
                                        data-service="${reservation.service.nom}"
                                        data-prestataire-id="${reservation.prestataire.id}">
                                    #${reservation.id} - ${reservation.client.nom} ${reservation.client.prenom} - ${reservation.service.nom}
                                </option>
                            </c:forEach>
                        </select>
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i> Seules les réservations confirmées sont affichées
                        </small>
                    </div>
                    
                    <!-- Prestataire Selection -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user-tie me-2"></i> Prestataire assigné
                        </h5>
                        <hr>
                        <label for="prestataire_id" class="form-label-modern">
                            <i class="fas fa-user-check me-1"></i> Sélectionner le prestataire *
                        </label>
                        <select class="form-select-modern" id="prestataire_id" name="prestataire_id" required>
                            <option value="">Choisir un prestataire disponible</option>
                            <c:forEach var="prestataire" items="${prestataires}">
                                <option value="${prestataire.id}">
                                    ${prestataire.nom} ${prestataire.prenom} - ${prestataire.specialite}
                                    <c:if test="${prestataire.disponibilite == 'disponible'}">
                                        ✓ Disponible
                                    </c:if>
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Status Selection -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-flag me-2"></i> État de l'intervention
                        </h5>
                        <hr>
                        <label for="statut" class="form-label-modern">
                            <i class="fas fa-traffic-light me-1"></i> Statut initial *
                        </label>
                        <div class="status-selector">
                            <label class="status-option">
                                <input type="radio" name="statut" value="PLANIFIEE" checked>
                                <div class="status-card">
                                    <i class="fas fa-calendar-plus text-warning"></i>
                                    <span>Planifiée</span>
                                </div>
                            </label>
                            <label class="status-option">
                                <input type="radio" name="statut" value="EN_COURS">
                                <div class="status-card">
                                    <i class="fas fa-play-circle text-success"></i>
                                    <span>En cours</span>
                                </div>
                            </label>
                            <label class="status-option">
                                <input type="radio" name="statut" value="TERMINEE">
                                <div class="status-card">
                                    <i class="fas fa-check-circle text-info"></i>
                                    <span>Terminée</span>
                                </div>
                            </label>
                        </div>
                    </div>
                    
                    <!-- Summary Preview -->
                    <div class="alert" style="background: linear-gradient(135deg, #f0f4ff 0%, #e0e7ff 100%); border: none;">
                        <h6 class="text-primary mb-3">
                            <i class="fas fa-clipboard-check me-2"></i> Récapitulatif de l'intervention
                        </h6>
                        <div class="summary-grid">
                            <div class="summary-item">
                                <i class="fas fa-user text-primary"></i>
                                <div>
                                    <small class="text-muted">Client</small>
                                    <p class="mb-0" id="preview-client">-</p>
                                </div>
                            </div>
                            <div class="summary-item">
                                <i class="fas fa-briefcase text-info"></i>
                                <div>
                                    <small class="text-muted">Service</small>
                                    <p class="mb-0" id="preview-service">-</p>
                                </div>
                            </div>
                            <div class="summary-item">
                                <i class="fas fa-user-tie text-success"></i>
                                <div>
                                    <small class="text-muted">Prestataire</small>
                                    <p class="mb-0" id="preview-prestataire">-</p>
                                </div>
                            </div>
                            <div class="summary-item">
                                <i class="fas fa-flag text-warning"></i>
                                <div>
                                    <small class="text-muted">Statut</small>
                                    <p class="mb-0" id="preview-statut">Planifiée</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/intervention?action=list" 
                           class="btn btn-outline-custom">
                            <i class="fas fa-times me-2"></i> Annuler
                        </a>
                        <button type="submit" class="btn btn-success-custom">
                            <i class="fas fa-calendar-check me-2"></i> Planifier l'intervention
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .steps-indicator {
        display: flex;
        justify-content: space-between;
        position: relative;
        padding: 0 2rem;
    }
    
    .steps-indicator::before {
        content: '';
        position: absolute;
        top: 20px;
        left: 10%;
        right: 10%;
        height: 2px;
        background: #e5e7eb;
        z-index: 0;
    }
    
    .step {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 0.5rem;
        position: relative;
        z-index: 1;
    }
    
    .step-number {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #e5e7eb;
        color: #6b7280;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        transition: all 0.3s ease;
    }
    
    .step.active .step-number {
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
        color: white;
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
    }
    
    .step-label {
        font-size: 0.875rem;
        color: #6b7280;
        font-weight: 500;
    }
    
    .step.active .step-label {
        color: var(--primary-color);
        font-weight: 600;
    }
    
    .status-selector {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 1rem;
    }
    
    .status-option input[type="radio"] {
        display: none;
    }
    
    .status-card {
        padding: 1.5rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.75rem;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        background: white;
    }
    
    .status-card i {
        font-size: 2rem;
        margin-bottom: 0.5rem;
        display: block;
    }
    
    .status-card span {
        font-weight: 600;
        color: #374151;
    }
    
    .status-option input[type="radio"]:checked + .status-card {
        border-color: var(--primary-color);
        background: #f0f4ff;
        transform: translateY(-4px);
        box-shadow: 0 8px 16px rgba(79, 70, 229, 0.15);
    }
    
    .summary-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1.5rem;
    }
    
    .summary-item {
        display: flex;
        align-items: flex-start;
        gap: 1rem;
    }
    
    .summary-item i {
        font-size: 1.5rem;
        margin-top: 0.25rem;
    }
    
    .summary-item small {
        display: block;
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }
    
    @media (max-width: 768px) {
        .status-selector {
            grid-template-columns: 1fr;
        }
        
        .summary-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<script>
    // Update preview on selection
    document.getElementById('reservation_id').addEventListener('change', function(e) {
        const option = e.target.options[e.target.selectedIndex];
        document.getElementById('preview-client').textContent = option.dataset.client || '-';
        document.getElementById('preview-service').textContent = option.dataset.service || '-';
        
        // Auto-select prestataire if available
        const prestataireId = option.dataset.prestataireId;
        if (prestataireId) {
            document.getElementById('prestataire_id').value = prestataireId;
            const prestataireOption = document.getElementById('prestataire_id').options[document.getElementById('prestataire_id').selectedIndex];
            document.getElementById('preview-prestataire').textContent = prestataireOption.text.split(' - ')[0] || '-';
        }
    });
    
    document.getElementById('prestataire_id').addEventListener('change', function(e) {
        const text = e.target.options[e.target.selectedIndex].text.split(' - ')[0];
        document.getElementById('preview-prestataire').textContent = text || '-';
    });
    
    document.querySelectorAll('input[name="statut"]').forEach(function(radio) {
        radio.addEventListener('change', function() {
            const statuts = {
                'PLANIFIEE': 'Planifiée',
                'EN_COURS': 'En cours',
                'TERMINEE': 'Terminée'
            };
            document.getElementById('preview-statut').textContent = statuts[this.value];
        });
    });
</script>

<jsp:include page="../shared/footer.jsp"/>
