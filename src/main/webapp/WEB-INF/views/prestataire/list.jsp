<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Prestataires" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-user-tie text-gradient me-2"></i> Gestion des prestataires</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Prestataires</li>
                    </ol>
                </nav>
            </div>
            <a href="${pageContext.request.contextPath}/prestataire?action=add" class="btn btn-primary-custom">
                <i class="fas fa-plus me-2"></i> Nouveau prestataire
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
                               placeholder="Nom, email, spécialité..." value="${param.search}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label-modern">
                            <i class="fas fa-briefcase me-1"></i> Spécialité
                        </label>
                        <select class="form-select-modern" name="specialite">
                            <option value="">Toutes les spécialités</option>
                            <option value="menage">Ménage</option>
                            <option value="jardinage">Jardinage</option>
                            <option value="bricolage">Bricolage</option>
                            <option value="plomberie">Plomberie</option>
                            <option value="electricite">Électricité</option>
                            <option value="peinture">Peinture</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label-modern">
                            <i class="fas fa-calendar-check me-1"></i> Disponibilité
                        </label>
                        <select class="form-select-modern" name="disponibilite">
                            <option value="">Tous</option>
                            <option value="disponible">Disponible</option>
                            <option value="occupe">Occupé</option>
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

<!-- Prestataires Table -->
<div class="row fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-header-custom d-flex justify-content-between align-items-center">
                <span><i class="fas fa-list me-2"></i> Liste des prestataires (${prestataires.size()})</span>
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
                                <th>Prestataire</th>
                                <th>Contact</th>
                                <th>Spécialité</th>
                                <th>Disponibilité</th>
                                <th>Évaluation</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prestataire" items="${prestataires}" varStatus="status">
                                <tr>
                                    <td><strong>${status.index + 1}</strong></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-circle bg-success me-2">
                                                <i class="fas fa-user-tie"></i>
                                            </div>
                                            <div>
                                                <strong>${prestataire.nom} ${prestataire.prenom}</strong>
                                                <br>
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar me-1"></i>
                                                    Inscrit: <c:out value="${prestataire.dateInscription}" default="-"/>
                                                </small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <i class="fas fa-envelope text-muted me-1"></i>
                                            <small>${prestataire.email}</small>
                                        </div>
                                        <div>
                                            <i class="fas fa-phone text-muted me-1"></i>
                                            <small>${prestataire.telephone}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge-custom badge-info-custom">
                                            ${prestataire.specialite != null ? prestataire.specialite : 'Non définie'}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${prestataire.disponibilite == 'disponible'}">
                                                <span class="badge-custom badge-success-custom">
                                                    <i class="fas fa-check-circle me-1"></i> Disponible
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-custom badge-warning-custom">
                                                    <i class="fas fa-clock me-1"></i> Occupé
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-star text-warning me-1"></i>
                                            <strong>4.8</strong>
                                            <small class="text-muted ms-1">(24)</small>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons justify-content-center">
                                            <a href="${pageContext.request.contextPath}/prestataire?action=edit&id=${prestataire.id}" 
                                               class="btn btn-action btn-primary-custom" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/intervention?prestataireId=${prestataire.id}" 
                                               class="btn btn-action btn-info" title="Interventions">
                                                <i class="fas fa-tasks"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/avis?prestataireId=${prestataire.id}" 
                                               class="btn btn-action btn-warning" title="Avis">
                                                <i class="fas fa-star"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/prestataire?action=delete&id=${prestataire.id}" 
                                               class="btn btn-action btn-danger-custom btn-delete-confirm" 
                                               title="Supprimer">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty prestataires}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <i class="fas fa-inbox fa-3x text-muted mb-3 d-block"></i>
                                        <p class="text-muted mb-0">Aucun prestataire trouvé</p>
                                        <a href="${pageContext.request.contextPath}/prestataire?action=add" class="btn btn-sm btn-primary-custom mt-3">
                                            <i class="fas fa-plus me-1"></i> Ajouter le premier prestataire
                                        </a>
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
</style>

<jsp:include page="../shared/footer.jsp"/>
