<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Mon Espace Prestataire" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-user-tie text-gradient me-2"></i> Bienvenue, ${sessionScope.user.prenom} !</h1>
            <p class="text-muted mb-0">Gérez vos interventions et suivez votre activité</p>
        </div>
    </div>
</div>

<!-- Quick Stats -->
<div class="row g-4 mb-4 fade-in">
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-primary">
                <i class="fas fa-tasks"></i>
            </div>
            <div class="stat-value">8</div>
            <div class="stat-label">Interventions actives</div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-warning">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-value">5</div>
            <div class="stat-label">En attente de réponse</div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-success">
                <i class="fas fa-check-double"></i>
            </div>
            <div class="stat-value">124</div>
            <div class="stat-label">Services complétés</div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-info">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-value">4.9</div>
            <div class="stat-label">Note moyenne</div>
        </div>
    </div>
</div>

<!-- Calendar & Pending Requests -->
<div class="row g-4 mb-4 fade-in">
    <!-- Upcoming Interventions Calendar -->
    <div class="col-lg-8">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-calendar-alt me-2"></i> Mes prochaines interventions
            </div>
            <div class="card-body-custom">
                <div class="intervention-timeline">
                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="date-box bg-primary">
                                <div class="day">20</div>
                                <div class="month">JAN</div>
                            </div>
                        </div>
                        <div class="timeline-content">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <h5 class="mb-1">Ménage complet</h5>
                                    <p class="text-muted mb-1">
                                        <i class="fas fa-user me-1"></i> Marie Dupont
                                    </p>
                                    <p class="text-muted small mb-0">
                                        <i class="fas fa-map-marker-alt me-1"></i> 15 rue de la Paix, 75002 Paris
                                    </p>
                                </div>
                                <span class="badge-custom badge-success-custom">Confirmée</span>
                            </div>
                            <div class="d-flex gap-2">
                                <button class="btn btn-sm btn-primary-custom">
                                    <i class="fas fa-play me-1"></i> Démarrer
                                </button>
                                <button class="btn btn-sm btn-outline-custom">
                                    <i class="fas fa-info-circle me-1"></i> Détails
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="date-box bg-success">
                                <div class="day">22</div>
                                <div class="month">JAN</div>
                            </div>
                        </div>
                        <div class="timeline-content">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <h5 class="mb-1">Entretien jardin</h5>
                                    <p class="text-muted mb-1">
                                        <i class="fas fa-user me-1"></i> Jean Martin
                                    </p>
                                    <p class="text-muted small mb-0">
                                        <i class="fas fa-map-marker-alt me-1"></i> 8 avenue Victor Hugo, 75016 Paris
                                    </p>
                                </div>
                                <span class="badge-custom badge-success-custom">Confirmée</span>
                            </div>
                            <div class="d-flex gap-2">
                                <button class="btn btn-sm btn-primary-custom">
                                    <i class="fas fa-play me-1"></i> Démarrer
                                </button>
                                <button class="btn btn-sm btn-outline-custom">
                                    <i class="fas fa-info-circle me-1"></i> Détails
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="date-box bg-warning">
                                <div class="day">25</div>
                                <div class="month">JAN</div>
                            </div>
                        </div>
                        <div class="timeline-content">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <h5 class="mb-1">Réparation plomberie</h5>
                                    <p class="text-muted mb-1">
                                        <i class="fas fa-user me-1"></i> Sophie Bernard
                                    </p>
                                    <p class="text-muted small mb-0">
                                        <i class="fas fa-map-marker-alt me-1"></i> 23 rue des Lilas, 75011 Paris
                                    </p>
                                </div>
                                <span class="badge-custom badge-warning-custom">En attente</span>
                            </div>
                            <div class="d-flex gap-2">
                                <button class="btn btn-sm btn-success-custom">
                                    <i class="fas fa-check me-1"></i> Accepter
                                </button>
                                <button class="btn btn-sm btn-danger-custom">
                                    <i class="fas fa-times me-1"></i> Refuser
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/intervention?action=list" class="btn btn-outline-custom">
                        Voir toutes mes interventions <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Sidebar: Stats & Recent Reviews -->
    <div class="col-lg-4">
        <!-- Performance This Month -->
        <div class="card-modern mb-4">
            <div class="card-header-custom">
                <i class="fas fa-chart-line me-2"></i> Performance ce mois
            </div>
            <div class="card-body-custom">
                <div class="performance-item">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-muted">Services réalisés</span>
                        <strong class="text-primary">18</strong>
                    </div>
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-primary" style="width: 75%"></div>
                    </div>
                </div>
                
                <div class="performance-item mt-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-muted">Revenus du mois</span>
                        <strong class="text-success">2,450€</strong>
                    </div>
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-success" style="width: 82%"></div>
                    </div>
                </div>
                
                <div class="performance-item mt-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-muted">Taux d'acceptation</span>
                        <strong class="text-info">95%</strong>
                    </div>
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-info" style="width: 95%"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Reviews -->
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-star me-2"></i> Avis récents
            </div>
            <div class="card-body-custom">
                <div class="review-item">
                    <div class="d-flex justify-content-between mb-2">
                        <strong>Marie Dupont</strong>
                        <div class="stars">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                        </div>
                    </div>
                    <p class="text-muted small mb-1">"Excellent travail, très professionnel et ponctuel!"</p>
                    <small class="text-muted">Il y a 2 jours</small>
                </div>
                
                <hr class="my-3">
                
                <div class="review-item">
                    <div class="d-flex justify-content-between mb-2">
                        <strong>Jean Martin</strong>
                        <div class="stars">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="far fa-star text-warning"></i>
                        </div>
                    </div>
                    <p class="text-muted small mb-1">"Bon service, quelques petits détails à améliorer."</p>
                    <small class="text-muted">Il y a 5 jours</small>
                </div>
                
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/avis?action=list" class="btn btn-sm btn-outline-custom w-100">
                        Tous les avis
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .intervention-timeline {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }
    
    .timeline-item {
        display: flex;
        gap: 1.5rem;
        padding: 1.5rem;
        background: #f9fafb;
        border-radius: 0.75rem;
        border-left: 4px solid var(--primary-color);
    }
    
    .timeline-date {
        flex-shrink: 0;
    }
    
    .date-box {
        width: 60px;
        padding: 0.75rem;
        border-radius: 0.5rem;
        text-align: center;
        color: white;
    }
    
    .date-box .day {
        font-size: 1.5rem;
        font-weight: 700;
        line-height: 1;
    }
    
    .date-box .month {
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }
    
    .timeline-content {
        flex: 1;
    }
    
    .timeline-content h5 {
        font-size: 1.125rem;
        font-weight: 600;
    }
    
    .performance-item .progress {
        border-radius: 4px;
        background-color: #e5e7eb;
    }
    
    .review-item {
        padding: 0.75rem 0;
    }
    
    .stars {
        display: flex;
        gap: 2px;
    }
    
    .stars i {
        font-size: 0.875rem;
    }
</style>

<jsp:include page="../common/footer.jsp"/>
