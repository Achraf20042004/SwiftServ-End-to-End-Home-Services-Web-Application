<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Services" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-briefcase text-gradient me-2"></i> Gestion des services</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Services</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/service?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouveau service
            </a>
        </div>
    </div>
</div>

<!-- Search and Filter -->
<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-body-custom">
                <form class="row g-3" method="get">
                    <input type="hidden" name="action" value="list">
                    <div class="col-md-5">
                        <label class="form-label-modern">
                            <i class="fas fa-search me-1"></i> Rechercher
                        </label>
                        <input type="text" class="form-control-modern" name="search" 
                               placeholder="Nom du service..." value="${param.search}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label-modern">
                            <i class="fas fa-filter me-1"></i> Catégorie
                        </label>
                        <select class="form-select-modern" name="categorieId">
                            <option value="">Toutes les catégories</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary-custom w-100">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Services Grid -->
<div class="row g-4 fade-in">
    <c:forEach var="service" items="${services}">
        <div class="col-lg-4 col-md-6">
            <div class="card-modern service-card">
                <div class="card-body-custom">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="service-icon bg-info">
                            <i class="fas fa-concierge-bell"></i>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-light" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/service?action=edit&id=${service.id}">
                                        <i class="fas fa-edit text-primary me-2"></i> Modifier
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/reservation?serviceId=${service.id}">
                                        <i class="fas fa-calendar-check text-success me-2"></i> Réservations
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger btn-delete-confirm" 
                                       href="${pageContext.request.contextPath}/service?action=delete&id=${service.id}">
                                        <i class="fas fa-trash me-2"></i> Supprimer
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <h5 class="mb-2">${service.nom}</h5>
                    <p class="text-muted small mb-2">
                        <i class="fas fa-tag me-1"></i> ${service.categorie.nom}
                    </p>
                    
                    <div class="price-tag mb-3">
                        <span class="price">${service.prix}€</span>
                        <span class="text-muted small">/ intervention</span>
                    </div>
                    
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge-custom badge-success-custom">
                            <i class="fas fa-check-circle me-1"></i> Actif
                        </span>
                        <a href="${pageContext.request.contextPath}/service?action=edit&id=${service.id}" 
                           class="btn btn-sm btn-outline-custom">
                            Modifier <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    
    <c:if test="${empty services}">
        <div class="col-12">
            <div class="card-modern">
                <div class="card-body-custom text-center py-5">
                    <i class="fas fa-inbox fa-3x text-muted mb-3 d-block"></i>
                    <h5 class="text-muted mb-2">Aucun service trouvé</h5>
                    <p class="text-muted mb-4">Commencez par créer votre premier service</p>
                    <a href="${pageContext.request.contextPath}/service?action=add" class="btn btn-primary-custom">
                        <i class="fas fa-plus me-2"></i> Créer un service
                    </a>
                </div>
            </div>
        </div>
    </c:if>
</div>

<style>
    .service-card {
        height: 100%;
        transition: all 0.3s ease;
    }
    
    .service-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    }
    
    .service-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
    }
    
    .price-tag {
        padding: 1rem;
        background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
        border-radius: 0.5rem;
        text-align: center;
    }
    
    .price-tag .price {
        font-size: 1.75rem;
        font-weight: 700;
        color: var(--primary-color);
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
