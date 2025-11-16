<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouvel Avis" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-star-half-alt text-gradient me-2"></i> Ajouter un nouvel avis</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/avis?action=list">Avis</a></li>
                    <li class="breadcrumb-item active">Nouveau</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-comment-dots me-2"></i> Informations de l'avis
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/avis?action=add" method="post">
                    
                    <!-- Client Selection -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user me-2"></i> Client
                        </h5>
                        <hr>
                        <label for="clientId" class="form-label-modern">
                            <i class="fas fa-user-circle me-1"></i> Sélectionner le client *
                        </label>
                        <select class="form-select-modern" id="clientId" name="clientId" required>
                            <option value="">Choisir un client</option>
                            <c:forEach var="client" items="${clients}">
                                <option value="${client.id}">
                                    ${client.nom} ${client.prenom} - ${client.email}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Prestataire Selection -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user-tie me-2"></i> Prestataire évalué
                        </h5>
                        <hr>
                        <label for="prestataireId" class="form-label-modern">
                            <i class="fas fa-user-check me-1"></i> Sélectionner le prestataire *
                        </label>
                        <select class="form-select-modern" id="prestataireId" name="prestataireId" required>
                            <option value="">Choisir un prestataire</option>
                            <c:forEach var="prestataire" items="${prestataires}">
                                <option value="${prestataire.id}">
                                    ${prestataire.nom} ${prestataire.prenom} - ${prestataire.specialite}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Rating Section -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-star me-2"></i> Évaluation
                        </h5>
                        <hr>
                        <label class="form-label-modern">
                            <i class="fas fa-star-half-alt me-1"></i> Note du service *
                        </label>
                        <div class="rating-selector mb-3">
                            <input type="radio" id="star5" name="note" value="5" required>
                            <label for="star5" title="5 étoiles"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star4" name="note" value="4">
                            <label for="star4" title="4 étoiles"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star3" name="note" value="3">
                            <label for="star3" title="3 étoiles"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star2" name="note" value="2">
                            <label for="star2" title="2 étoiles"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star1" name="note" value="1">
                            <label for="star1" title="1 étoile"><i class="fas fa-star"></i></label>
                        </div>
                        <div id="rating-display" class="rating-display">
                            <span class="rating-text">Sélectionnez une note</span>
                        </div>
                    </div>
                    
                    <!-- Comment Section -->
                    <div class="mb-4">
                        <label for="commentaire" class="form-label-modern">
                            <i class="fas fa-comment me-1"></i> Commentaire *
                        </label>
                        <textarea class="form-control-modern" id="commentaire" name="commentaire" 
                                  rows="5" placeholder="Partagez votre expérience avec ce prestataire..." 
                                  maxlength="500" required></textarea>
                        <div class="d-flex justify-content-between">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i> Minimum 20 caractères
                            </small>
                            <small class="text-muted">
                                <span id="char-count">0</span>/500 caractères
                            </small>
                        </div>
                    </div>
                    
                    <!-- Preview -->
                    <div class="alert alert-info-modern">
                        <h6 class="mb-3"><i class="fas fa-eye me-2"></i> Aperçu de l'avis</h6>
                        <div class="preview-review-card">
                            <div class="d-flex align-items-center mb-3">
                                <div class="avatar-circle bg-primary me-3">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0" id="preview-client">Client</h6>
                                    <small class="text-muted">Aujourd'hui</small>
                                </div>
                            </div>
                            <div class="preview-stars mb-2">
                                <i class="fas fa-star text-muted"></i>
                                <i class="fas fa-star text-muted"></i>
                                <i class="fas fa-star text-muted"></i>
                                <i class="fas fa-star text-muted"></i>
                                <i class="fas fa-star text-muted"></i>
                            </div>
                            <p class="preview-comment text-muted mb-2">Votre commentaire apparaîtra ici...</p>
                            <small class="text-muted">
                                <i class="fas fa-user-tie me-1"></i>
                                Prestataire: <span id="preview-prestataire">Prestataire</span>
                            </small>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/avis?action=list" 
                           class="btn btn-outline-custom">
                            <i class="fas fa-times me-2"></i> Annuler
                        </a>
                        <button type="reset" class="btn btn-outline-custom">
                            <i class="fas fa-redo me-2"></i> Réinitialiser
                        </button>
                        <button type="submit" class="btn btn-success-custom">
                            <i class="fas fa-save me-2"></i> Publier l'avis
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .rating-selector {
        display: flex;
        flex-direction: row-reverse;
        justify-content: flex-end;
        gap: 0.5rem;
    }
    
    .rating-selector input {
        display: none;
    }
    
    .rating-selector label {
        cursor: pointer;
        font-size: 2.5rem;
        color: #d1d5db;
        transition: all 0.2s ease;
    }
    
    .rating-selector label:hover,
    .rating-selector label:hover ~ label,
    .rating-selector input:checked ~ label {
        color: #f59e0b;
        transform: scale(1.1);
    }
    
    .rating-display {
        padding: 1rem;
        background: #f9fafb;
        border-radius: 0.5rem;
        text-align: center;
    }
    
    .rating-text {
        font-size: 1.125rem;
        font-weight: 600;
        color: var(--text-secondary);
    }
    
    .preview-review-card {
        padding: 1.5rem;
        background: white;
        border-radius: 0.75rem;
        border: 2px dashed #e5e7eb;
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
    
    .preview-stars i {
        font-size: 1.25rem;
        margin-right: 2px;
    }
    
    .preview-comment {
        padding: 1rem;
        background: #f9fafb;
        border-radius: 0.5rem;
        min-height: 80px;
    }
</style>

<script>
    // Character counter
    document.getElementById('commentaire').addEventListener('input', function(e) {
        const count = e.target.value.length;
        document.getElementById('char-count').textContent = count;
        document.querySelector('.preview-comment').textContent = e.target.value || 'Votre commentaire apparaîtra ici...';
    });
    
    // Rating selector
    document.querySelectorAll('.rating-selector input').forEach(function(input) {
        input.addEventListener('change', function() {
            const rating = this.value;
            const ratingText = ['Très mauvais', 'Mauvais', 'Moyen', 'Bon', 'Excellent'][rating - 1];
            document.querySelector('.rating-text').textContent = `${rating}/5 - ${ratingText}`;
            
            // Update preview stars
            const stars = document.querySelectorAll('.preview-stars i');
            stars.forEach((star, index) => {
                star.className = index < rating ? 'fas fa-star text-warning' : 'fas fa-star text-muted';
            });
        });
    });
    
    // Client selection preview
    document.getElementById('clientId').addEventListener('change', function(e) {
        const text = e.target.options[e.target.selectedIndex].text;
        document.getElementById('preview-client').textContent = text.split(' - ')[0] || 'Client';
    });
    
    // Prestataire selection preview
    document.getElementById('prestataireId').addEventListener('change', function(e) {
        const text = e.target.options[e.target.selectedIndex].text;
        document.getElementById('preview-prestataire').textContent = text.split(' - ')[0] || 'Prestataire';
    });
</script>

<jsp:include page="../shared/footer.jsp"/>
