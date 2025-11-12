<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Clients" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-users text-gradient me-2"></i> Gestion des clients</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Clients</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/client?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouveau client
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
                    <div class="col-md-4">
                        <label class="form-label-modern">
                            <i class="fas fa-search me-1"></i> Rechercher
                        </label>
                        <input type="text" class="form-control-modern" name="search" 
                               placeholder="Nom, email, téléphone..." value="${param.search}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label-modern">
                            <i class="fas fa-city me-1"></i> Ville
                        </label>
                        <input type="text" class="form-control-modern" name="ville" 
                               placeholder="Toutes les villes" value="${param.ville}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label-modern">
                            <i class="fas fa-sort me-1"></i> Trier par
                        </label>
                        <select class="form-select-modern" name="sort">
                            <option value="nom">Nom</option>
                            <option value="dateInscription">Date d'inscription</option>
                            <option value="ville">Ville</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary-custom w-100">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Clients Table -->
<div class="row fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-header-custom d-flex justify-content-between align-items-center">
                <span><i class="fas fa-list me-2"></i> Liste des clients (${clients.size()})</span>
                <div>
                    <button class="btn btn-sm btn-light" onclick="window.print()">
                        <i class="fas fa-print me-1"></i> Imprimer
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
                                <th>Nom complet</th>
                                <th>Email</th>
                                <th>Téléphone</th>
                                <th>Ville</th>
                                <th>Date d'inscription</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="client" items="${clients}" varStatus="status">
                                <tr>
                                    <td><strong>${status.index + 1}</strong></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-circle bg-primary me-2">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <div>
                                                <strong>${client.nom} ${client.prenom}</strong>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <i class="fas fa-envelope text-muted me-1"></i>
                                        ${client.email}
                                    </td>
                                    <td>
                                        <i class="fas fa-phone text-muted me-1"></i>
                                        ${client.telephone}
                                    </td>
                                    <td>
                                        <i class="fas fa-map-marker-alt text-muted me-1"></i>
                                        ${client.ville != null ? client.ville : '-'}
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <i class="fas fa-calendar me-1"></i>
                                            <c:out value="${client.dateInscription}" default="-"/>
                                        </small>
                                    </td>
                                    <td>
                                        <div class="action-buttons justify-content-center">
                                            <a href="${pageContext.request.contextPath}/client?action=edit&id=${client.id}" 
                                               class="btn btn-action btn-primary-custom" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/reservation?clientId=${client.id}" 
                                               class="btn btn-action btn-info" title="Réservations">
                                                <i class="fas fa-calendar-alt"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/client?action=delete&id=${client.id}" 
                                               class="btn btn-action btn-danger-custom btn-delete-confirm" 
                                               title="Supprimer">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty clients}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <i class="fas fa-inbox fa-3x text-muted mb-3 d-block"></i>
                                        <p class="text-muted mb-0">Aucun client trouvé</p>
                                        <a href="${pageContext.request.contextPath}/client?action=add" class="btn btn-sm btn-primary-custom mt-3">
                                            <i class="fas fa-plus me-1"></i> Ajouter le premier client
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Pagination -->
            <c:if test="${not empty clients && clients.size() > 10}">
                <div class="card-footer bg-light">
                    <nav aria-label="Pagination">
                        <ul class="pagination justify-content-center mb-0">
                            <li class="page-item disabled">
                                <a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#"><i class="fas fa-chevron-right"></i></a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
</div>

<style>
    .avatar-circle {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1rem;
    }
    
    .action-buttons {
        display: flex;
        gap: 0.5rem;
    }
    
    @media print {
        .page-header a,
        .action-buttons,
        .card-header-custom div {
            display: none !important;
        }
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
