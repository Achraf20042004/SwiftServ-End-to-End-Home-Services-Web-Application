<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Client" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier le client</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/client?action=list">Clients</a></li>
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
                <i class="fas fa-user-edit me-2"></i> Modifier les informations
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/client?action=edit" method="post">
                    <input type="hidden" name="id" value="${client.id}">
                    
                    <!-- Client Info Summary -->
                    <div class="alert alert-info-modern mb-4">
                        <div class="d-flex align-items-center">
                            <div class="avatar-circle bg-primary me-3" style="width: 50px; height: 50px; font-size: 1.25rem;">
                                <i class="fas fa-user"></i>
                            </div>
                            <div>
                                <strong>Client #${client.id}</strong>
                                <p class="mb-0 small text-muted">
                                    Inscrit le: <c:out value="${client.dateInscription}" default="-"/>
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Informations personnelles -->
                    <div class="row">
                        <div class="col-12 mb-4">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-id-card me-2"></i> Informations personnelles
                            </h5>
                            <hr>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="nom" class="form-label-modern">
                                <i class="fas fa-user me-1"></i> Nom *
                            </label>
                            <input type="text" class="form-control-modern" id="nom" name="nom" 
                                   value="${client.nom}" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="prenom" class="form-label-modern">
                                <i class="fas fa-user me-1"></i> Prénom *
                            </label>
                            <input type="text" class="form-control-modern" id="prenom" name="prenom" 
                                   value="${client.prenom}" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label-modern">
                                <i class="fas fa-envelope me-1"></i> Email *
                            </label>
                            <input type="email" class="form-control-modern" id="email" name="email" 
                                   value="${client.email}" required>
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i> L'email ne peut pas être modifié après création
                            </small>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="telephone" class="form-label-modern">
                                <i class="fas fa-phone me-1"></i> Téléphone *
                            </label>
                            <input type="tel" class="form-control-modern" id="telephone" name="telephone" 
                                   value="${client.telephone}" required>
                        </div>
                    </div>
                    
                    <!-- Adresse -->
                    <div class="row mt-4">
                        <div class="col-12 mb-4">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-map-marker-alt me-2"></i> Adresse
                            </h5>
                            <hr>
                        </div>
                        
                        <div class="col-12 mb-3">
                            <label for="adresse" class="form-label-modern">
                                <i class="fas fa-home me-1"></i> Adresse complète
                            </label>
                            <textarea class="form-control-modern" id="adresse" name="adresse" 
                                      rows="2">${client.adresse}</textarea>
                        </div>
                        
                        <div class="col-md-8 mb-3">
                            <label for="ville" class="form-label-modern">
                                <i class="fas fa-city me-1"></i> Ville
                            </label>
                            <input type="text" class="form-control-modern" id="ville" name="ville" 
                                   value="${client.ville}">
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="codePostal" class="form-label-modern">
                                <i class="fas fa-mail-bulk me-1"></i> Code postal
                            </label>
                            <input type="text" class="form-control-modern" id="codePostal" name="codePostal" 
                                   value="${client.codePostal}" pattern="[0-9]{5}">
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <hr class="mb-4">
                            <div class="d-flex gap-2 justify-content-between">
                                <a href="${pageContext.request.contextPath}/client?action=delete&id=${client.id}" 
                                   class="btn btn-danger-custom btn-delete-confirm">
                                    <i class="fas fa-trash me-2"></i> Supprimer ce client
                                </a>
                                <div class="d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/client?action=list" 
                                       class="btn btn-outline-custom">
                                        <i class="fas fa-times me-2"></i> Annuler
                                    </a>
                                    <button type="submit" class="btn btn-primary-custom">
                                        <i class="fas fa-save me-2"></i> Enregistrer les modifications
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Related Info -->
        <div class="card-modern mt-4">
            <div class="card-header-custom">
                <i class="fas fa-info-circle me-2"></i> Informations supplémentaires
            </div>
            <div class="card-body-custom">
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="info-box text-center">
                            <i class="fas fa-calendar-check fa-2x text-primary mb-2"></i>
                            <h5 class="mb-1">12</h5>
                            <p class="text-muted small mb-0">Réservations</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info-box text-center">
                            <i class="fas fa-star fa-2x text-warning mb-2"></i>
                            <h5 class="mb-1">8</h5>
                            <p class="text-muted small mb-0">Avis donnés</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info-box text-center">
                            <i class="fas fa-exclamation-triangle fa-2x text-danger mb-2"></i>
                            <h5 class="mb-1">1</h5>
                            <p class="text-muted small mb-0">Réclamation(s)</p>
                        </div>
                    </div>
                </div>
                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/reservation?clientId=${client.id}" 
                       class="btn btn-sm btn-outline-custom me-2">
                        <i class="fas fa-calendar-alt me-1"></i> Voir les réservations
                    </a>
                    <a href="${pageContext.request.contextPath}/avis?clientId=${client.id}" 
                       class="btn btn-sm btn-outline-custom">
                        <i class="fas fa-star me-1"></i> Voir les avis
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .avatar-circle {
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
    }
    
    .info-box {
        padding: 1.5rem;
        background: #f9fafb;
        border-radius: 0.5rem;
        transition: all 0.3s ease;
    }
    
    .info-box:hover {
        background: #f3f4f6;
        transform: translateY(-2px);
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
