<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouveau Service" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-plus-circle text-gradient me-2"></i> Ajouter un nouveau service</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/service?action=list">Services</a></li>
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
                <i class="fas fa-briefcase me-2"></i> Informations du service
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/service?action=add" method="post">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                    
                    <div class="mb-4">
                        <label for="nom" class="form-label-modern">
                            <i class="fas fa-tag me-1"></i> Nom du service *
                        </label>
                        <input type="text" class="form-control-modern" id="nom" name="nom" 
                               placeholder="Ex: Ménage complet, Entretien jardin..." required>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label for="categorie" class="form-label-modern">
                                <i class="fas fa-folder me-1"></i> Catégorie *
                            </label>
                            <select class="form-select-modern" id="categorie" name="categorie" required>
                                <option value="">Sélectionner une catégorie</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${fn:escapeXml(cat.nom)}</option>
                                </c:forEach>
                            </select>
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i> 
                                <a href="${pageContext.request.contextPath}/categorie?action=add">Créer une nouvelle catégorie</a>
                            </small>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <label for="prix" class="form-label-modern">
                                <i class="fas fa-euro-sign me-1"></i> Prix (€) *
                            </label>
                            <input type="number" class="form-control-modern" id="prix" name="prix" 
                                   placeholder="0.00" min="0" step="0.01" required>
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
                            <h5 class="preview-name mt-3 mb-2">Nom du service</h5>
                            <p class="text-muted small mb-2">
                                <i class="fas fa-tag me-1"></i> <span class="preview-category">Catégorie</span>
                            </p>
                            <div class="price-tag">
                                <span class="preview-price">0.00€</span>
                                <span class="text-muted small">/ intervention</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/service?action=list" 
                           class="btn btn-outline-custom">
                            <i class="fas fa-times me-2"></i> Annuler
                        </a>
                        <button type="reset" class="btn btn-outline-custom">
                            <i class="fas fa-redo me-2"></i> Réinitialiser
                        </button>
                        <button type="submit" class="btn btn-success-custom">
                            <i class="fas fa-save me-2"></i> Enregistrer
                        </button>
                    </div>
                </form>
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

<jsp:include page="../shared/footer.jsp"/>
