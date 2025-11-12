<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Service" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier le service</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/service?action=list">Services</a></li>
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
                <i class="fas fa-briefcase me-2"></i> Modifier les informations
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/service?action=edit" method="post">
                    <input type="hidden" name="id" value="${service.id}">
                    
                    <div class="alert alert-info-modern mb-4">
                        <strong><i class="fas fa-info-circle me-2"></i> Service #${service.id}</strong>
                        <p class="mb-0 small text-muted mt-1">
                            45 réservations réalisées avec ce service
                        </p>
                    </div>
                    
                    <div class="mb-4">
                        <label for="nom" class="form-label-modern">
                            <i class="fas fa-tag me-1"></i> Nom du service *
                        </label>
                        <input type="text" class="form-control-modern" id="nom" name="nom" 
                               value="${service.nom}" required>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label for="categorie" class="form-label-modern">
                                <i class="fas fa-folder me-1"></i> Catégorie *
                            </label>
                            <select class="form-select-modern" id="categorie" name="categorie" required>
                                <option value="">Sélectionner une catégorie</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${service.categorie.id == cat.id ? 'selected' : ''}>
                                        ${cat.nom}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <label for="prix" class="form-label-modern">
                                <i class="fas fa-euro-sign me-1"></i> Prix (€) *
                            </label>
                            <input type="number" class="form-control-modern" id="prix" name="prix" 
                                   value="${service.prix}" min="0" step="0.01" required>
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i> Prix par intervention
                            </small>
                        </div>
                    </div>
                    
                    <!-- Preview Card -->
                    <div class="alert alert-info-modern mb-4">
                        <h6 class="mb-3"><i class="fas fa-eye me-2"></i> Aperçu</h6>
                        <div class="preview-service-card">
                            <div class="service-icon bg-info">
                                <i class="fas fa-concierge-bell"></i>
                            </div>
                            <h5 class="preview-name mt-3 mb-2">${service.nom}</h5>
                            <p class="text-muted small mb-2">
                                <i class="fas fa-tag me-1"></i> <span class="preview-category">${service.categorie.nom}</span>
                            </p>
                            <div class="price-tag">
                                <span class="preview-price">${service.prix}€</span>
                                <span class="text-muted small">/ intervention</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-between">
                        <a href="${pageContext.request.contextPath}/service?action=delete&id=${service.id}" 
                           class="btn btn-danger-custom btn-delete-confirm">
                            <i class="fas fa-trash me-2"></i> Supprimer ce service
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/service?action=list" 
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
        
        <!-- Statistics -->
        <div class="card-modern mt-4">
            <div class="card-header-custom">
                <i class="fas fa-chart-line me-2"></i> Statistiques du service
            </div>
            <div class="card-body-custom">
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="info-box text-center">
                            <i class="fas fa-calendar-check fa-2x text-primary mb-2"></i>
                            <h5 class="mb-1">45</h5>
                            <p class="text-muted small mb-0">Réservations</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info-box text-center">
                            <i class="fas fa-euro-sign fa-2x text-success mb-2"></i>
                            <h5 class="mb-1">1,125€</h5>
                            <p class="text-muted small mb-0">Revenus générés</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info-box text-center">
                            <i class="fas fa-star fa-2x text-warning mb-2"></i>
                            <h5 class="mb-1">4.7</h5>
                            <p class="text-muted small mb-0">Note moyenne</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .preview-service-card {
        padding: 2rem;
        background: white;
        border-radius: 0.75rem;
        text-align: center;
        border: 2px dashed #e5e7eb;
    }
    
    .service-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
    }
    
    .price-tag {
        padding: 1rem;
        background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
        border-radius: 0.5rem;
        display: inline-block;
        min-width: 150px;
    }
    
    .preview-price {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-color);
    }
    
    .info-box {
        padding: 1.5rem;
        background: #f9fafb;
        border-radius: 0.5rem;
        transition: all 0.3s ease;
    }
    
    .info-box:hover {
        background: #f3f4f6;
        transform: translateY(-2px);
    }
</style>

<script>
    // Live preview
    document.getElementById('nom').addEventListener('input', function(e) {
        document.querySelector('.preview-name').textContent = e.target.value || 'Nom du service';
    });
    
    document.getElementById('categorie').addEventListener('change', function(e) {
        const selectedOption = e.target.options[e.target.selectedIndex];
        document.querySelector('.preview-category').textContent = selectedOption.text || 'Catégorie';
    });
    
    document.getElementById('prix').addEventListener('input', function(e) {
        const prix = e.target.value || '0.00';
        document.querySelector('.preview-price').textContent = parseFloat(prix).toFixed(2) + '€';
    });
</script>

<jsp:include page="../includes/footer.jsp"/>
