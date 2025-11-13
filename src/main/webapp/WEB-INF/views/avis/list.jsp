<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Avis" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-star text-gradient me-2"></i> Gestion des avis clients</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Avis</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/avis?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouvel avis
            </a>
        </div>
    </div>
</div>

<!-- Statistics Cards -->
<div class="row g-4 mb-4 fade-in">
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-warning">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-value">4.8</div>
            <div class="stat-label">Note moyenne</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-success">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-value">156</div>
            <div class="stat-label">Total avis</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-primary">
                <i class="fas fa-thumbs-up"></i>
            </div>
            <div class="stat-value">92%</div>
            <div class="stat-label">Satisfaction</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-info">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-value">+12%</div>
            <div class="stat-label">Ce mois</div>
        </div>
    </div>
</div>

<!-- Reviews List -->
<div class="row g-4 fade-in">
    <c:forEach var="avis" items="${avisList}">
        <div class="col-lg-6">
            <div class="card-modern review-card">
                <div class="card-body-custom">
                    <div class="review-header mb-3">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle bg-primary me-3">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0">${avis.client.nom} ${avis.client.prenom}</h6>
                                    <small class="text-muted">
                                        <i class="fas fa-calendar me-1"></i> Aujourd'hui
                                    </small>
                                </div>
                            </div>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-light" type="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/avis?action=edit&id=${avis.id}">
                                            <i class="fas fa-edit text-primary me-2"></i> Modifier
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item text-danger btn-delete-confirm" 
                                           href="${pageContext.request.contextPath}/avis?action=delete&id=${avis.id}">
                                            <i class="fas fa-trash me-2"></i> Supprimer
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <div class="review-rating mb-3">
                        <div class="stars-container">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star ${i <= avis.note ? 'text-warning' : 'text-muted'}"></i>
                            </c:forEach>
                            <span class="ms-2 fw-bold">${avis.note}/5</span>
                        </div>
                    </div>
                    
                    <div class="review-content mb-3">
                        <p class="mb-0">${avis.commentaire}</p>
                    </div>
                    
                    <div class="review-footer">
                        <small class="text-muted">
                            <i class="fas fa-user-tie me-1"></i>
                            Prestataire: <strong>${avis.prestataire.nom} ${avis.prestataire.prenom}</strong>
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    
    <c:if test="${empty avisList}">
        <div class="col-12">
            <div class="card-modern">
                <div class="card-body-custom text-center py-5">
                    <i class="fas fa-inbox fa-3x text-muted mb-3 d-block"></i>
                    <h5 class="text-muted mb-2">Aucun avis trouvé</h5>
                    <a href="${pageContext.request.contextPath}/avis?action=add" class="btn btn-primary-custom">
                        <i class="fas fa-plus me-2"></i> Ajouter un avis
                    </a>
                </div>
            </div>
        </div>
    </c:if>
</div>

<style>
    .review-card {
        transition: all 0.3s ease;
        height: 100%;
    }
    
    .review-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
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
    
    .stars-container {
        display: flex;
        align-items: center;
        font-size: 1.25rem;
    }
    
    .review-content {
        padding: 1rem;
        background: #f9fafb;
        border-radius: 0.5rem;
        border-left: 3px solid var(--primary-color);
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
