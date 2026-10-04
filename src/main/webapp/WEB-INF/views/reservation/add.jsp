<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouvelle Réservation" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-calendar-plus text-gradient me-2"></i> Créer une nouvelle réservation</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/reservation?action=list">Réservations</a></li>
                    <li class="breadcrumb-item active">Nouvelle</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-calendar-check me-2"></i> Informations de la réservation
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/reservation?action=add" method="post">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                    
                    <!-- Client Selection -->
<div class="mb-4">
    <h5 class="text-primary mb-3">
        <i class="fas fa-user me-2"></i> Client
    </h5>
    <hr>
    <label for="clientId" class="form-label-modern">
        <i class="fas fa-user-circle me-1"></i> Client *
    </label>
    
    <c:choose>
        <c:when test="${not empty clientConnecte}">
            <!-- Client connecté : champ en lecture seule -->
            <input type="hidden" name="clientId" value="${clientConnecte.id}">
            <input type="text" class="form-control-modern" 
                   value="${fn:escapeXml(clientConnecte.nom)} ${fn:escapeXml(clientConnecte.prenom)} - ${fn:escapeXml(clientConnecte.email)}" 
                   readonly disabled>
        </c:when>
        <c:otherwise>
            <!-- Admin : liste déroulante -->
            <select class="form-select-modern" id="clientId" name="clientId" required>
                <option value="">Choisir un client</option>
                <c:forEach var="client" items="${clients}">
                    <option value="${client.id}">
                        ${fn:escapeXml(client.nom)} ${fn:escapeXml(client.prenom)} - ${fn:escapeXml(client.email)}
                    </option>
                </c:forEach>
            </select>
        </c:otherwise>
    </c:choose>
</div>
                    
                    <!-- Service Selection -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-briefcase me-2"></i> Service demandé
                        </h5>
                        <hr>
                        <label for="serviceId" class="form-label-modern">
                            <i class="fas fa-concierge-bell me-1"></i> Sélectionner le service *
                        </label>
                        <select class="form-select-modern" id="serviceId" name="serviceId" required>
                            <option value="">Choisir un service</option>
                            <c:forEach var="service" items="${services}">
                                <option value="${service.id}" data-prix="${service.prix}">
                                    ${fn:escapeXml(service.nom)} - ${service.prix}€
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Prestataire Selection -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-user-tie me-2"></i> Prestataire
                        </h5>
                        <hr>
                        <label for="prestataireId" class="form-label-modern">
                            <i class="fas fa-user-check me-1"></i> Sélectionner le prestataire *
                        </label>
                        <select class="form-select-modern" id="prestataireId" name="prestataireId" required>
                            <option value="">Choisir un prestataire</option>
                            <c:forEach var="prestataire" items="${prestataires}">
                                <option value="${prestataire.id}">
                                    ${fn:escapeXml(prestataire.nom)} ${fn:escapeXml(prestataire.prenom)} - ${fn:escapeXml(prestataire.specialite)}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Status -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-info-circle me-2"></i> Détails
                        </h5>
                        <hr>
                        <label for="statut" class="form-label-modern">
                            <i class="fas fa-flag me-1"></i> Statut *
                        </label>
                        <select class="form-select-modern" id="statut" name="statut" required>
                            <option value="EN_ATTENTE" selected>En attente</option>
                            <option value="CONFIRMEE">Confirmée</option>
                            <option value="ANNULEE">Annulée</option>
                        </select>
                    </div>
                    
                    <!-- Summary -->
                    <div class="alert alert-info-modern">
                        <h6 class="mb-3"><i class="fas fa-receipt me-2"></i> Récapitulatif</h6>
                        <div class="summary-content">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Client:</span>
                                <strong id="summary-client">-</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Service:</span>
                                <strong id="summary-service">-</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Prestataire:</span>
                                <strong id="summary-prestataire">-</strong>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span class="h6 mb-0">Montant:</span>
                                <strong class="h5 mb-0 text-primary" id="summary-prix">0.00€</strong>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/reservation?action=list" 
                           class="btn btn-outline-custom">
                            <i class="fas fa-times me-2"></i> Annuler
                        </a>
                        <button type="reset" class="btn btn-outline-custom">
                            <i class="fas fa-redo me-2"></i> Réinitialiser
                        </button>
                        <button type="submit" class="btn btn-success-custom">
                            <i class="fas fa-save me-2"></i> Créer la réservation
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Update summary on selection change
    <c:if test="${empty clientConnecte}">
    document.getElementById('clientId').addEventListener('change', function(e) {
        const text = e.target.options[e.target.selectedIndex].text;
        document.getElementById('summary-client').textContent = text || '-';
    });
    </c:if>
    
    <c:if test="${not empty clientConnecte}">
    // Pré-remplir le résumé pour le client connecté
    document.getElementById('summary-client').textContent = '${fn:escapeXml(clientConnecte.nom)} ${fn:escapeXml(clientConnecte.prenom)}';
    </c:if>
    
    document.getElementById('serviceId').addEventListener('change', function(e) {
        const text = e.target.options[e.target.selectedIndex].text;
        const prix = e.target.options[e.target.selectedIndex].dataset.prix || '0';
        document.getElementById('summary-service').textContent = text || '-';
        document.getElementById('summary-prix').textContent = parseFloat(prix).toFixed(2) + '€';
    });
    
    document.getElementById('prestataireId').addEventListener('change', function(e) {
        const text = e.target.options[e.target.selectedIndex].text;
        document.getElementById('summary-prestataire').textContent = text || '-';
    });
</script>

<jsp:include page="../shared/footer.jsp"/>
