<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Administrateur" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-user-edit text-gradient me-2"></i> Modifier l'administrateur</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=list">Administrateurs</a></li>
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
                <i class="fas fa-user-shield me-2"></i> Modifier les informations
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/admin?action=edit" method="post">
                    <input type="hidden" name="id" value="${admin.id}">
                    
                    <!-- Admin Info -->
                    <div class="alert alert-info-modern mb-4">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <strong><i class="fas fa-info-circle me-2"></i> Administrateur #${admin.id}</strong>
                                <p class="mb-0 small text-muted mt-1">
                                    Inscrit le: <c:out value="${admin.dateInscription}" default="-"/>
                                </p>
                            </div>
                            <c:if test="${admin.superAdmin}">
                                <span class="badge-custom badge-warning-custom">
                                    <i class="fas fa-crown me-1"></i> Super Admin
                                </span>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- Personal Information -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-id-card me-2"></i> Informations personnelles
                        </h5>
                        <hr>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nom" class="form-label-modern">
                                    <i class="fas fa-user me-1"></i> Nom *
                                </label>
                                <input type="text" class="form-control-modern" id="nom" name="nom" 
                                       value="${admin.nom}" required>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="prenom" class="form-label-modern">
                                    <i class="fas fa-user me-1"></i> Prénom *
                                </label>
                                <input type="text" class="form-control-modern" id="prenom" name="prenom" 
                                       value="${admin.prenom}" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label-modern">
                                    <i class="fas fa-envelope me-1"></i> Email *
                                </label>
                                <input type="email" class="form-control-modern" id="email" name="email" 
                                       value="${admin.email}" required>
                                <small class="text-muted">
                                    <i class="fas fa-lock me-1"></i> L'email ne peut pas être modifié
                                </small>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="telephone" class="form-label-modern">
                                    <i class="fas fa-phone me-1"></i> Téléphone *
                                </label>
                                <input type="tel" class="form-control-modern" id="telephone" name="telephone" 
                                       value="${admin.telephone}" required>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Security -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-lock me-2"></i> Sécurité
                        </h5>
                        <hr>
                        
                        <div class="alert alert-warning-modern mb-3">
                            <i class="fas fa-info-circle me-2"></i>
                            Laissez vide pour conserver le mot de passe actuel
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="newPassword" class="form-label-modern">
                                    <i class="fas fa-key me-1"></i> Nouveau mot de passe
                                </label>
                                <input type="password" class="form-control-modern" id="newPassword" name="newPassword" 
                                       placeholder="Laisser vide pour ne pas modifier" minlength="8">
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="confirmPassword" class="form-label-modern">
                                    <i class="fas fa-check-circle me-1"></i> Confirmer le mot de passe
                                </label>
                                <input type="password" class="form-control-modern" id="confirmPassword" 
                                       placeholder="Répéter le nouveau mot de passe">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Access Level -->
                    <c:if test="${sessionScope.user.superAdmin && !admin.superAdmin}">
                        <div class="mb-4">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-shield-alt me-2"></i> Niveau d'accès
                            </h5>
                            <hr>
                            
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="makeSuperAdmin" name="makeSuperAdmin">
                                <label class="form-check-label" for="makeSuperAdmin">
                                    <i class="fas fa-crown text-warning me-1"></i>
                                    <strong>Promouvoir au rang de Super Admin</strong>
                                </label>
                            </div>
                            <small class="text-muted">
                                <i class="fas fa-exclamation-triangle me-1"></i>
                                Cette action donnera un accès complet au système
                            </small>
                        </div>
                    </c:if>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-between">
                        <c:if test="${!admin.superAdmin}">
                            <a href="${pageContext.request.contextPath}/admin?action=delete&id=${admin.id}" 
                               class="btn btn-danger-custom btn-delete-confirm">
                                <i class="fas fa-trash me-2"></i> Supprimer cet administrateur
                            </a>
                        </c:if>
                        <div class="d-flex gap-2 ${admin.superAdmin ? 'w-100 justify-content-end' : ''}">
                            <a href="${pageContext.request.contextPath}/admin?action=list" 
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
        
        <!-- Activity Log -->
        <div class="card-modern mt-4">
            <div class="card-header-custom">
                <i class="fas fa-history me-2"></i> Activité récente
            </div>
            <div class="card-body-custom">
                <div class="activity-timeline">
                    <div class="activity-item">
                        <div class="activity-icon bg-success">
                            <i class="fas fa-sign-in-alt"></i>
                        </div>
                        <div class="activity-content">
                            <strong>Connexion réussie</strong>
                            <p class="text-muted small mb-0">Il y a 2 heures - IP: 192.168.1.100</p>
                        </div>
                    </div>
                    
                    <div class="activity-item">
                        <div class="activity-icon bg-primary">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="activity-content">
                            <strong>Profil modifié</strong>
                            <p class="text-muted small mb-0">Hier à 14:30</p>
                        </div>
                    </div>
                    
                    <div class="activity-item">
                        <div class="activity-icon bg-info">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div class="activity-content">
                            <strong>Compte créé</strong>
                            <p class="text-muted small mb-0">
                                <c:out value="${admin.dateInscription}" default="Date inconnue"/>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .activity-timeline {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    
    .activity-item {
        display: flex;
        gap: 1rem;
        align-items: flex-start;
    }
    
    .activity-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        flex-shrink: 0;
    }
    
    .form-check-input:checked {
        background-color: var(--primary-color);
        border-color: var(--primary-color);
    }
</style>

<script>
    // Password confirmation
    document.querySelector('form').addEventListener('submit', function(e) {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        if (newPassword && newPassword !== confirmPassword) {
            e.preventDefault();
            alert('Les mots de passe ne correspondent pas');
        }
    });
</script>

<jsp:include page="../includes/footer.jsp"/>
