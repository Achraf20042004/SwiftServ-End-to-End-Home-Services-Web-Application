<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Réclamations" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid px-4">
    <!-- Page Header -->
    <div class="row mb-4 fade-in">
        <div class="col-12">
            <div class="page-header-modern">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h1 class="page-title">
                            <span class="title-icon">
                                <i class="fas fa-exclamation-triangle"></i>
                            </span>
                            Gestion des réclamations
                        </h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="${pageContext.request.contextPath}/dashboard">
                                        <i class="fas fa-home me-1"></i>Accueil
                                    </a>
                                </li>
                                <li class="breadcrumb-item active">Réclamations</li>
                            </ol>
                        </nav>
                    </div>
                    <a href="${pageContext.request.contextPath}/reclamation?action=add" class="btn btn-add-new">
                        <i class="fas fa-plus me-2"></i> Nouvelle réclamation
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-lg-6 col-md-6 fade-in" style="animation-delay: 0.1s;">
            <div class="stat-card stat-card-total">
                <div class="stat-card-body">
                    <div class="stat-icon-wrapper">
                        <div class="stat-icon">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                    </div>
                    <div class="stat-content">
                        <h2 class="stat-number">${reclamations.size()}</h2>
                        <p class="stat-label">Total Réclamations</p>
                    </div>
                    <div class="stat-wave">
                        <svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg">
                            <path fill="currentColor" fill-opacity="0.1" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-lg-6 col-md-6 fade-in" style="animation-delay: 0.2s;">
            <div class="stat-card stat-card-pending">
                <div class="stat-card-body">
                    <div class="stat-icon-wrapper">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                    </div>
                    <div class="stat-content">
                        <h2 class="stat-number">${countEnAttente != null ? countEnAttente : 0}</h2>
                        <p class="stat-label">En Attente</p>
                    </div>
                    <div class="stat-wave">
                        <svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg">
                            <path fill="currentColor" fill-opacity="0.1" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-lg-6 col-md-6 fade-in" style="animation-delay: 0.3s;">
            <div class="stat-card stat-card-progress">
                <div class="stat-card-body">
                    <div class="stat-icon-wrapper">
                        <div class="stat-icon">
                            <i class="fas fa-sync-alt"></i>
                        </div>
                    </div>
                    <div class="stat-content">
                        <h2 class="stat-number">${countEnCours != null ? countEnCours : 0}</h2>
                        <p class="stat-label">En Cours</p>
                    </div>
                    <div class="stat-wave">
                        <svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg">
                            <path fill="currentColor" fill-opacity="0.1" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-lg-6 col-md-6 fade-in" style="animation-delay: 0.4s;">
            <div class="stat-card stat-card-resolved">
                <div class="stat-card-body">
                    <div class="stat-icon-wrapper">
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                    <div class="stat-content">
                        <h2 class="stat-number">${countResolue != null ? countResolue : 0}</h2>
                        <p class="stat-label">Résolues</p>
                    </div>
                    <div class="stat-wave">
                        <svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg">
                            <path fill="currentColor" fill-opacity="0.1" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search and Filter Bar -->
    <div class="row mb-4 fade-in" style="animation-delay: 0.5s;">
        <div class="col-12">
            <div class="filter-bar">
                <div class="row align-items-center">
                    <div class="col-lg-4 col-md-6 mb-3 mb-lg-0">
                        <div class="search-box">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" class="form-control search-input" placeholder="Rechercher une réclamation..." id="searchInput">
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-6">
                        <div class="d-flex justify-content-md-end gap-2 flex-wrap">
                            <button class="btn btn-filter-option active" data-filter="all">
                                <i class="fas fa-list me-1"></i> Toutes
                            </button>
                            <button class="btn btn-filter-option" data-filter="recent">
                                <i class="fas fa-clock me-1"></i> Récentes
                            </button>
                            <div class="dropdown">
                                <button class="btn btn-export dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-download me-1"></i> Exporter
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-file-excel me-2 text-success"></i>Excel</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-file-pdf me-2 text-danger"></i>PDF</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-file-csv me-2 text-primary"></i>CSV</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Table -->
    <div class="row fade-in" style="animation-delay: 0.6s;">
        <div class="col-12">
            <div class="table-card">
                <div class="table-card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="header-title">
                            <i class="fas fa-list-alt me-2"></i>
                            <span>Liste des réclamations</span>
                            <span class="badge bg-primary ms-2">${reclamations.size()}</span>
                        </div>
                        <div class="header-actions">
                            <button class="btn btn-icon" title="Rafraîchir" onclick="location.reload();">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                            <button class="btn btn-icon" title="Colonnes">
                                <i class="fas fa-columns"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="table-card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-custom" id="reclamationsTable">
                            <thead>
                                <tr>
                                    <th class="th-select">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="selectAll">
                                        </div>
                                    </th>
                                    <th class="th-id">
                                        <span>ID</span>
                                        <i class="fas fa-sort ms-1"></i>
                                    </th>
                                    <th class="th-client">
                                        <span>Client</span>
                                        <i class="fas fa-sort ms-1"></i>
                                    </th>
                                    <th class="th-description">
                                        <span>Description</span>
                                    </th>
                                    <th class="th-date">
                                        <span>Date</span>
                                        <i class="fas fa-sort ms-1"></i>
                                    </th>
                                    <th class="th-actions text-center">
                                        <span>Actions</span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="reclamation" items="${reclamations}" varStatus="loop">
                                    <tr class="table-row" style="animation-delay: ${loop.index * 0.05}s;">
                                        <td>
                                            <div class="form-check">
                                                <input class="form-check-input row-select" type="checkbox" value="${reclamation.id}">
                                            </div>
                                        </td>
                                        <td>
                                            <span class="id-badge">#${reclamation.id}</span>
                                        </td>
                                        <td>
                                            <div class="client-info">
                                                <div class="client-avatar">
                                                    <span class="avatar-text">${reclamation.client.prenom.substring(0,1)}${reclamation.client.nom.substring(0,1)}</span>
                                                </div>
                                                <div class="client-details">
                                                    <h6 class="client-name">${fn:escapeXml(reclamation.client.prenom)} ${fn:escapeXml(reclamation.client.nom)}</h6>
                                                    <span class="client-email">${fn:escapeXml(reclamation.client.email)}</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="description-cell">
                                                <p class="description-text">${fn:escapeXml(reclamation.description)}</p>
                                                <button class="btn btn-view-more" onclick="showFullDescription('${fn:escapeXml(reclamation.description)}')">
                                                    <i class="fas fa-expand-alt"></i>
                                                </button>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="date-info">
                                                <i class="fas fa-calendar-alt me-1"></i>
                                                <span><c:out value="${reclamation.dateReclamation}" default="Non définie"/></span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-buttons-modern">
                                                <a href="${pageContext.request.contextPath}/reclamation?action=edit&id=${reclamation.id}" 
                                                   class="btn btn-action-edit" 
                                                   data-bs-toggle="tooltip" 
                                                   title="Modifier">
                                                    <i class="fas fa-pen"></i>
                                                </a>
                                                <button class="btn btn-action-view" 
                                                        data-bs-toggle="tooltip" 
                                                        title="Voir détails"
                                                        onclick="viewDetails(${reclamation.id})">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <a href="${pageContext.request.contextPath}/reclamation?action=delete&id=${reclamation.id}" 
                                                   class="btn btn-action-delete" 
                                                   data-bs-toggle="tooltip" 
                                                   title="Supprimer"
                                                   onclick="return confirmDelete()">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty reclamations}">
                                    <tr>
                                        <td colspan="6">
                                            <div class="empty-state">
                                                <div class="empty-icon">
                                                    <i class="fas fa-inbox"></i>
                                                </div>
                                                <h4>Aucune réclamation trouvée</h4>
                                                <p>Les réclamations de vos clients apparaîtront ici</p>
                                                <a href="${pageContext.request.contextPath}/reclamation?action=add" class="btn btn-add-empty">
                                                    <i class="fas fa-plus me-2"></i> Ajouter une réclamation
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <c:if test="${not empty reclamations}">
                    <div class="table-card-footer">
                        <div class="d-flex justify-content-between align-items-center flex-wrap">
                            <div class="showing-info">
                                Affichage de <strong>1</strong> à <strong>${reclamations.size()}</strong> sur <strong>${reclamations.size()}</strong> entrées
                            </div>
                            <nav aria-label="Pagination">
                                <ul class="pagination pagination-modern mb-0">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
                                    </li>
                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#"><i class="fas fa-chevron-right"></i></a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Full Description -->
<div class="modal fade" id="descriptionModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-modern">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-file-alt me-2"></i>Description complète
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="fullDescription"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
            </div>
        </div>
    </div>
</div>

<style>
/* ===== VARIABLES ===== */
:root {
    --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
    --warning-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    --card-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
    --hover-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
}

/* ===== PAGE HEADER ===== */
.page-header-modern {
    background: white;
    border-radius: 16px;
    padding: 24px 30px;
    box-shadow: var(--card-shadow);
    margin-bottom: 10px;
}

.page-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: #1a1a2e;
    margin-bottom: 8px;
    display: flex;
    align-items: center;
}

.title-icon {
    width: 45px;
    height: 45px;
    background: var(--primary-gradient);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;
    color: white;
    font-size: 1.25rem;
}

.btn-add-new {
    background: var(--primary-gradient);
    border: none;
    color: white;
    padding: 12px 24px;
    border-radius: 10px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.btn-add-new:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
    color: white;
}

/* ===== STAT CARDS ===== */
.stat-card {
    border-radius: 16px;
    overflow: hidden;
    transition: all 0.3s ease;
    height: 100%;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: var(--hover-shadow);
}

.stat-card-body {
    padding: 24px;
    position: relative;
    color: white;
    min-height: 140px;
}

.stat-card-total .stat-card-body { background: var(--primary-gradient); }
.stat-card-pending .stat-card-body { background: var(--warning-gradient); }
.stat-card-progress .stat-card-body { background: var(--info-gradient); }
.stat-card-resolved .stat-card-body { background: var(--success-gradient); }

.stat-icon-wrapper {
    position: absolute;
    top: 20px;
    right: 20px;
}

.stat-icon {
    width: 50px;
    height: 50px;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}

.stat-number {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 5px;
}

.stat-label {
    font-size: 0.9rem;
    opacity: 0.9;
    margin-bottom: 0;
}

.stat-wave {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 60px;
}

/* ===== FILTER BAR ===== */
.filter-bar {
    background: white;
    border-radius: 16px;
    padding: 20px 24px;
    box-shadow: var(--card-shadow);
}

.search-box {
    position: relative;
}

.search-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #a0aec0;
}

.search-input {
    padding-left: 45px;
    border-radius: 10px;
    border: 2px solid #e2e8f0;
    height: 45px;
    transition: all 0.3s ease;
}

.search-input:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.btn-filter-option {
    background: #f7fafc;
    border: 2px solid #e2e8f0;
    color: #4a5568;
    padding: 8px 16px;
    border-radius: 8px;
    font-weight: 500;
    transition: all 0.3s ease;
}

.btn-filter-option:hover,
.btn-filter-option.active {
    background: var(--primary-gradient);
    border-color: transparent;
    color: white;
}

.btn-export {
    background: #48bb78;
    border: none;
    color: white;
    padding: 8px 16px;
    border-radius: 8px;
    font-weight: 500;
}

.btn-export:hover {
    background: #38a169;
    color: white;
}

/* ===== TABLE CARD ===== */
.table-card {
    background: white;
    border-radius: 16px;
    box-shadow: var(--card-shadow);
    overflow: hidden;
}

.table-card-header {
    padding: 20px 24px;
    border-bottom: 1px solid #f0f0f0;
    background: #fafbfc;
}

.header-title {
    font-weight: 600;
    color: #1a1a2e;
    font-size: 1.1rem;
}

.btn-icon {
    width: 36px;
    height: 36px;
    border-radius: 8px;
    border: 1px solid #e2e8f0;
    background: white;
    color: #4a5568;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    margin-left: 8px;
}

.btn-icon:hover {
    background: #667eea;
    border-color: #667eea;
    color: white;
}

/* ===== TABLE STYLES ===== */
.table-custom {
    margin-bottom: 0;
}

.table-custom thead th {
    background: #f8fafc;
    border: none;
    padding: 16px;
    font-weight: 600;
    color: #4a5568;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    cursor: pointer;
}

.table-custom tbody tr {
    transition: all 0.3s ease;
    border-bottom: 1px solid #f0f0f0;
}

.table-custom tbody tr:hover {
    background: #f7fafc;
}

.table-custom tbody td {
    padding: 16px;
    vertical-align: middle;
}

/* ID Badge */
.id-badge {
    background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%);
    color: #4338ca;
    padding: 6px 12px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 0.85rem;
}

/* Client Info */
.client-info {
    display: flex;
    align-items: center;
}

.client-avatar {
    width: 42px;
    height: 42px;
    border-radius: 10px;
    background: var(--primary-gradient);
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 12px;
    flex-shrink: 0;
}

.avatar-text {
    color: white;
    font-weight: 600;
    font-size: 0.9rem;
}

.client-name {
    font-weight: 600;
    color: #1a1a2e;
    margin-bottom: 2px;
    font-size: 0.95rem;
}

.client-email {
    color: #a0aec0;
    font-size: 0.8rem;
}

/* Description Cell */
.description-cell {
    position: relative;
    display: flex;
    align-items: center;
}

.description-text {
    margin: 0;
    color: #4a5568;
    max-width: 250px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.btn-view-more {
    padding: 4px 8px;
    background: #f7fafc;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    color: #667eea;
    margin-left: 10px;
    font-size: 0.75rem;
}

.btn-view-more:hover {
    background: #667eea;
    color: white;
}

/* Date Info */
.date-info {
    color: #718096;
    font-size: 0.9rem;
}

/* Action Buttons */
.action-buttons-modern {
    display: flex;
    gap: 8px;
    justify-content: center;
}

.action-buttons-modern .btn {
    width: 36px;
    height: 36px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    border: none;
}

.btn-action-edit {
    background: #ebf5ff;
    color: #3182ce;
}

.btn-action-edit:hover {
    background: #3182ce;
    color: white;
    transform: translateY(-2px);
}

.btn-action-view {
    background: #f0fff4;
    color: #38a169;
}

.btn-action-view:hover {
    background: #38a169;
    color: white;
    transform: translateY(-2px);
}

.btn-action-delete {
    background: #fff5f5;
    color: #e53e3e;
}

.btn-action-delete:hover {
    background: #e53e3e;
    color: white;
    transform: translateY(-2px);
}

/* ===== TABLE FOOTER ===== */
.table-card-footer {
    padding: 16px 24px;
    background: #fafbfc;
    border-top: 1px solid #f0f0f0;
}

.showing-info {
    color: #718096;
    font-size: 0.9rem;
}

.pagination-modern .page-link {
    border: none;
    padding: 8px 14px;
    margin: 0 3px;
    border-radius: 8px;
    color: #4a5568;
    font-weight: 500;
}

.pagination-modern .page-item.active .page-link {
    background: var(--primary-gradient);
    color: white;
}

.pagination-modern .page-item:not(.active) .page-link:hover {
    background: #f7fafc;
}

/* ===== EMPTY STATE ===== */
.empty-state {
    padding: 60px 20px;
    text-align: center;
}

.empty-icon {
    width: 80px;
    height: 80px;
    background: #f7fafc;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 20px;
    font-size: 2rem;
    color: #a0aec0;
}

.empty-state h4 {
    color: #1a1a2e;
    margin-bottom: 10px;
}

.empty-state p {
    color: #718096;
    margin-bottom: 20px;
}

.btn-add-empty {
    background: var(--primary-gradient);
    border: none;
    color: white;
    padding: 12px 24px;
    border-radius: 10px;
    font-weight: 600;
}

/* ===== MODAL ===== */
.modal-modern {
    border-radius: 16px;
    border: none;
}

.modal-modern .modal-header {
    border-bottom: 1px solid #f0f0f0;
    padding: 20px 24px;
}

.modal-modern .modal-body {
    padding: 24px;
}

/* ===== ANIMATIONS ===== */
.fade-in {
    animation: fadeInUp 0.5s ease forwards;
    opacity: 0;
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

.table-row {
    animation: fadeInUp 0.3s ease forwards;
    opacity: 0;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 768px) {
    .page-header-modern {
        padding: 16px 20px;
    }
    
    .page-title {
        font-size: 1.25rem;
    }
    
    .stat-number {
        font-size: 1.75rem;
    }
    
    .client-info {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .client-avatar {
        margin-bottom: 8px;
    }
}
</style>

<script>
// Initialize tooltips
document.addEventListener('DOMContentLoaded', function() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

// Show full description in modal
function showFullDescription(description) {
    document.getElementById('fullDescription').textContent = description;
    var modal = new bootstrap.Modal(document.getElementById('descriptionModal'));
    modal.show();
}

// Confirm delete
function confirmDelete() {
    return confirm('Êtes-vous sûr de vouloir supprimer cette réclamation ? Cette action est irréversible.');
}

// View details
function viewDetails(id) {
    alert('Voir les détails de la réclamation #' + id);
}

// Select all checkboxes
document.getElementById('selectAll')?.addEventListener('change', function() {
    var checkboxes = document.querySelectorAll('.row-select');
    checkboxes.forEach(cb => cb.checked = this.checked);
});

// Search functionality
document.getElementById('searchInput')?.addEventListener('input', function() {
    var searchTerm = this.value.toLowerCase();
    var rows = document.querySelectorAll('#reclamationsTable tbody tr');
    
    rows.forEach(function(row) {
        var text = row.textContent.toLowerCase();
        row.style.display = text.includes(searchTerm) ? '' : 'none';
    });
});
</script>

<jsp:include page="../shared/footer.jsp"/>
