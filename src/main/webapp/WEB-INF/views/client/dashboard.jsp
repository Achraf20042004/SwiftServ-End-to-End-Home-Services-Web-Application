<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Mon Espace Client" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-home text-gradient me-2"></i> Bienvenue, ${sessionScope.user.prenom} !</h1>
            <p class="text-muted mb-0">Gérez vos réservations et services en toute simplicité</p>
        </div>
    </div>
</div>

<!-- Quick Stats -->
<div class="row g-4 mb-4 fade-in">
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-primary">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="stat-value">12</div>
            <div class="stat-label">Réservations actives</div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-warning">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-value">3</div>
            <div class="stat-label">En attente</div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-success">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-value">45</div>
            <div class="stat-label">Services complétés</div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-info">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-value">4.8</div>
            <div class="stat-label">Satisfaction moyenne</div>
        </div>
    </div>
</div>

<!-- Service Categories -->
<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-th-large me-2"></i> Nos services disponibles
            </div>
            <div class="card-body-custom">
                <div class="row g-3">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="service-category-card">
                            <div class="service-icon bg-primary">
                                <i class="fas fa-broom"></i>
                            </div>
                            <h5>Ménage</h5>
                            <p class="text-muted small mb-2">Nettoyage complet de votre domicile</p>
                            <a href="#" class="btn btn-sm btn-outline-custom w-100">
                                <i class="fas fa-plus me-1"></i> Réserver
                            </a>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="service-category-card">
                            <div class="service-icon bg-success">
                                <i class="fas fa-seedling"></i>
                            </div>
                            <h5>Jardinage</h5>
                            <p class="text-muted small mb-2">Entretien de vos espaces verts</p>
                            <a href="#" class="btn btn-sm btn-outline-custom w-100">
                                <i class="fas fa-plus me-1"></i> Réserver
                            </a>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="service-category-card">
                            <div class="service-icon bg-warning">
                                <i class="fas fa-tools"></i>
                            </div>
                            <h5>Bricolage</h5>
                            <p class="text-muted small mb-2">Petits travaux et réparations</p>
                            <a href="#" class="btn btn-sm btn-outline-custom w-100">
                                <i class="fas fa-plus me-1"></i> Réserver
                            </a>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="service-category-card">
                            <div class="service-icon bg-info">
                                <i class="fas fa-paint-roller"></i>
                            </div>
                            <h5>Peinture</h5>
                            <p class="text-muted small mb-2">Travaux de peinture intérieure</p>
                            <a href="#" class="btn btn-sm btn-outline-custom w-100">
                                <i class="fas fa-plus me-1"></i> Réserver
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- My Reservations & Notifications -->
<div class="row g-4 fade-in">
    <!-- My Recent Reservations -->
    <div class="col-lg-8">
        <div class="card-modern">
            <div class="card-header-custom d-flex justify-content-between align-items-center">
                <span><i class="fas fa-calendar-alt me-2"></i> Mes réservations récentes</span>
                <a href="${pageContext.request.contextPath}/reservation?action=list" class="btn btn-sm btn-light">
                    Voir tout <i class="fas fa-arrow-right ms-1"></i>
                </a>
            </div>
            <div class="card-body-custom">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Service</th>
                                <th>Prestataire</th>
                                <th>Date</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-broom text-primary me-2"></i>
                                        <span>Ménage complet</span>
                                    </div>
                                </td>
                                <td>Marie Lambert</td>
                                <td><small>20/01/2025 10:00</small></td>
                                <td><span class="badge-custom badge-warning-custom">En attente</span></td>
                                <td>
                                    <button class="btn btn-sm btn-primary-custom">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-seedling text-success me-2"></i>
                                        <span>Entretien jardin</span>
                                    </div>
                                </td>
                                <td>Pierre Durand</td>
                                <td><small>18/01/2025 14:00</small></td>
                                <td><span class="badge-custom badge-success-custom">Confirmée</span></td>
                                <td>
                                    <button class="btn btn-sm btn-primary-custom">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-tools text-warning me-2"></i>
                                        <span>Réparation plomberie</span>
                                    </div>
                                </td>
                                <td>Jean Moreau</td>
                                <td><small>15/01/2025 09:00</small></td>
                                <td><span class="badge-custom badge-info-custom">Terminée</span></td>
                                <td>
                                    <button class="btn btn-sm btn-success-custom">
                                        <i class="fas fa-star"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Notifications -->
    <div class="col-lg-4">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-bell me-2"></i> Notifications
            </div>
            <div class="card-body-custom">
                <div class="notification-list">
                    <div class="notification-item">
                        <div class="notification-icon bg-success">
                            <i class="fas fa-check"></i>
                        </div>
                        <div class="notification-content">
                            <p class="mb-1"><strong>Réservation confirmée</strong></p>
                            <small class="text-muted">Votre service de ménage du 20/01</small>
                            <div><small class="text-muted">Il y a 2 heures</small></div>
                        </div>
                    </div>
                    
                    <div class="notification-item">
                        <div class="notification-icon bg-primary">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="notification-content">
                            <p class="mb-1"><strong>Nouveau message</strong></p>
                            <small class="text-muted">Pierre Durand vous a envoyé un message</small>
                            <div><small class="text-muted">Il y a 5 heures</small></div>
                        </div>
                    </div>
                    
                    <div class="notification-item">
                        <div class="notification-icon bg-warning">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="notification-content">
                            <p class="mb-1"><strong>Rappel</strong></p>
                            <small class="text-muted">Service prévu demain à 10h00</small>
                            <div><small class="text-muted">Il y a 1 jour</small></div>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/notification?action=list" class="btn btn-sm btn-outline-custom w-100">
                        Voir toutes les notifications
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .service-category-card {
        padding: 1.5rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.75rem;
        text-align: center;
        transition: all 0.3s ease;
        height: 100%;
    }
    
    .service-category-card:hover {
        border-color: var(--primary-color);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        transform: translateY(-4px);
    }
    
    .service-icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1rem;
        font-size: 1.5rem;
        color: white;
    }
    
    .service-category-card h5 {
        font-size: 1.125rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
    }
    
    .notification-list {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    
    .notification-item {
        display: flex;
        gap: 1rem;
        padding: 1rem;
        background: #f9fafb;
        border-radius: 0.5rem;
        transition: all 0.2s ease;
    }
    
    .notification-item:hover {
        background: #f3f4f6;
    }
    
    .notification-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        flex-shrink: 0;
    }
    
    .notification-content {
        flex: 1;
    }
    
    .notification-content p {
        font-size: 0.875rem;
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
