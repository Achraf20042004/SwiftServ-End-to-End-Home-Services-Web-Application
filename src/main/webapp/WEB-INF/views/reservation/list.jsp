<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Réservations" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-calendar-alt text-gradient me-2"></i> Gestion des réservations</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Réservations</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/reservation?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouvelle réservation
            </a>
        </div>
    </div>
</div>

<!-- Filter Tabs -->
<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-body-custom">
                <ul class="nav nav-pills" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" href="?statut=">
                            <i class="fas fa-list me-1"></i> Toutes (${reservations.size()})
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?statut=EN_ATTENTE">
                            <i class="fas fa-clock me-1"></i> En attente
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?statut=CONFIRMEE">
                            <i class="fas fa-check me-1"></i> Confirmées
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?statut=TERMINEE">
                            <i class="fas fa-check-double me-1"></i> Terminées
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?statut=ANNULEE">
                            <i class="fas fa-times me-1"></i> Annulées
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Reservations Table -->
<div class="row fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-header-custom d-flex justify-content-between align-items-center">
                <span><i class="fas fa-list me-2"></i> Liste des réservations</span>
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
                                <th>Client</th>
                                <th>Service</th>
                                <th>Prestataire</th>
                                <th>Date</th>
                                <th>Statut</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reservation" items="${reservations}" varStatus="status">
                                <tr>
                                    <td><strong>#${reservation.id}</strong></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-circle bg-primary me-2">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <div>
                                                <strong>${reservation.client.nom} ${reservation.client.prenom}</strong>
                                                <br><small class="text-muted">${reservation.client.email}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <i class="fas fa-briefcase text-info me-1"></i>
                                        ${reservation.service.nom}
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-circle bg-success me-2">
                                                <i class="fas fa-user-tie"></i>
                                            </div>
                                            <span>${reservation.prestataire.nom} ${reservation.prestataire.prenom}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <small>
                                            <i class="fas fa-calendar me-1"></i>
                                            <c:out value="${reservation.dateReservation}" default="-"/>
                                        </small>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${reservation.statut == 'EN_ATTENTE'}">
                                                <span class="badge-custom badge-warning-custom">
                                                    <i class="fas fa-clock me-1"></i> En attente
                                                </span>
                                            </c:when>
                                            <c:when test="${reservation.statut == 'CONFIRMEE'}">
                                                <span class="badge-custom badge-success-custom">
                                                    <i class="fas fa-check me-1"></i> Confirmée
                                                </span>
                                            </c:when>
                                            <c:when test="${reservation.statut == 'TERMINEE'}">
                                                <span class="badge-custom badge-info-custom">
                                                    <i class="fas fa-check-double me-1"></i> Terminée
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-custom badge-danger-custom">
                                                    <i class="fas fa-times me-1"></i> Annulée
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons justify-content-center">
                                            <a href="${pageContext.request.contextPath}/reservation?action=edit&id=${reservation.id}" 
                                               class="btn btn-action btn-primary-custom" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/intervention?reservationId=${reservation.id}" 
                                               class="btn btn-action btn-success-custom" title="Intervention">
                                                <i class="fas fa-tools"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/reservation?action=delete&id=${reservation.id}" 
                                               class="btn btn-action btn-danger-custom btn-delete-confirm" 
                                               title="Supprimer">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reservations}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <i class="fas fa-inbox fa-3x text-muted mb-3 d-block"></i>
                                        <p class="text-muted mb-0">Aucune réservation trouvée</p>
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

<style>
    .avatar-circle {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 0.875rem;
    }
    
    .nav-pills .nav-link {
        color: var(--text-secondary);
        border-radius: 0.5rem;
        padding: 0.5rem 1rem;
        margin-right: 0.5rem;
    }
    
    .nav-pills .nav-link:hover {
        background-color: var(--light-gray);
    }
    
    .nav-pills .nav-link.active {
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
        color: white;
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
