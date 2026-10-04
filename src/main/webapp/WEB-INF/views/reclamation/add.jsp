<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouvelle Réclamation" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-file-alt text-gradient me-2"></i> Créer une nouvelle réclamation</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/reclamation?action=list">Réclamations</a></li>
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
                <i class="fas fa-exclamation-circle me-2"></i> Informations de la réclamation
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/reclamation?action=add" method="post">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                    
                    <!-- Client Section -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user me-2"></i> Client concerné
                        </h5>
                        <hr>
                        <label for="clientId" class="form-label-modern">
                            <i class="fas fa-user-circle me-1"></i> Sélectionner le client *
                        </label>
                        <c:choose>
                            <c:when test="${not empty clientConnecte}">
                                <%-- Un client dépose la réclamation en son nom (imposé par la servlet) --%>
                                <input type="text" class="form-control-modern" disabled
                                       value="${fn:escapeXml(clientConnecte.nom)} ${fn:escapeXml(clientConnecte.prenom)} - ${fn:escapeXml(clientConnecte.email)}">
                            </c:when>
                            <c:otherwise>
                                <select class="form-select-modern" id="clientId" name="clientId" required>
                                    <option value="">Choisir un client</option>
                                    <c:forEach var="client" items="${clients}">
                                        <option value="${client.id}">
                                            ${fn:escapeXml(client.nom)} ${fn:escapeXml(client.prenom)} - ${fn:escapeXml(client.email)}
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Intervention Section -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-tools me-2"></i> Intervention concernée (optionnel)
                        </h5>
                        <hr>
                        <label for="interventionId" class="form-label-modern">
                            <i class="fas fa-wrench me-1"></i> Sélectionner l'intervention
                        </label>
                        <select class="form-select-modern" id="interventionId" name="interventionId">
                            <option value="">Aucune intervention spécifique</option>
                            <c:forEach var="intervention" items="${interventions}">
                                <option value="${intervention.id}">
                                    #${intervention.id} - ${fn:escapeXml(intervention.reservation.service.nom)}
                                </option>
                            </c:forEach>
                        </select>
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i> Laissez vide si la réclamation n'est pas liée à une intervention
                        </small>
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
                                    <option value="">Sélectionner</option>
                                    <option value="BASSE">🟢 Basse</option>
                                    <option value="MOYENNE" selected>🟡 Moyenne</option>
                                    <option value="HAUTE">🔴 Haute</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="statut" class="form-label-modern">
                                    <i class="fas fa-traffic-light me-1"></i> Statut *
                                </label>
                                <select class="form-select-modern" id="statut" name="statut" required>
                                    <option value="EN_ATTENTE" selected>En attente</option>
                                    <option value="EN_COURS">En cours</option>
                                    <option value="RESOLUE">Résolue</option>
                                    <option value="FERMEE">Fermée</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="objet" class="form-label-modern">
                                <i class="fas fa-heading me-1"></i> Objet de la réclamation *
                            </label>
                            <input type="text" class="form-control-modern" id="objet" name="objet" 
                                   placeholder="Ex: Retard du prestataire, Service non conforme..." 
                                   maxlength="200" required>
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i> Résumez le problème en quelques mots
                            </small>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label-modern">
                                <i class="fas fa-align-left me-1"></i> Description détaillée *
                            </label>
                            <textarea class="form-control-modern" id="description" name="description" 
                                      rows="6" placeholder="Décrivez en détail le problème rencontré..." 
                                      maxlength="1000" required></textarea>
                            <div class="d-flex justify-content-between">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i> Soyez précis pour faciliter le traitement
                                </small>
                                <small class="text-muted">
                                    <span id="char-count">0</span>/1000 caractères
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Preview -->
                    <div class="alert alert-info-modern">
                        <h6 class="mb-3"><i class="fas fa-eye me-2"></i> Aperçu de la réclamation</h6>
                        <div class="preview-reclamation">
                            <div class="d-flex gap-3 mb-3">
                                <div class="priority-preview">
                                    <span class="priority-badge priority-medium">
                                        <i class="fas fa-minus-circle"></i>
                                    </span>
                                </div>
                                <div class="flex-grow-1">
                                    <span class="reclamation-id">#NEW</span>
                                    <h6 class="mt-2 mb-1" id="preview-objet">Objet de la réclamation</h6>
                                    <p class="text-muted small mb-2" id="preview-description">Description détaillée...</p>
                                    <div>
                                        <span class="badge-custom badge-warning-custom">
                                            <i class="fas fa-clock me-1"></i> En attente
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/reclamation?action=list" 
                           class="btn btn-outline-custom">
                            <i class="fas fa-times me-2"></i> Annuler
                        </a>
                        <button type="reset" class="btn btn-outline-custom">
                            <i class="fas fa-redo me-2"></i> Réinitialiser
                        </button>
                        <button type="submit" class="btn btn-danger-custom">
                            <i class="fas fa-save me-2"></i> Enregistrer la réclamation
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Help Section -->
        <div class="card-modern mt-4">
            <div class="card-header-custom">
                <i class="fas fa-question-circle me-2"></i> Conseils
            </div>
            <div class="card-body-custom">
                <ul class="mb-0 text-muted small">
                    <li class="mb-2">Décrivez précisément le problème rencontré</li>
                    <li class="mb-2">Indiquez la date et l'heure si pertinent</li>
                    <li class="mb-2">Mentionnez toute communication antérieure</li>
                    <li>Utilisez un ton professionnel et factuel</li>
                </ul>
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
    
    .priority-high {
        background: linear-gradient(135deg, #ef4444, #f87171);
    }
    
    .priority-medium {
        background: linear-gradient(135deg, #f59e0b, #fbbf24);
    }
    
    .priority-low {
        background: linear-gradient(135deg, #6b7280, #9ca3af);
    }
    
    .preview-reclamation {
        padding: 1.5rem;
        background: white;
        border-radius: 0.75rem;
        border: 2px dashed #e5e7eb;
    }
    
    .reclamation-id {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
        color: white;
        padding: 0.25rem 0.75rem;
        border-radius: 0.375rem;
        font-weight: 700;
        font-size: 0.75rem;
    }
</style>

<script>
    // Character counter
    document.getElementById('description').addEventListener('input', function(e) {
        const count = e.target.value.length;
        document.getElementById('char-count').textContent = count;
        document.getElementById('preview-description').textContent = e.target.value || 'Description détaillée...';
    });
    
    // Preview objet
    document.getElementById('objet').addEventListener('input', function(e) {
        document.getElementById('preview-objet').textContent = e.target.value || 'Objet de la réclamation';
    });
    
    // Priority preview
    document.getElementById('priorite').addEventListener('change', function(e) {
        const priorityBadge = document.querySelector('.priority-preview .priority-badge');
        priorityBadge.className = 'priority-badge';
        
        switch(e.target.value) {
            case 'HAUTE':
                priorityBadge.classList.add('priority-high');
                priorityBadge.innerHTML = '<i class="fas fa-exclamation-circle"></i>';
                break;
            case 'MOYENNE':
                priorityBadge.classList.add('priority-medium');
                priorityBadge.innerHTML = '<i class="fas fa-minus-circle"></i>';
                break;
            case 'BASSE':
                priorityBadge.classList.add('priority-low');
                priorityBadge.innerHTML = '<i class="fas fa-arrow-down"></i>';
                break;
        }
    });
</script>

<jsp:include page="../shared/footer.jsp"/>
