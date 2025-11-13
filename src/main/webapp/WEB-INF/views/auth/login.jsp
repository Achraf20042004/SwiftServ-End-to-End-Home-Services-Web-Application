<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Services à Domicile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            max-width: 450px;
            width: 100%;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .login-header {
            background: white;
            padding: 2rem;
            border-radius: 20px 20px 0 0;
            text-align: center;
        }
        .login-header h1 {
            color: #667eea;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .login-body {
            background: white;
            padding: 2rem;
            border-radius: 0 0 20px 20px;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.75rem;
            font-weight: 600;
            transition: transform 0.3s ease;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <i class="fas fa-user-circle fa-4x mb-3 text-primary"></i>
        <h1>Connexion</h1>
        <p class="text-muted mb-0">Accédez à votre espace personnel</p>
    </div>
    
    <div class="login-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="mb-3">
                <label for="email" class="form-label">
                    <i class="fas fa-envelope"></i> Email
                </label>
                <input type="email" 
                       class="form-control form-control-lg" 
                       id="email" 
                       name="email" 
                       placeholder="votre.email@exemple.com"
                       required 
                       autofocus>
            </div>
            
            <div class="mb-4">
                <label for="motDePasse" class="form-label">
                    <i class="fas fa-lock"></i> Mot de passe
                </label>
                <input type="password" 
                       class="form-control form-control-lg" 
                       id="motDePasse" 
                       name="motDePasse" 
                       placeholder="••••••••"
                       required>
            </div>
            
            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary btn-lg btn-login">
                    <i class="fas fa-sign-in-alt"></i> Se connecter
                </button>
            </div>
            
            <div class="text-center">
                <p class="mb-0">
                    Pas encore de compte ? 
                    <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-bold">
                        Inscrivez-vous
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
        
        <!-- Comptes de test -->
        <div class="mt-4 p-3 bg-light rounded">
            <small class="text-muted d-block mb-2"><strong>Comptes de test :</strong></small>
            <small class="text-muted d-block">👨‍💼 Admin: admin@services.com / admin123</small>
            <small class="text-muted d-block">👤 Client: jean.martin@email.com / client123</small>
            <small class="text-muted d-block">🔧 Prestataire: thomas.lefebvre@prestataire.com / presta123</small>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
