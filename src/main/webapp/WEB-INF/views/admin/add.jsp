<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouvel Administrateur" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-user-plus text-gradient me-2"></i> Ajouter un nouvel administrateur</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=list">Administrateurs</a></li>
                    <li class="breadcrumb-item active">Nouveau</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-user-shield me-2"></i> Informations de l'administrateur
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/admin?action=add" method="post">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                    
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
                                       placeholder="Nom de famille" required>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="prenom" class="form-label-modern">
                                    <i class="fas fa-user me-1"></i> Prénom *
                                </label>
                                <input type="text" class="form-control-modern" id="prenom" name="prenom" 
                                       placeholder="Prénom" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label-modern">
                                    <i class="fas fa-envelope me-1"></i> Email *
                                </label>
                                <input type="email" class="form-control-modern" id="email" name="email" 
                                       placeholder="admin@example.com" required>
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i> Utilisé pour la connexion
                                </small>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="telephone" class="form-label-modern">
                                    <i class="fas fa-phone me-1"></i> Téléphone *
                                </label>
                                <input type="tel" class="form-control-modern" id="telephone" name="telephone" 
                                       placeholder="0600000000" required>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Security -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-lock me-2"></i> Sécurité et accès
                        </h5>
                        <hr>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="motDePasse" class="form-label-modern">
                                    <i class="fas fa-key me-1"></i> Mot de passe *
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control-modern" id="motDePasse" name="motDePasse" 
                                           placeholder="Min. 8 caractères" minlength="8" required>
                                    <button class="btn btn-outline-custom" type="button" onclick="togglePassword()">
                                        <i class="fas fa-eye" id="toggleIcon"></i>
                                    </button>
                                </div>
                                <div class="password-strength mt-2">
                                    <div class="strength-bar">
                                        <div class="strength-fill" id="strengthBar"></div>
                                    </div>
                                    <small class="text-muted" id="strengthText">Force du mot de passe</small>
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="confirmPassword" class="form-label-modern">
                                    <i class="fas fa-check-circle me-1"></i> Confirmer le mot de passe *
                                </label>
                                <input type="password" class="form-control-modern" id="confirmPassword" 
                                       name="confirmPassword" placeholder="Répéter le mot de passe" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label-modern">
                                <i class="fas fa-shield-alt me-1"></i> Niveau d'accès *
                            </label>
                            <div class="access-level-selector">
                                <input type="radio" id="level-admin" name="accessLevel" value="ADMIN" checked>
                                <label for="level-admin" class="access-level-card">
                                    <i class="fas fa-user-shield fa-2x mb-2 text-primary"></i>
                                    <strong>Administrateur</strong>
                                    <small class="text-muted">Accès standard</small>
                                </label>
                                
                                <input type="radio" id="level-super" name="accessLevel" value="SUPER_ADMIN">
                                <label for="level-super" class="access-level-card">
                                    <i class="fas fa-crown fa-2x mb-2 text-warning"></i>
                                    <strong>Super Admin</strong>
                                    <small class="text-muted">Accès complet</small>
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Permissions -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-key me-2"></i> Permissions
                        </h5>
                        <hr>
                        
                        <div class="permissions-grid">
                            <div class="permission-item">
                                <input type="checkbox" id="perm-users" name="permissions" value="MANAGE_USERS" checked>
                                <label for="perm-users">
                                    <i class="fas fa-users text-primary me-2"></i>
                                    <strong>Gérer les utilisateurs</strong>
                                </label>
                            </div>
                            
                            <div class="permission-item">
                                <input type="checkbox" id="perm-services" name="permissions" value="MANAGE_SERVICES" checked>
                                <label for="perm-services">
                                    <i class="fas fa-briefcase text-info me-2"></i>
                                    <strong>Gérer les services</strong>
                                </label>
                            </div>
                            
                            <div class="permission-item">
                                <input type="checkbox" id="perm-reservations" name="permissions" value="MANAGE_RESERVATIONS" checked>
                                <label for="perm-reservations">
                                    <i class="fas fa-calendar text-success me-2"></i>
                                    <strong>Gérer les réservations</strong>
                                </label>
                            </div>
                            
                            <div class="permission-item">
                                <input type="checkbox" id="perm-stats" name="permissions" value="VIEW_STATISTICS">
                                <label for="perm-stats">
                                    <i class="fas fa-chart-bar text-warning me-2"></i>
                                    <strong>Voir les statistiques</strong>
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Security Alert -->
                    <div class="alert alert-warning-modern mb-4">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <strong>Important:</strong> Un email de bienvenue avec les identifiants sera envoyé à l'administrateur.
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/admin?action=list" 
                           class="btn btn-outline-custom">
                            <i class="fas fa-times me-2"></i> Annuler
                        </a>
                        <button type="reset" class="btn btn-outline-custom">
                            <i class="fas fa-redo me-2"></i> Réinitialiser
                        </button>
                        <button type="submit" class="btn btn-success-custom">
                            <i class="fas fa-save me-2"></i> Créer l'administrateur
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .access-level-selector {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
    }
    
    .access-level-selector input {
        display: none;
    }
    
    .access-level-card {
        padding: 1.5rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.75rem;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    
    .access-level-card:hover {
        border-color: var(--primary-color);
        background: #f9fafb;
    }
    
    .access-level-selector input:checked + .access-level-card {
        border-color: var(--primary-color);
        background: linear-gradient(135deg, rgba(79, 70, 229, 0.1), rgba(99, 102, 241, 0.05));
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.15);
    }
    
    .password-strength {
        margin-top: 0.5rem;
    }
    
    .strength-bar {
        height: 4px;
        background: #e5e7eb;
        border-radius: 2px;
        overflow: hidden;
    }
    
    .strength-fill {
        height: 100%;
        width: 0%;
        transition: all 0.3s ease;
        background: #ef4444;
    }
    
    .permissions-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
    }
    
    .permission-item {
        padding: 1rem;
        background: #f9fafb;
        border-radius: 0.5rem;
        display: flex;
        align-items: center;
    }
    
    .permission-item input {
        margin-right: 0.75rem;
        width: 18px;
        height: 18px;
    }
    
    .permission-item label {
        margin: 0;
        cursor: pointer;
    }
</style>

<script>
    function togglePassword() {
        const passwordField = document.getElementById('motDePasse');
        const toggleIcon = document.getElementById('toggleIcon');
        
        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            toggleIcon.className = 'fas fa-eye-slash';
        } else {
            passwordField.type = 'password';
            toggleIcon.className = 'fas fa-eye';
        }
    }
    
    // Password strength checker
    document.getElementById('motDePasse').addEventListener('input', function(e) {
        const password = e.target.value;
        const strengthBar = document.getElementById('strengthBar');
        const strengthText = document.getElementById('strengthText');
        
        let strength = 0;
        if (password.length >= 8) strength++;
        if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength++;
        if (password.match(/[0-9]/)) strength++;
        if (password.match(/[^a-zA-Z0-9]/)) strength++;
        
        const width = (strength / 4) * 100;
        strengthBar.style.width = width + '%';
        
        if (strength <= 1) {
            strengthBar.style.background = '#ef4444';
            strengthText.textContent = 'Faible';
        } else if (strength === 2) {
            strengthBar.style.background = '#f59e0b';
            strengthText.textContent = 'Moyen';
        } else if (strength === 3) {
            strengthBar.style.background = '#3b82f6';
            strengthText.textContent = 'Bon';
        } else {
            strengthBar.style.background = '#10b981';
            strengthText.textContent = 'Excellent';
        }
    });
    
    // Password confirmation
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.getElementById('motDePasse').value;
        const confirm = document.getElementById('confirmPassword').value;
        
        if (password !== confirm) {
            e.preventDefault();
            alert('Les mots de passe ne correspondent pas');
        }
    });
</script>

<jsp:include page="../shared/footer.jsp"/>
