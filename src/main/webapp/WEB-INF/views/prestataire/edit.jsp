<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Prestataire" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier le prestataire</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/prestataire?action=list">Prestataires</a></li>
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
                <form action="${pageContext.request.contextPath}/prestataire?action=edit" method="post">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                    <input type="hidden" name="id" value="${prestataire.id}">
                    
                    <!-- Prestataire Info Summary -->
                    <div class="alert alert-info-modern mb-4">
                        <div class="d-flex align-items-center">
                            <div class="avatar-circle bg-success me-3" style="width: 50px; height: 50px; font-size: 1.25rem;">
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <div class="flex-grow-1">
                                <strong>Prestataire #${prestataire.id}</strong>
                                <p class="mb-0 small text-muted">
                                    Inscrit le: <c:out value="${prestataire.dateInscription}" default="-"/>
                                </p>
                            </div>
                            <div class="text-end">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-star text-warning me-1"></i>
                                    <strong>4.8</strong>
                                    <small class="text-muted ms-1">(24 avis)</small>
                                </div>
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
                                   value="${fn:escapeXml(prestataire.nom)}" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="prenom" class="form-label-modern">
                                <i class="fas fa-user me-1"></i> Prénom *
                            </label>
                            <input type="text" class="form-control-modern" id="prenom" name="prenom" 
                                   value="${fn:escapeXml(prestataire.prenom)}" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label-modern">
                                <i class="fas fa-envelope me-1"></i> Email *
                            </label>
                            <input type="email" class="form-control-modern" id="email" name="email" 
                                   value="${fn:escapeXml(prestataire.email)}" required>
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i> L'email ne peut pas être modifié
                            </small>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="telephone" class="form-label-modern">
                                <i class="fas fa-phone me-1"></i> Téléphone *
                            </label>
                            <input type="tel" class="form-control-modern" id="telephone" name="telephone" 
                                   value="${fn:escapeXml(prestataire.telephone)}" required>
                        </div>
                    </div>
                    
                    <!-- Informations professionnelles -->
                    <div class="row mt-4">
                        <div class="col-12 mb-4">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-briefcase me-2"></i> Informations professionnelles
                            </h5>
                            <hr>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="specialite" class="form-label-modern">
                                <i class="fas fa-tools me-1"></i> Spécialité *
                            </label>
                            <select class="form-select-modern" id="specialite" name="specialite" required>
                                <option value="">Sélectionner une spécialité</option>
                                <option value="menage" ${prestataire.specialite == 'menage' ? 'selected' : ''}>Ménage</option>
                                <option value="jardinage" ${prestataire.specialite == 'jardinage' ? 'selected' : ''}>Jardinage</option>
                                <option value="bricolage" ${prestataire.specialite == 'bricolage' ? 'selected' : ''}>Bricolage</option>
                                <option value="plomberie" ${prestataire.specialite == 'plomberie' ? 'selected' : ''}>Plomberie</option>
                                <option value="electricite" ${prestataire.specialite == 'electricite' ? 'selected' : ''}>Électricité</option>
                                <option value="peinture" ${prestataire.specialite == 'peinture' ? 'selected' : ''}>Peinture</option>
                                <option value="demenagement" ${prestataire.specialite == 'demenagement' ? 'selected' : ''}>Déménagement</option>
                                <option value="aide_personne" ${prestataire.specialite == 'aide_personne' ? 'selected' : ''}>Aide à la personne</option>
                            </select>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="disponibilite" class="form-label-modern">
                                <i class="fas fa-calendar-check me-1"></i> Disponibilité *
                            </label>
                            <select class="form-select-modern" id="disponibilite" name="disponibilite" required>
                                <option value="">Sélectionner</option>
                                <option value="disponible" ${prestataire.disponibilite == 'disponible' ? 'selected' : ''}>Disponible</option>
                                <option value="occupe" ${prestataire.disponibilite == 'occupe' ? 'selected' : ''}>Occupé</option>
                                <option value="temps_partiel" ${prestataire.disponibilite == 'temps_partiel' ? 'selected' : ''}>Temps partiel</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <hr class="mb-4">
                            <div class="d-flex gap-2 justify-content-between">
                                <a href="${pageContext.request.contextPath}/prestataire?action=delete&id=${prestataire.id}" 
                                   class="btn btn-danger-custom btn-delete-confirm">
                                    <i class="fas fa-trash me-2"></i> Supprimer ce prestataire
                                </a>
                                <div class="d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/prestataire?action=list" 
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
        
        <!-- Stats & Related Info -->
        <div class="card-modern mt-4">
            <div class="card-header-custom">
                <i class="fas fa-chart-bar me-2"></i> Statistiques d'activité
            </div>
            <div class="card-body-custom">
                <div class="row g-3">
                    <div class="col-md-3">
                        <div class="info-box text-center">
                            <i class="fas fa-tasks fa-2x text-primary mb-2"></i>
                            <h5 class="mb-1">45</h5>
                            <p class="text-muted small mb-0">Interventions</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box text-center">
                            <i class="fas fa-star fa-2x text-warning mb-2"></i>
                            <h5 class="mb-1">24</h5>
                            <p class="text-muted small mb-0">Avis reçus</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box text-center">
                            <i class="fas fa-check-circle fa-2x text-success mb-2"></i>
                            <h5 class="mb-1">98%</h5>
                            <p class="text-muted small mb-0">Taux de réussite</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box text-center">
                            <i class="fas fa-euro-sign fa-2x text-info mb-2"></i>
                            <h5 class="mb-1">3,450€</h5>
                            <p class="text-muted small mb-0">Revenus (ce mois)</p>
                        </div>
                    </div>
                </div>
                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/intervention?prestataireId=${prestataire.id}" 
                       class="btn btn-sm btn-outline-custom me-2">
                        <i class="fas fa-tasks me-1"></i> Voir les interventions
                    </a>
                    <a href="${pageContext.request.contextPath}/avis?prestataireId=${prestataire.id}" 
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

<jsp:include page="../shared/footer.jsp"/>
