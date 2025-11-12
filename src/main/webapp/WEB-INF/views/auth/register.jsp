<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Services à Domicile</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .register-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .register-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }
        
        .register-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 2rem;
            text-align: center;
            color: white;
        }
        
        .register-header i {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }
        
        .register-header h2 {
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .register-body {
            padding: 2rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }
        
        .form-control, .form-select {
            border: 2px solid #e5e7eb;
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .role-selector {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .role-option {
            position: relative;
        }
        
        .role-option input[type="radio"] {
            position: absolute;
            opacity: 0;
        }
        
        .role-option label {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1.5rem;
            border: 2px solid #e5e7eb;
            border-radius: 0.75rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }
        
        .role-option label i {
            font-size: 2.5rem;
            margin-bottom: 0.75rem;
            color: #667eea;
        }
        
        .role-option label .role-name {
            font-weight: 600;
            color: #111827;
            margin-bottom: 0.25rem;
        }
        
        .role-option label .role-desc {
            font-size: 0.75rem;
            color: #6b7280;
        }
        
        .role-option input[type="radio"]:checked + label {
            border-color: #667eea;
            background-color: #f0f4ff;
        }
        
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.875rem;
            font-weight: 600;
            font-size: 1rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .login-link a {
            color: #667eea;
            font-weight: 600;
            text-decoration: none;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .alert {
            border-radius: 0.5rem;
            border: none;
        }
    </style>
</head>
<body>

<div class="register-container">
    <div class="register-card">
        <div class="register-header">
            <i class="fas fa-user-plus"></i>
            <h2>Créer un compte</h2>
            <p class="mb-0">Rejoignez notre plateforme</p>
        </div>
        
        <div class="register-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger d-flex align-items-center mb-4" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <div>${error}</div>
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/register" method="post">
                
                <!-- Sélection du rôle -->
                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-user-tag me-1"></i> Je suis un(e)
                    </label>
                    <div class="role-selector">
                        <div class="role-option">
                            <input type="radio" id="roleClient" name="role" value="client" checked>
                            <label for="roleClient">
                                <i class="fas fa-user"></i>
                                <span class="role-name">Client</span>
                                <span class="role-desc">Je cherche des services</span>
                            </label>
                        </div>
                        <div class="role-option">
                            <input type="radio" id="rolePrestataire" name="role" value="prestataire">
                            <label for="rolePrestataire">
                                <i class="fas fa-user-tie"></i>
                                <span class="role-name">Prestataire</span>
                                <span class="role-desc">J'offre des services</span>
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- Informations personnelles -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="nom" class="form-label">
                            <i class="fas fa-user me-1"></i> Nom
                        </label>
                        <input type="text" class="form-control" id="nom" name="nom" 
                               placeholder="Votre nom" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="prenom" class="form-label">
                            <i class="fas fa-user me-1"></i> Prénom
                        </label>
                        <input type="text" class="form-control" id="prenom" name="prenom" 
                               placeholder="Votre prénom" required>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope me-1"></i> Adresse email
                    </label>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="votre@email.com" required>
                </div>
                
                <div class="mb-3">
                    <label for="telephone" class="form-label">
                        <i class="fas fa-phone me-1"></i> Téléphone
                    </label>
                    <input type="tel" class="form-control" id="telephone" name="telephone" 
                           placeholder="0600000000" required>
                </div>
                
                <div class="mb-4">
                    <label for="motDePasse" class="form-label">
                        <i class="fas fa-lock me-1"></i> Mot de passe
                    </label>
                    <input type="password" class="form-control" id="motDePasse" name="motDePasse" 
                           placeholder="Minimum 6 caractères" minlength="6" required>
                    <small class="text-muted">
                        <i class="fas fa-info-circle me-1"></i> Au moins 6 caractères
                    </small>
                </div>
                
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-register">
                        <i class="fas fa-user-plus me-2"></i> Créer mon compte
                    </button>
                </div>
            </form>
            
            <div class="login-link">
                <p class="mb-0">
                    Vous avez déjà un compte ? 
                    <a href="${pageContext.request.contextPath}/login">
                        <i class="fas fa-sign-in-alt me-1"></i> Se connecter
                    </a>
                </p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
