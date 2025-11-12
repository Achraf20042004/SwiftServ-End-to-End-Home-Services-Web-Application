<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Dashboard Admin" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-chart-line text-gradient me-2"></i> Tableau de bord administrateur</h1>
            <p class="text-muted mb-0">
                <i class="fas fa-calendar me-1"></i> 
                <script>document.write(new Date().toLocaleDateString('fr-FR', {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'}));</script>
            </p>
        </div>
    </div>
</div>

<!-- Statistics Cards -->
<div class="row g-4 mb-4 fade-in">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-primary">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-value">256</div>
            <div class="stat-label">Clients actifs</div>
            <small class="text-success">
                <i class="fas fa-arrow-up me-1"></i> +12% ce mois
            </small>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-success">
                <i class="fas fa-user-tie"></i>
            </div>
            <div class="stat-value">89</div>
            <div class="stat-label">Prestataires</div>
            <small class="text-success">
                <i class="fas fa-arrow-up me-1"></i> +8% ce mois
            </small>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-warning">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="stat-value">1,234</div>
            <div class="stat-label">Réservations</div>
            <small class="text-info">
                <i class="fas fa-clock me-1"></i> 45 en attente
            </small>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon bg-info">
                <i class="fas fa-euro-sign"></i>
            </div>
            <div class="stat-value">45,678€</div>
            <div class="stat-label">Chiffre d'affaires</div>
            <small class="text-success">
                <i class="fas fa-arrow-up me-1"></i> +18% ce mois
            </small>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-bolt me-2"></i> Actions rapides
            </div>
            <div class="card-body-custom">
                <div class="row g-3">
                    <div class="col-md-3 col-sm-6">
                        <a href="${pageContext.request.contextPath}/client?action=add" class="btn btn-outline-custom w-100">
                            <i class="fas fa-user-plus me-2"></i> Nouveau client
                        </a>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <a href="${pageContext.request.contextPath}/prestataire?action=add" class="btn btn-outline-custom w-100">
                            <i class="fas fa-user-tie me-2"></i> Nouveau prestataire
                        </a>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <a href="${pageContext.request.contextPath}/service?action=add" class="btn btn-outline-custom w-100">
                            <i class="fas fa-briefcase me-2"></i> Nouveau service
                        </a>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <a href="${pageContext.request.contextPath}/categorie?action=add" class="btn btn-outline-custom w-100">
                            <i class="fas fa-tags me-2"></i> Nouvelle catégorie
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Recent Activities & Pending Items -->
<div class="row g-4 fade-in">
    <!-- Pending Reservations -->
    <div class="col-lg-6">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-clock me-2"></i> Réservations en attente
            </div>
            <div class="card-body-custom">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Client</th>
                                <th>Service</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle bg-primary me-2">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <span>Marie Dupont</span>
                                    </div>
                                </td>
                                <td>Ménage</td>
                                <td><small class="text-muted">15/01/2025</small></td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-primary-custom">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle bg-success me-2">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <span>Jean Martin</span>
                                    </div>
                                </td>
                                <td>Jardinage</td>
                                <td><small class="text-muted">16/01/2025</small></td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-primary-custom">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/reservation?action=list" class="btn btn-sm btn-outline-custom">
                        Voir toutes les réservations <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Recent Complaints -->
    <div class="col-lg-6">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-exclamation-triangle me-2"></i> Réclamations récentes
            </div>
            <div class="card-body-custom">
                <div class="list-group list-group-flush">
                    <div class="list-group-item border-0 px-0">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="flex-grow-1">
                                <h6 class="mb-1">Retard de l'intervention</h6>
                                <p class="text-muted mb-1 small">Par Sophie Bernard</p>
                                <span class="badge-custom badge-warning-custom">En cours</span>
                            </div>
                            <small class="text-muted">Il y a 2h</small>
                        </div>
                    </div>
                    <div class="list-group-item border-0 px-0">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="flex-grow-1">
                                <h6 class="mb-1">Service non conforme</h6>
                                <p class="text-muted mb-1 small">Par Pierre Dubois</p>
                                <span class="badge-custom badge-danger-custom">Nouvelle</span>
                            </div>
                            <small class="text-muted">Il y a 5h</small>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/reclamation?action=list" class="btn btn-sm btn-outline-custom">
                        Toutes les réclamations <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .avatar-circle {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 0.875rem;
    }
</style>

<jsp:include page="../includes/footer.jsp"/>
