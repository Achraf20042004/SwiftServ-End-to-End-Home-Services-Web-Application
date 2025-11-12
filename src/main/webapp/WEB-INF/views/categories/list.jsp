<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Catégories" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-tags text-gradient me-2"></i> Gestion des catégories</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Catégories</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/categorie?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouvelle catégorie
            </a>
        </div>
    </div>
</div>

<!-- Categories Grid -->
<div class="row g-4 fade-in">
    <c:forEach var="categorie" items="${categories}" varStatus="status">
        <div class="col-lg-4 col-md-6">
            <div class="card-modern category-card">
                <div class="card-body-custom">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="category-icon bg-primary">
                            <i class="fas fa-folder"></i>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-light" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/categorie?action=edit&id=${categorie.id}">
                                        <i class="fas fa-edit text-primary me-2"></i> Modifier
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/service?categorieId=${categorie.id}">
                                        <i class="fas fa-briefcase text-info me-2"></i> Services
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger btn-delete-confirm" 
                                       href="${pageContext.request.contextPath}/categorie?action=delete&id=${categorie.id}">
                                        <i class="fas fa-trash me-2"></i> Supprimer
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <h5 class="mb-2">${categorie.nom}</h5>
                    <p class="text-muted small mb-3">
                        ${categorie.description != null ? categorie.description : 'Aucune description'}
                    </p>
                    
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge-custom badge-primary-custom">
                            <i class="fas fa-briefcase me-1"></i> 12 services
                        </span>
                        <a href="${pageContext.request.contextPath}/service?categorieId=${categorie.id}" 
                           class="btn btn-sm btn-outline-custom">
                            Voir les services <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    
    <c:if test="${empty categories}">
        <div class="col-12">
            <div class="card-modern">
                <div class="card-body-custom text-center py-5">
                    <i class="fas fa-inbox fa-3x text-muted mb-3 d-block"></i>
                    <h5 class="text-muted mb-2">Aucune catégorie trouvée</h5>
                    <p class="text-muted mb-4">Commencez par créer votre première catégorie de services</p>
                    <a href="${pageContext.request.contextPath}/categorie?action=add" class="btn btn-primary-custom">
                        <i class="fas fa-plus me-2"></i> Créer une catégorie
                    </a>
                </div>
            </div>
        </div>
    </c:if>
</div>

<style>
    .category-card {
        height: 100%;
        transition: all 0.3s ease;
    }
    
    .category-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    }
    
    .category-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
