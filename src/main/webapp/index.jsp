<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services à Domicile - Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8rem 0;
            clip-path: polygon(0 0, 100% 0, 100% 85%, 0 100%);
        }
        .feature-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            border-radius: 15px;
            padding: 2rem;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }
        .stats-section {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 4rem 0;
        }
        .stat-box {
            text-align: center;
            padding: 2rem;
        }
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            color: #667eea;
        }
    </style>
</head>
<body>
    
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-custom fixed-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-home-lg-alt"></i>
                Services Domicile
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt"></i> Connexion
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/register">
                            <i class="fas fa-user-plus"></i> Inscription
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 text-center text-lg-start">
                    <h1 class="display-3 fw-bold mb-4">
                        Services à Domicile Professionnels
                    </h1>
                    <p class="lead mb-5">
                        Trouvez les meilleurs prestataires pour tous vos besoins à domicile. 
                        Simple, rapide et sécurisé.
                    </p>
                    <div class="d-grid d-sm-flex gap-3 justify-content-center justify-content-lg-start">
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-light btn-lg">
                            <i class="fas fa-rocket"></i> Commencer maintenant
                        </a>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-sign-in-alt"></i> Se connecter
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 mt-5 mt-lg-0">
                    <div class="text-center">
                        <i class="fas fa-handshake" style="font-size: 15rem; opacity: 0.2;"></i>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Pourquoi nous choisir ?</h2>
                <p class="lead text-muted">Des services de qualité pour simplifier votre quotidien</p>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="feature-icon bg-gradient-primary text-white mx-auto">
                            <i class="fas fa-users"></i>
                        </div>
                        <h4 class="text-center mb-3">Prestataires Qualifiés</h4>
                        <p class="text-center text-muted">
                            Tous nos prestataires sont vérifiés et qualifiés pour vous garantir 
                            un service de qualité.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="feature-icon bg-success text-white mx-auto">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h4 class="text-center mb-3">Réservation Facile</h4>
                        <p class="text-center text-muted">
                            Réservez vos services en quelques clics et gérez vos rendez-vous 
                            facilement depuis votre espace.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="feature-icon bg-warning text-white mx-auto">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4 class="text-center mb-3">Paiement Sécurisé</h4>
                        <p class="text-center text-muted">
                            Vos transactions sont sécurisées et vos données personnelles 
                            sont protégées.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="feature-icon bg-info text-white mx-auto">
                            <i class="fas fa-star"></i>
                        </div>
                        <h4 class="text-center mb-3">Système d'Avis</h4>
                        <p class="text-center text-muted">
                            Consultez les avis des autres clients et partagez votre expérience 
                            pour aider la communauté.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="feature-icon bg-danger text-white mx-auto">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h4 class="text-center mb-3">Support 24/7</h4>
                        <p class="text-center text-muted">
                            Notre équipe est disponible 24h/24 et 7j/7 pour répondre à toutes 
                            vos questions.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="feature-icon bg-primary text-white mx-auto">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h4 class="text-center mb-3">Application Mobile</h4>
                        <p class="text-center text-muted">
                            Accédez à tous nos services depuis votre smartphone, où que vous soyez.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">5000+</div>
                        <div class="text-muted">Clients satisfaits</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">500+</div>
                        <div class="text-muted">Prestataires qualifiés</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">50+</div>
                        <div class="text-muted">Types de services</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-box">
                        <div class="stat-number">98%</div>
                        <div class="text-muted">Taux de satisfaction</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5">
        <div class="container">
            <div class="card shadow-lg border-0" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <div class="card-body p-5 text-center text-white">
                    <h2 class="display-5 fw-bold mb-4">Prêt à commencer ?</h2>
                    <p class="lead mb-4">
                        Rejoignez des milliers de clients satisfaits et découvrez nos services dès aujourd'hui
                    </p>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-light btn-lg">
                        <i class="fas fa-user-plus"></i> Créer un compte gratuitement
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer-custom mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0 text-muted">
                        &copy; 2025 Services à Domicile. Tous droits réservés.
                    </p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <a href="#" class="text-muted text-decoration-none mx-2">Mentions légales</a>
                    <a href="#" class="text-muted text-decoration-none mx-2">Confidentialité</a>
                    <a href="#" class="text-muted text-decoration-none mx-2">Contact</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
