<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Avis" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier l'avis</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/avis?action=list">Avis</a></li>
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
                <i class="fas fa-comment-edit me-2"></i> Modifier l'avis
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/avis?action=edit" method="post">
                    <input type="hidden" name="id" value="${avis.id}">
                    
                    <!-- Avis Info -->
                    <div class="alert alert-info-modern mb-4">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <strong><i class="fas fa-info-circle me-2"></i> Avis #${avis.id}</strong>
                                <p class="mb-0 small text-muted mt-1">
                                    Publié le: <c:out value="${avis.datePublication}" default="Aujourd'hui"/>
                                </p>
                            </div>
                            <div class="current-rating">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fas fa-star ${i <= avis.note ? 'text-warning' : 'text-muted'}"></i>
                                </c:forEach>
                            </div>
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
                                    <strong>${avis.client.nom} ${avis.client.prenom}</strong>
                                    <br><small class="text-muted">${avis.client.email}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Prestataire (Read-only) -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user-tie me-2"></i> Prestataire évalué
                        </h5>
                        <hr>
                        <div class="info-box">
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle bg-success me-3">
                                    <i class="fas fa-user-tie"></i>
                                </div>
                                <div>
                                    <strong>${avis.prestataire.nom} ${avis.prestataire.prenom}</strong>
                                    <br><small class="text-muted">${avis.prestataire.specialite}</small>
                                </div>
                            </div>
                        </div>
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
                            <input type="radio" id="star5" name="note" value="5" ${avis.note == 5 ? 'checked' : ''} required>
                            <label for="star5" title="5 étoiles"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star4" name="note" value="4" ${avis.note == 4 ? 'checked' : ''}>
                            <label for="star4" title="4 étoiles"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star3" name="note" value="3" ${avis.note == 3 ? 'checked' : ''}>
                            <label for="star3" title="3 étoiles"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star2" name="note" value="2" ${avis.note == 2 ? 'checked' : ''}>
                            <label for="star2" title="2 étoiles"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star1" name="note" value="1" ${avis.note == 1 ? 'checked' : ''}>
                            <label for="star1" title="1 étoile"><i class="fas fa-star"></i></label>
                        </div>
                        <div id="rating-display" class="rating-display">
                            <span class="rating-text">${avis.note}/5</span>
                        </div>
                    </div>
                    
                    <!-- Comment Section -->
                    <div class="mb-4">
                        <label for="commentaire" class="form-label-modern">
                            <i class="fas fa-comment me-1"></i> Commentaire *
                        </label>
                        <textarea class="form-control-modern" id="commentaire" name="commentaire" 
                                  rows="5" maxlength="500" required>${avis.commentaire}</textarea>
                        <div class="d-flex justify-content-between">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i> Minimum 20 caractères
                            </small>
                            <small class="text-muted">
                                <span id="char-count">${avis.commentaire.length()}</span>/500 caractères
                            </small>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-between">
                        <a href="${pageContext.request.contextPath}/avis?action=delete&id=${avis.id}" 
                           class="btn btn-danger-custom btn-delete-confirm">
                            <i class="fas fa-trash me-2"></i> Supprimer cet avis
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/avis?action=list" 
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
        
        <!-- Impact Info -->
        <div class="card-modern mt-4">
            <div class="card-header-custom">
                <i class="fas fa-chart-line me-2"></i> Impact de l'avis
            </div>
            <div class="card-body-custom">
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="impact-stat">
                            <div class="impact-icon bg-warning">
                                <i class="fas fa-eye"></i>
                            </div>
                            <div>
                                <h5 class="mb-0">124</h5>
                                <small class="text-muted">Vues</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="impact-stat">
                            <div class="impact-icon bg-success">
                                <i class="fas fa-thumbs-up"></i>
                            </div>
                            <div>
                                <h5 class="mb-0">18</h5>
                                <small class="text-muted">Utile</small>
                            </div>
                        </div>
                    </div>
                </div>
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
    
    .impact-stat {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 1rem;
        background: #f9fafb;
        border-radius: 0.5rem;
    }
    
    .impact-icon {
        width: 50px;
        height: 50px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.25rem;
    }
</style>

<script>
    // Character counter
    document.getElementById('commentaire').addEventListener('input', function(e) {
        document.getElementById('char-count').textContent = e.target.value.length;
    });
    
    // Rating selector
    document.querySelectorAll('.rating-selector input').forEach(function(input) {
        input.addEventListener('change', function() {
            const rating = this.value;
            const ratingText = ['Très mauvais', 'Mauvais', 'Moyen', 'Bon', 'Excellent'][rating - 1];
            document.querySelector('.rating-text').textContent = `${rating}/5 - ${ratingText}`;
        });
    });
    
    // Initialize rating display
    const currentRating = document.querySelector('.rating-selector input:checked');
    if (currentRating) {
        const rating = currentRating.value;
        const ratingText = ['Très mauvais', 'Mauvais', 'Moyen', 'Bon', 'Excellent'][rating - 1];
        document.querySelector('.rating-text').textContent = `${rating}/5 - ${ratingText}`;
    }
</script>

<jsp:include page="../shared/footer.jsp"/>
