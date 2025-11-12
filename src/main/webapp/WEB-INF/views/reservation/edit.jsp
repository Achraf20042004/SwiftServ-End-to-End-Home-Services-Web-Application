<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Réservation" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier la réservation</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/reservation?action=list">Réservations</a></li>
                    <li class="breadcrumb-item active">Modifier</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-calendar-edit me-2"></i> Modifier les informations
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/reservation?action=edit" method="post">
                    <input type="hidden" name="id" value="${reservation.id}">
                    
                    <!-- Reservation Info -->
                    <div class="alert alert-info-modern mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <strong><i class="fas fa-info-circle me-2"></i> Réservation #${reservation.id}</strong>
                                <p class="mb-0 small text-muted mt-1">
                                    Créée le: <c:out value="${reservation.dateReservation}" default="-"/>
                                </p>
                            </div>
                            <c:choose>
                                <c:when test="${reservation.statut == 'EN_ATTENTE'}">
                                    <span class="badge-custom badge-warning-custom">En attente</span>
                                </c:when>
                                <c:when test="${reservation.statut == 'CONFIRMEE'}">
                                    <span class="badge-custom badge-success-custom">Confirmée</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-custom badge-danger-custom">Annulée</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- Client -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user me-2"></i> Client
                        </h5>
                        <hr>
                        <label for="clientId" class="form-label-modern">
                            <i class="fas fa-user-circle me-1"></i> Client *
                        </label>
                        <select class="form-select-modern" id="clientId" name="clientId" required>
                            <c:forEach var="client" items="${clients}">
                                <option value="${client.id}" ${reservation.client.id == client.id ? 'selected' : ''}>
                                    ${client.nom} ${client.prenom} - ${client.email}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Service -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-briefcase me-2"></i> Service
                        </h5>
                        <hr>
                        <label for="serviceId" class="form-label-modern">
                            <i class="fas fa-concierge-bell me-1"></i> Service *
                        </label>
                        <select class="form-select-modern" id="serviceId" name="serviceId" required>
                            <c:forEach var="service" items="${services}">
                                <option value="${service.id}" ${reservation.service.id == service.id ? 'selected' : ''}>
                                    ${service.nom} - ${service.prix}€
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Prestataire -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user-tie me-2"></i> Prestataire
                        </h5>
                        <hr>
                        <label for="prestataireId" class="form-label-modern">
                            <i class="fas fa-user-check me-1"></i> Prestataire *
                        </label>
                        <select class="form-select-modern" id="prestataireId" name="prestataireId" required>
                            <c:forEach var="prestataire" items="${prestataires}">
                                <option value="${prestataire.id}" ${reservation.prestataire.id == prestataire.id ? 'selected' : ''}>
                                    ${prestataire.nom} ${prestataire.prenom} - ${prestataire.specialite}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Status -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-flag me-2"></i> Statut
                        </h5>
                        <hr>
                        <label for="statut" class="form-label-modern">
                            <i class="fas fa-traffic-light me-1"></i> Modifier le statut *
                        </label>
                        <select class="form-select-modern" id="statut" name="statut" required>
                            <option value="EN_ATTENTE" ${reservation.statut == 'EN_ATTENTE' ? 'selected' : ''}>
                                En attente
                            </option>
                            <option value="CONFIRMEE" ${reservation.statut == 'CONFIRMEE' ? 'selected' : ''}>
                                Confirmée
                            </option>
                            <option value="EN_COURS" ${reservation.statut == 'EN_COURS' ? 'selected' : ''}>
                                En cours
                            </option>
                            <option value="TERMINEE" ${reservation.statut == 'TERMINEE' ? 'selected' : ''}>
                                Terminée
                            </option>
                            <option value="ANNULEE" ${reservation.statut == 'ANNULEE' ? 'selected' : ''}>
                                Annulée
                            </option>
                        </select>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-between">
                        <a href="${pageContext.request.contextPath}/reservation?action=delete&id=${reservation.id}" 
                           class="btn btn-danger-custom btn-delete-confirm">
                            <i class="fas fa-trash me-2"></i> Supprimer cette réservation
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/reservation?action=list" 
                               class="btn btn-outline-custom">
                                <i class="fas fa-times me-2"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-primary-custom">
                                <i class="fas fa-save me-2"></i> Enregistrer les modifications
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Related Intervention -->
        <div class="card-modern mt-4">
            <div class="card-header-custom">
                <i class="fas fa-tools me-2"></i> Intervention associée
            </div>
            <div class="card-body-custom">
                <c:choose>
                    <c:when test="${not empty reservation.intervention}">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-1">Intervention #${reservation.intervention.id}</h6>
                                <p class="text-muted small mb-0">
                                    Statut: ${reservation.intervention.statut}
                                </p>
                            </div>
                            <a href="${pageContext.request.contextPath}/intervention?action=edit&id=${reservation.intervention.id}" 
                               class="btn btn-sm btn-primary-custom">
                                <i class="fas fa-eye me-1"></i> Voir l'intervention
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center text-muted">
                            <i class="fas fa-info-circle me-1"></i> Aucune intervention créée pour cette réservation
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/intervention?action=add&reservationId=${reservation.id}" 
                                   class="btn btn-sm btn-success-custom">
                                    <i class="fas fa-plus me-1"></i> Créer une intervention
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp"/>
