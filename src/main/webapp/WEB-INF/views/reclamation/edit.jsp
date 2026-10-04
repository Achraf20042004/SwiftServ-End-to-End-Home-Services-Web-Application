<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Réclamation" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier la réclamation</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/reclamation?action=list">Réclamations</a></li>
                    <li class="breadcrumb-item active">Modifier</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-edit me-2"></i> Modifier la réclamation
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/reclamation?action=edit" method="post">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                    <input type="hidden" name="id" value="${reclamation.id}">
                    
                    <!-- Réclamation Info -->
                    <div class="alert alert-info-modern mb-4">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <strong><i class="fas fa-info-circle me-2"></i> Réclamation #${reclamation.id}</strong>
                                <p class="mb-0 small text-muted mt-1">
                                    Créée le: <c:out value="${reclamation.dateReclamation}" default="Aujourd'hui"/>
                                </p>
                            </div>
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
                    </div>
                    
                    <!-- Client (Read-only) -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user me-2"></i> Client
                        </h5>
                        <hr>
                        <div class="info-box">
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle bg-primary me-3">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div>
                                    <strong>${fn:escapeXml(reclamation.client.nom)} ${fn:escapeXml(reclamation.client.prenom)}</strong>
                                    <br><small class="text-muted">${fn:escapeXml(reclamation.client.email)}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Réclamation Details -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-file-alt me-2"></i> Détails de la réclamation
                        </h5>
                        <hr>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="priorite" class="form-label-modern">
                                    <i class="fas fa-flag me-1"></i> Priorité *
                                </label>
                                <select class="form-select-modern" id="priorite" name="priorite" required>
                                    <option value="BASSE" ${reclamation.priorite == 'BASSE' ? 'selected' : ''}>🟢 Basse</option>
                                    <option value="MOYENNE" ${reclamation.priorite == 'MOYENNE' ? 'selected' : ''}>🟡 Moyenne</option>
                                    <option value="HAUTE" ${reclamation.priorite == 'HAUTE' ? 'selected' : ''}>🔴 Haute</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="statut" class="form-label-modern">
                                    <i class="fas fa-traffic-light me-1"></i> Statut *
                                </label>
                                <select class="form-select-modern" id="statut" name="statut" required>
                                    <option value="EN_ATTENTE" ${reclamation.statut == 'EN_ATTENTE' ? 'selected' : ''}>En attente</option>
                                    <option value="EN_COURS" ${reclamation.statut == 'EN_COURS' ? 'selected' : ''}>En cours</option>
                                    <option value="RESOLUE" ${reclamation.statut == 'RESOLUE' ? 'selected' : ''}>Résolue</option>
                                    <option value="FERMEE" ${reclamation.statut == 'FERMEE' ? 'selected' : ''}>Fermée</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="objet" class="form-label-modern">
                                <i class="fas fa-heading me-1"></i> Objet de la réclamation *
                            </label>
                            <input type="text" class="form-control-modern" id="objet" name="objet" 
                                   value="${reclamation.objet}" maxlength="200" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label-modern">
                                <i class="fas fa-align-left me-1"></i> Description détaillée *
                            </label>
                            <textarea class="form-control-modern" id="description" name="description" 
                                      rows="6" maxlength="1000" required>${fn:escapeXml(reclamation.description)}</textarea>
                            <div class="d-flex justify-content-end">
                                <small class="text-muted">
                                    <span id="char-count">${reclamation.description.length()}</span>/1000 caractères
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-between">
                        <a href="${pageContext.request.contextPath}/reclamation?action=delete&id=${reclamation.id}" 
                           class="btn btn-danger-custom btn-delete-confirm">
                            <i class="fas fa-trash me-2"></i> Supprimer cette réclamation
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/reclamation?action=list" 
                               class="btn btn-outline-custom">
                                <i class="fas fa-times me-2"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-primary-custom">
                                <i class="fas fa-save me-2"></i> Enregistrer les modifications
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Timeline -->
        <div class="card-modern mt-4">
            <div class="card-header-custom">
                <i class="fas fa-history me-2"></i> Historique de traitement
            </div>
            <div class="card-body-custom">
                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-marker bg-primary">
                            <i class="fas fa-plus"></i>
                        </div>
                        <div class="timeline-content">
                            <strong>Réclamation créée</strong>
                            <p class="text-muted small mb-0">
                                <c:out value="${reclamation.dateReclamation}" default="Aujourd'hui"/> - Par système
                            </p>
                        </div>
                    </div>
                    
                    <c:if test="${reclamation.statut == 'EN_COURS'}">
                        <div class="timeline-item">
                            <div class="timeline-marker bg-warning">
                                <i class="fas fa-sync"></i>
                            </div>
                            <div class="timeline-content">
                                <strong>Prise en charge</strong>
                                <p class="text-muted small mb-0">La réclamation est en cours de traitement</p>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${reclamation.statut == 'RESOLUE'}">
                        <div class="timeline-item">
                            <div class="timeline-marker bg-success">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="timeline-content">
                                <strong>Réclamation résolue</strong>
                                <p class="text-muted small mb-0">Le problème a été résolu avec succès</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
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
    
    .priority-high { background: linear-gradient(135deg, #ef4444, #f87171); }
    .priority-medium { background: linear-gradient(135deg, #f59e0b, #fbbf24); }
    .priority-low { background: linear-gradient(135deg, #6b7280, #9ca3af); }
    
    .info-box {
        padding: 1rem;
        background: #f9fafb;
        border-radius: 0.75rem;
        border: 1px solid #e5e7eb;
    }
    
    .avatar-circle {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.25rem;
    }
    
    .timeline {
        position: relative;
        padding-left: 2rem;
    }
    
    .timeline::before {
        content: '';
        position: absolute;
        left: 20px;
        top: 0;
        bottom: 0;
        width: 2px;
        background: #e5e7eb;
    }
    
    .timeline-item {
        position: relative;
        padding-bottom: 2rem;
    }
    
    .timeline-item:last-child {
        padding-bottom: 0;
    }
    
    .timeline-marker {
        position: absolute;
        left: -2rem;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        z-index: 1;
    }
    
    .timeline-content {
        padding-left: 1rem;
    }
</style>

<script>
    document.getElementById('description').addEventListener('input', function(e) {
        document.getElementById('char-count').textContent = e.target.value.length;
    });
</script>

<jsp:include page="../shared/footer.jsp"/>
