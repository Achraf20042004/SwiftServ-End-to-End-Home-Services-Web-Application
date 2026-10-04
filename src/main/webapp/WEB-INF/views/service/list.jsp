<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Services" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid px-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="service-header">
                <div class="service-header-content">
                    <div class="service-header-text">
                        <h1>
                            <i class="fas fa-concierge-bell"></i>
                            Gestion des Services
                        </h1>
                        <p>Gérez et organisez tous vos services disponibles</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/service?action=add" class="btn-add-service">
                        <i class="fas fa-plus"></i>
                        <span>Nouveau service</span>
                    </a>
                </div>
                <div class="service-header-decoration">
                    <div class="floating-icon icon-1"><i class="fas fa-tools"></i></div>
                    <div class="floating-icon icon-2"><i class="fas fa-wrench"></i></div>
                    <div class="floating-icon icon-3"><i class="fas fa-broom"></i></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search and Filter -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="search-filter-card">
                <form class="search-filter-form" method="get">
                    <input type="hidden" name="action" value="list">
                    <div class="search-input-group">
                        <i class="fas fa-search"></i>
                        <input type="text" name="search" placeholder="Rechercher un service..." value="${param.search}">
                    </div>
                    <div class="filter-select-group">
                        <i class="fas fa-filter"></i>
                        <select name="categorieId">
                            <option value="">Toutes les catégories</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}" ${param.categorieId == cat.id ? 'selected' : ''}>${fn:escapeXml(cat.nom)}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn-search">
                        <i class="fas fa-search me-2"></i>Rechercher
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Section Title -->
    <div class="row mb-3">
        <div class="col-12">
            <div class="section-header">
                <h3><i class="fas fa-th-large me-2"></i>Tous les services</h3>
                <span class="results-count">${services.size()} résultat(s)</span>
            </div>
        </div>
    </div>

    <!-- Services Grid -->
    <div class="row g-4">
        <c:forEach var="service" items="${services}" varStatus="status">
            <div class="col-lg-4 col-md-6">
                <div class="service-card" style="animation-delay: ${status.index * 0.1}s">
                    <div class="service-card-header">
                        <div class="service-icon-wrapper">
                            <div class="service-icon">
                                <i class="fas fa-concierge-bell"></i>
                            </div>
                            <span class="service-status active">Actif</span>
                        </div>
                        <div class="dropdown">
                            <button class="btn-menu" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/service?action=edit&id=${service.id}">
                                        <i class="fas fa-edit"></i> Modifier
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/reservation?serviceId=${service.id}">
                                        <i class="fas fa-calendar-check"></i> Réservations
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger btn-delete-confirm" 
                                       href="${pageContext.request.contextPath}/service?action=delete&id=${service.id}">
                                        <i class="fas fa-trash"></i> Supprimer
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="service-card-body">
                        <h4 class="service-name">${fn:escapeXml(service.nom)}</h4>
                        <div class="service-category">
                            <i class="fas fa-tag"></i>
                            <span>${fn:escapeXml(service.categorie.nom)}</span>
                        </div>
                    </div>
                    
                    <div class="service-card-price">
                        <div class="price-amount">
                            <span class="currency">€</span>
                            <span class="value">${service.prix}</span>
                        </div>
                        <span class="price-label">par intervention</span>
                    </div>
                    
                    <div class="service-card-footer">
                        <a href="${pageContext.request.contextPath}/reservation?action=add&serviceId=${service.id}" class="btn-reserve">
                            <i class="fas fa-calendar-plus me-2"></i>Réserver
                        </a>
                        <a href="${pageContext.request.contextPath}/service?action=edit&id=${service.id}" class="btn-edit">
                            <i class="fas fa-edit"></i>
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty services}">
            <div class="col-12">
                <div class="empty-services">
                    <div class="empty-icon">
                        <i class="fas fa-concierge-bell"></i>
                    </div>
                    <h4>Aucun service trouvé</h4>
                    <p>Commencez par créer votre premier service pour le proposer à vos clients</p>
                    <a href="${pageContext.request.contextPath}/service?action=add" class="btn-add-first">
                        <i class="fas fa-plus me-2"></i>Créer un service
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<style>
    /* Header - Couleur violet/indigo */
    .service-header {
        background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
        border-radius: 1.5rem;
        padding: 2.5rem;
        position: relative;
        overflow: hidden;
        color: white;
    }
    
    .service-header-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: relative;
        z-index: 2;
    }
    
    .service-header-text h1 {
        font-size: 2rem;
        font-weight: 800;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    
    .service-header-text p {
        opacity: 0.9;
        margin: 0;
        font-size: 1rem;
    }
    
    .btn-add-service {
        background: rgba(255, 255, 255, 0.2);
        backdrop-filter: blur(10px);
        border: 2px solid rgba(255, 255, 255, 0.3);
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 0.75rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    
    .btn-add-service:hover {
        background: white;
        color: #4f46e5;
        transform: translateY(-2px);
    }
    
    .service-header-decoration {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        width: 40%;
    }
    
    .floating-icon {
        position: absolute;
        color: rgba(255, 255, 255, 0.15);
        animation: float 3s ease-in-out infinite;
    }
    
    .icon-1 { top: 20%; right: 15%; font-size: 2.5rem; }
    .icon-2 { top: 55%; right: 25%; font-size: 2rem; animation-delay: 0.5s; }
    .icon-3 { top: 35%; right: 8%; font-size: 1.5rem; animation-delay: 1s; }
    
    @keyframes float {
        0%, 100% { transform: translateY(0) rotate(0deg); }
        50% { transform: translateY(-10px) rotate(5deg); }
    }
    
    /* Search Filter */
    .search-filter-card {
        background: white;
        border-radius: 1rem;
        padding: 1.25rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    }
    
    .search-filter-form {
        display: flex;
        gap: 1rem;
        align-items: center;
    }
    
    .search-input-group {
        flex: 1;
        position: relative;
    }
    
    .search-input-group i {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: #9ca3af;
    }
    
    .search-input-group input {
        width: 100%;
        padding: 0.75rem 1rem 0.75rem 2.75rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.75rem;
        font-size: 0.9rem;
        transition: all 0.3s ease;
    }
    
    .search-input-group input:focus {
        outline: none;
        border-color: #4f46e5;
        box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
    }
    
    .filter-select-group {
        position: relative;
        min-width: 200px;
    }
    
    .filter-select-group i {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: #9ca3af;
        pointer-events: none;
    }
    
    .filter-select-group select {
        width: 100%;
        padding: 0.75rem 1rem 0.75rem 2.75rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.75rem;
        font-size: 0.9rem;
        background: white;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .filter-select-group select:focus {
        outline: none;
        border-color: #4f46e5;
    }
    
    .btn-search {
        padding: 0.75rem 1.5rem;
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        color: white;
        border: none;
        border-radius: 0.75rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        white-space: nowrap;
    }
    
    .btn-search:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
    }
    
    /* Section Header */
    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .section-header h3 {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1f2937;
        margin: 0;
    }
    
    .results-count {
        font-size: 0.875rem;
        color: #6b7280;
        background: #f3f4f6;
        padding: 0.5rem 1rem;
        border-radius: 2rem;
    }
    
    /* Service Card */
    .service-card {
        background: white;
        border-radius: 1.25rem;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
        animation: fadeInUp 0.5s ease forwards;
        opacity: 0;
    }
    
    .service-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .service-card-header {
        padding: 1.25rem;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
    }
    
    .service-icon-wrapper {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    
    .service-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.25rem;
    }
    
    .service-status {
        font-size: 0.7rem;
        padding: 0.25rem 0.75rem;
        border-radius: 2rem;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .service-status.active {
        background: rgba(79, 70, 229, 0.1);
        color: #4f46e5;
    }
    
    .btn-menu {
        width: 32px;
        height: 32px;
        border-radius: 8px;
        border: none;
        background: #f3f4f6;
        color: #6b7280;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .btn-menu:hover {
        background: #e5e7eb;
    }
    
    .service-card-body {
        padding: 0 1.25rem;
        flex: 1;
    }
    
    .service-name {
        font-size: 1.1rem;
        font-weight: 700;
        color: #1f2937;
        margin: 0 0 0.5rem;
    }
    
    .service-category {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.8rem;
        color: #6b7280;
    }
    
    .service-category i {
        color: #4f46e5;
    }
    
    .service-card-price {
        margin: 1rem 1.25rem;
        padding: 1rem;
        background: linear-gradient(135deg, rgba(79, 70, 229, 0.05), rgba(124, 58, 237, 0.05));
        border-radius: 0.75rem;
        text-align: center;
        border: 1px solid rgba(79, 70, 229, 0.1);
    }
    
    .price-amount {
        display: flex;
        align-items: flex-start;
        justify-content: center;
        gap: 0.25rem;
    }
    
    .price-amount .currency {
        font-size: 1rem;
        font-weight: 600;
        color: #4f46e5;
        margin-top: 0.25rem;
    }
    
    .price-amount .value {
        font-size: 2rem;
        font-weight: 800;
        color: #4f46e5;
        line-height: 1;
    }
    
    .price-label {
        font-size: 0.75rem;
        color: #6b7280;
    }
    
    .service-card-footer {
        padding: 1rem 1.25rem;
        display: flex;
        gap: 0.5rem;
        border-top: 1px solid #f3f4f6;
    }
    
    .btn-reserve {
        flex: 1;
        padding: 0.6rem 1rem;
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        color: white;
        border: none;
        border-radius: 0.5rem;
        font-size: 0.85rem;
        font-weight: 600;
        text-decoration: none;
        text-align: center;
        transition: all 0.3s ease;
    }
    
    .btn-reserve:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        color: white;
    }
    
    .btn-edit {
        width: 38px;
        height: 38px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #f3f4f6;
        color: #6b7280;
        border-radius: 0.5rem;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    
    .btn-edit:hover {
        background: #e5e7eb;
        color: #1f2937;
    }
    
    /* Empty State */
    .empty-services {
        text-align: center;
        padding: 4rem 2rem;
        background: white;
        border-radius: 1.5rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    }
    
    .empty-icon {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: linear-gradient(135deg, rgba(79, 70, 229, 0.1), rgba(124, 58, 237, 0.1));
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem;
        font-size: 2.5rem;
        color: #4f46e5;
    }
    
    .empty-services h4 {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 0.5rem;
    }
    
    .empty-services p {
        color: #6b7280;
        margin-bottom: 1.5rem;
        max-width: 400px;
        margin-left: auto;
        margin-right: auto;
    }
    
    .btn-add-first {
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 0.75rem;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        transition: all 0.3s ease;
    }
    
    .btn-add-first:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(79, 70, 229, 0.3);
        color: white;
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .service-header-content {
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
        }
        
        .service-header-text h1 {
            font-size: 1.5rem;
        }
        
        .btn-add-service {
            width: 100%;
            justify-content: center;
        }
        
        .search-filter-form {
            flex-direction: column;
        }
        
        .search-input-group,
        .filter-select-group {
            width: 100%;
        }
        
        .btn-search {
            width: 100%;
        }
    }
</style>

<jsp:include page="../shared/footer.jsp"/>