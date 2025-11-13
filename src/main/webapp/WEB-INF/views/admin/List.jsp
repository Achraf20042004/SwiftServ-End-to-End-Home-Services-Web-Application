<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Administrateurs" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-user-shield text-gradient me-2"></i> Gestion des administrateurs</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Administrateurs</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/admin?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouvel administrateur
            </a>
        </div>
    </div>
</div>

<!-- Stats Cards -->
<div class="row g-4 mb-4 fade-in">
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-primary">
                <i class="fas fa-user-shield"></i>
            </div>
            <div class="stat-value">${admins.size()}</div>
            <div class="stat-label">Total admins</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-success">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-value">5</div>
            <div class="stat-label">Actifs</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-warning">
                <i class="fas fa-crown"></i>
            </div>
            <div class="stat-value">2</div>
            <div class="stat-label">Super admins</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-info">
                <i class="fas fa-user-plus"></i>
            </div>
            <div class="stat-value">1</div>
            <div class="stat-label">Ce mois</div>
        </div>
    </div>
</div>

<!-- Admins List -->
<div class="row fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-header-custom d-flex justify-content-between align-items-center">
                <span><i class="fas fa-list me-2"></i> Liste des administrateurs</span>
                <div>
                    <button class="btn btn-sm btn-light">
                        <i class="fas fa-filter me-1"></i> Filtrer
                    </button>
                    <button class="btn btn-sm btn-success-custom">
                        <i class="fas fa-file-excel me-1"></i> Exporter
                    </button>
                </div>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <table class="table table-modern mb-0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Administrateur</th>
                                <th>Contact</th>
                                <th>Niveau d'accès</th>
                                <th>Dernière connexion</th>
                                <th>Statut</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="admin" items="${admins}" varStatus="status">
                                <tr>
                                    <td><strong>${status.index + 1}</strong></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="admin-avatar me-3">
                                                <i class="fas fa-user-shield"></i>
                                            </div>
                                            <div>
                                                <strong>${admin.nom} ${admin.prenom}</strong>
                                                <c:if test="${admin.superAdmin}">
                                                    <span class="ms-2">
                                                        <i class="fas fa-crown text-warning" title="Super Admin"></i>
                                                    </span>
                                                </c:if>
                                                <br>
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar me-1"></i>
                                                    Inscrit: <c:out value="${admin.dateInscription}" default="-"/>
                                                </small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <i class="fas fa-envelope text-muted me-1"></i>
                                            <small>${admin.email}</small>
                                        </div>
                                        <div>
                                            <i class="fas fa-phone text-muted me-1"></i>
                                            <small>${admin.telephone}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${admin.superAdmin}">
                                                <span class="badge-custom badge-warning-custom">
                                                    <i class="fas fa-crown me-1"></i> Super Admin
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-custom badge-primary-custom">
                                                    <i class="fas fa-user-shield me-1"></i> Admin
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <i class="fas fa-clock me-1"></i>
                                            Il y a 2 heures
                                        </small>
                                    </td>
                                    <td>
                                        <span class="badge-custom badge-success-custom">
                                            <i class="fas fa-check-circle me-1"></i> Actif
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons justify-content-center">
                                            <a href="${pageContext.request.contextPath}/admin?action=edit&id=${admin.id}" 
                                               class="btn btn-action btn-primary-custom" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button class="btn btn-action btn-warning" 
                                                    title="Permissions" data-bs-toggle="modal" data-bs-target="#permissionsModal">
                                                <i class="fas fa-key"></i>
                                            </button>
                                            <c:if test="${!admin.superAdmin}">
                                                <a href="${pageContext.request.contextPath}/admin?action=delete&id=${admin.id}" 
                                                   class="btn btn-action btn-danger-custom btn-delete-confirm" 
                                                   title="Supprimer">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty admins}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <i class="fas fa-inbox fa-3x text-muted mb-3 d-block"></i>
                                        <p class="text-muted mb-0">Aucun administrateur trouvé</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Security Info Card -->
<div class="row mt-4 fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-body-custom">
                <div class="alert alert-warning-modern mb-0">
                    <div class="d-flex align-items-start">
                        <i class="fas fa-shield-alt fa-2x text-warning me-3"></i>
                        <div>
                            <h6 class="mb-2">
                                <i class="fas fa-exclamation-triangle me-1"></i> Informations de sécurité
                            </h6>
                            <ul class="mb-0 small">
                                <li>Les Super Admins ont un accès complet et ne peuvent pas être supprimés</li>
                                <li>Chaque modification d'administrateur est enregistrée dans les logs</li>
                                <li>Les mots de passe doivent contenir au moins 8 caractères</li>
                                <li>L'authentification à deux facteurs est recommandée</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .admin-avatar {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.125rem;
    }
    
    .action-buttons {
        display: flex;
        gap: 0.5rem;
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
