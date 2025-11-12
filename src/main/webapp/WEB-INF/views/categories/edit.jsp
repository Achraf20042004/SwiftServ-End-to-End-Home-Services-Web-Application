<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Catégorie" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier la catégorie</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/categorie?action=list">Catégories</a></li>
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
                <i class="fas fa-folder-open me-2"></i> Modifier les informations
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/categorie?action=edit" method="post">
                    <input type="hidden" name="id" value="${categorie.id}">
                    
                    <!-- Category Info -->
                    <div class="alert alert-info-modern mb-4">
                        <strong><i class="fas fa-info-circle me-2"></i> Catégorie #${categorie.id}</strong>
                        <p class="mb-0 small text-muted mt-1">
                            Cette catégorie contient actuellement 12 services associés
                        </p>
                    </div>
                    
                    <div class="mb-4">
                        <label for="nom" class="form-label-modern">
                            <i class="fas fa-tag me-1"></i> Nom de la catégorie *
                        </label>
                        <input type="text" class="form-control-modern" id="nom" name="nom" 
                               value="${categorie.nom}" required>
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i> Le nom doit être unique et descriptif
                        </small>
                    </div>
                    
                    <div class="mb-4">
                        <label for="description" class="form-label-modern">
                            <i class="fas fa-align-left me-1"></i> Description
                        </label>
                        <textarea class="form-control-modern" id="description" name="description" 
                                  rows="4">${categorie.description}</textarea>
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i> Cette description sera visible par les clients
                        </small>
                    </div>
                    
                    <!-- Preview Section -->
                    <div class="alert alert-info-modern mb-4">
                        <h6 class="mb-2"><i class="fas fa-eye me-2"></i> Aperçu</h6>
                        <div class="preview-category-card">
                            <div class="category-icon bg-primary">
                                <i class="fas fa-folder"></i>
                            </div>
                            <h5 class="preview-name mt-3 mb-2">${categorie.nom}</h5>
                            <p class="text-muted small preview-description">${categorie.description}</p>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-between">
                        <a href="${pageContext.request.contextPath}/categorie?action=delete&id=${categorie.id}" 
                           class="btn btn-danger-custom btn-delete-confirm">
                            <i class="fas fa-trash me-2"></i> Supprimer cette catégorie
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/categorie?action=list" 
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
        
        <!-- Associated Services -->
        <div class="card-modern mt-4">
            <div class="card-header-custom d-flex justify-content-between align-items-center">
                <span><i class="fas fa-briefcase me-2"></i> Services associés</span>
                <a href="${pageContext.request.contextPath}/service?action=add&categorieId=${categorie.id}" 
                   class="btn btn-sm btn-light">
                    <i class="fas fa-plus me-1"></i> Ajouter un service
                </a>
            </div>
            <div class="card-body-custom">
                <div class="list-group list-group-flush">
                    <div class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <strong>Ménage complet</strong>
                            <p class="mb-0 small text-muted">À partir de 25€</p>
                        </div>
                        <span class="badge-custom badge-success-custom">Actif</span>
                    </div>
                    <div class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <strong>Ménage express</strong>
                            <p class="mb-0 small text-muted">À partir de 15€</p>
                        </div>
                        <span class="badge-custom badge-success-custom">Actif</span>
                    </div>
                    <div class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <strong>Nettoyage vitres</strong>
                            <p class="mb-0 small text-muted">À partir de 30€</p>
                        </div>
                        <span class="badge-custom badge-success-custom">Actif</span>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/service?categorieId=${categorie.id}" 
                       class="btn btn-sm btn-outline-custom">
                        Voir tous les services <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .preview-category-card {
        padding: 2rem;
        background: white;
        border-radius: 0.75rem;
        text-align: center;
        border: 2px dashed #e5e7eb;
    }
    
    .category-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
    }
</style>

<script>
    // Live preview
    document.getElementById('nom').addEventListener('input', function(e) {
        document.querySelector('.preview-name').textContent = e.target.value || 'Nom de la catégorie';
    });
    
    document.getElementById('description').addEventListener('input', function(e) {
        document.querySelector('.preview-description').textContent = e.target.value || 'Description de la catégorie';
    });
</script>

<jsp:include page="../includes/footer.jsp"/>
