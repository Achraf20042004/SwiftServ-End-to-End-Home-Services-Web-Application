<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouvelle Catégorie" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-plus-circle text-gradient me-2"></i> Ajouter une nouvelle catégorie</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/categorie?action=list">Catégories</a></li>
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
                <i class="fas fa-folder-plus me-2"></i> Informations de la catégorie
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/categorie?action=add" method="post">
                    
                    <div class="mb-4">
                        <label for="nom" class="form-label-modern">
                            <i class="fas fa-tag me-1"></i> Nom de la catégorie *
                        </label>
                        <input type="text" class="form-control-modern" id="nom" name="nom" 
                               placeholder="Ex: Ménage, Jardinage, Bricolage..." required>
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i> Le nom doit être unique et descriptif
                        </small>
                    </div>
                    
                    <div class="mb-4">
                        <label for="description" class="form-label-modern">
                            <i class="fas fa-align-left me-1"></i> Description
                        </label>
                        <textarea class="form-control-modern" id="description" name="description" 
                                  rows="4" placeholder="Décrivez brièvement cette catégorie de services..."></textarea>
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
                            <h5 class="preview-name mt-3 mb-2">Nom de la catégorie</h5>
                            <p class="text-muted small preview-description">Description de la catégorie</p>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/categorie?action=list" 
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
        
        <!-- Popular Categories -->
        <div class="card-modern mt-4">
            <div class="card-body-custom">
                <h6 class="text-primary mb-3">
                    <i class="fas fa-lightbulb me-2"></i> Catégories populaires
                </h6>
                <div class="row g-2">
                    <div class="col-md-4">
                        <button type="button" class="btn btn-outline-custom btn-sm w-100 quick-fill" data-name="Ménage" data-desc="Services de nettoyage et d'entretien du domicile">
                            <i class="fas fa-broom me-1"></i> Ménage
                        </button>
                    </div>
                    <div class="col-md-4">
                        <button type="button" class="btn btn-outline-custom btn-sm w-100 quick-fill" data-name="Jardinage" data-desc="Entretien des espaces verts et jardins">
                            <i class="fas fa-seedling me-1"></i> Jardinage
                        </button>
                    </div>
                    <div class="col-md-4">
                        <button type="button" class="btn btn-outline-custom btn-sm w-100 quick-fill" data-name="Bricolage" data-desc="Petits travaux et réparations">
                            <i class="fas fa-tools me-1"></i> Bricolage
                        </button>
                    </div>
                    <div class="col-md-4">
                        <button type="button" class="btn btn-outline-custom btn-sm w-100 quick-fill" data-name="Plomberie" data-desc="Installation et réparation de plomberie">
                            <i class="fas fa-wrench me-1"></i> Plomberie
                        </button>
                    </div>
                    <div class="col-md-4">
                        <button type="button" class="btn btn-outline-custom btn-sm w-100 quick-fill" data-name="Électricité" data-desc="Travaux électriques et installations">
                            <i class="fas fa-bolt me-1"></i> Électricité
                        </button>
                    </div>
                    <div class="col-md-4">
                        <button type="button" class="btn btn-outline-custom btn-sm w-100 quick-fill" data-name="Peinture" data-desc="Travaux de peinture intérieure et extérieure">
                            <i class="fas fa-paint-roller me-1"></i> Peinture
                        </button>
                    </div>
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
    
    .preview-name {
        color: #6b7280;
    }
    
    .preview-description {
        color: #9ca3af;
    }
</style>

<script>
    // Live preview
    document.getElementById('nom').addEventListener('input', function(e) {
        const previewName = document.querySelector('.preview-name');
        previewName.textContent = e.target.value || 'Nom de la catégorie';
        previewName.style.color = e.target.value ? '#111827' : '#6b7280';
    });
    
    document.getElementById('description').addEventListener('input', function(e) {
        const previewDesc = document.querySelector('.preview-description');
        previewDesc.textContent = e.target.value || 'Description de la catégorie';
        previewDesc.style.color = e.target.value ? '#6b7280' : '#9ca3af';
    });
    
    // Quick fill buttons
    document.querySelectorAll('.quick-fill').forEach(function(btn) {
        btn.addEventListener('click', function() {
            document.getElementById('nom').value = this.dataset.name;
            document.getElementById('description').value = this.dataset.desc;
            
            // Trigger preview update
            document.getElementById('nom').dispatchEvent(new Event('input'));
            document.getElementById('description').dispatchEvent(new Event('input'));
        });
    });
</script>

<jsp:include page="../includes/footer.jsp"/>
