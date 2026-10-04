<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Services à Domicile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }
        .register-card {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        .register-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .register-body {
            padding: 2rem;
        }
        .role-selector {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .role-option {
            flex: 1;
            padding: 1.5rem;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .role-option:hover {
            border-color: #667eea;
            background: #f8f9ff;
        }
        .role-option.selected {
            border-color: #667eea;
            background: #f8f9ff;
        }
        .role-option input[type="radio"] {
            display: none;
        }
        .role-option i {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: #667eea;
        }
    </style>
</head>
<body>

<div class="register-card">
    <div class="register-header">
        <i class="fas fa-user-plus fa-3x mb-3"></i>
        <h1 class="mb-0">Créer un compte</h1>
        <p class="mb-0 mt-2">Rejoignez notre plateforme dès maintenant</p>
    </div>
    
    <div class="register-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/register" id="registerForm">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
            
            <!-- Sélection du rôle -->
            <div class="mb-4">
                <label class="form-label fw-bold">
                    <i class="fas fa-user-tag"></i> Je m'inscris en tant que :
                </label>
                <div class="role-selector">
                    <label class="role-option" for="roleClient">
                        <input type="radio" name="role" id="roleClient" value="client" required>
                        <div>
                            <i class="fas fa-user"></i>
                            <div class="fw-bold">Client</div>
                            <small class="text-muted">Réserver des services</small>
                        </div>
                    </label>
                    
                    <label class="role-option" for="rolePrestataire">
                        <input type="radio" name="role" id="rolePrestataire" value="prestataire">
                        <div>
                            <i class="fas fa-user-tie"></i>
                            <div class="fw-bold">Prestataire</div>
                            <small class="text-muted">Offrir des services</small>
                        </div>
                    </label>
                </div>
            </div>
            
            <!-- Informations personnelles -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="nom" class="form-label">
                        <i class="fas fa-user"></i> Nom *
                    </label>
                    <input type="text" class="form-control" id="nom" name="nom" required>
                </div>
                
                <div class="col-md-6 mb-3">
                    <label for="prenom" class="form-label">
                        <i class="fas fa-user"></i> Prénom *
                    </label>
                    <input type="text" class="form-control" id="prenom" name="prenom" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="email" class="form-label">
                    <i class="fas fa-envelope"></i> Email *
                </label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            
            <div class="mb-3">
                <label for="telephone" class="form-label">
                    <i class="fas fa-phone"></i> Téléphone
                </label>
                <input type="tel" class="form-control" id="telephone" name="telephone" 
                       placeholder="06 12 34 56 78">
            </div>
            
            <div class="mb-4">
                <label for="motDePasse" class="form-label">
                    <i class="fas fa-lock"></i> Mot de passe *
                </label>
                <input type="password" class="form-control" id="motDePasse" name="motDePasse" 
                       minlength="6" required>
                <small class="text-muted">Au moins 6 caractères</small>
            </div>
            
            <div class="form-check mb-4">
                <input class="form-check-input" type="checkbox" id="acceptConditions" required>
                <label class="form-check-label" for="acceptConditions">
                    J'accepte les <a href="#" class="text-decoration-none">conditions d'utilisation</a>
                </label>
            </div>
            
            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="fas fa-user-plus"></i> Créer mon compte
                </button>
            </div>
            
            <div class="text-center">
                <p class="mb-0">
                    Vous avez déjà un compte ? 
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-bold">
                        Connectez-vous
                    </a>
                </p>
            </div>
        </form>
        
        <hr class="my-4">
        
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/" class="text-muted text-decoration-none">
                <i class="fas fa-arrow-left"></i> Retour à l'accueil
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Gérer la sélection visuelle des rôles
document.querySelectorAll('.role-option').forEach(option => {
    option.addEventListener('click', function() {
        document.querySelectorAll('.role-option').forEach(o => o.classList.remove('selected'));
        this.classList.add('selected');
    });
});

// Sélectionner "client" par défaut
document.getElementById('roleClient').checked = true;
document.querySelector('label[for="roleClient"]').classList.add('selected');
</script>
</body>
</html>
