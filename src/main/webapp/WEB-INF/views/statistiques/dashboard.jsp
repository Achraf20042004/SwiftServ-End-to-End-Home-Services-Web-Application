<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Statistiques" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid">
    <!-- Page Header -->
    <div class="page-header fade-in">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1>
                    <i class="fas fa-chart-line text-gradient"></i>
                    Statistiques & Analyses
                </h1>
                <p class="text-muted mb-0">Vue d'ensemble des performances de la plateforme</p>
            </div>
            <div>
                <button class="btn btn-outline-primary" onclick="window.print()">
                    <i class="fas fa-print"></i> Imprimer
                </button>
            </div>
        </div>
    </div>

    <!-- Statistiques Globales -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-primary">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value">${stats.totalClients}</div>
                <div class="stat-label">Clients Inscrits</div>
                <div class="mt-3">
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-primary" role="progressbar" style="width: 75%"></div>
                    </div>
                    <small class="text-muted mt-1 d-block">+12% ce mois</small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-success">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div class="stat-value">${stats.totalPrestataires}</div>
                <div class="stat-label">Prestataires Actifs</div>
                <div class="mt-3">
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-success" role="progressbar" style="width: 60%"></div>
                    </div>
                    <small class="text-muted mt-1 d-block">+8% ce mois</small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-warning">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-value">${stats.totalReservations}</div>
                <div class="stat-label">Réservations Totales</div>
                <div class="mt-3">
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-warning" role="progressbar" style="width: 85%"></div>
                    </div>
                    <small class="text-muted mt-1 d-block">+23% ce mois</small>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-info">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-value">94.5%</div>
                <div class="stat-label">Taux de Satisfaction</div>
                <div class="mt-3">
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-info" role="progressbar" style="width: 94%"></div>
                    </div>
                    <small class="text-muted mt-1 d-block">Moyenne des avis</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Graphiques et Analyses -->
    <div class="row g-4 mb-4">
        <!-- Graphique des réservations -->
        <div class="col-lg-8">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-chart-bar"></i> Évolution des Réservations
                </div>
                <div class="card-body-custom">
                    <canvas id="reservationsChart" height="80"></canvas>
                </div>
            </div>
        </div>

        <!-- Top Prestataires -->
        <div class="col-lg-4">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-trophy"></i> Top Prestataires
                </div>
                <div class="card-body-custom">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge bg-warning me-2">🥇</span>
                                    <strong>Thomas Lefebvre</strong>
                                    <div class="small text-muted">Plomberie</div>
                                </div>
                                <div class="text-end">
                                    <div class="text-warning">
                                        <i class="fas fa-star"></i> 4.9
                                    </div>
                                    <small class="text-muted">156 services</small>
                                </div>
                            </div>
                        </div>

                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge bg-secondary me-2">🥈</span>
                                    <strong>Emma Roux</strong>
                                    <div class="small text-muted">Électricité</div>
                                </div>
                                <div class="text-end">
                                    <div class="text-warning">
                                        <i class="fas fa-star"></i> 4.8
                                    </div>
                                    <small class="text-muted">142 services</small>
                                </div>
                            </div>
                        </div>

                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge bg-warning me-2">🥉</span>
                                    <strong>Lucas Simon</strong>
                                    <div class="small text-muted">Ménage</div>
                                </div>
                                <div class="text-end">
                                    <div class="text-warning">
                                        <i class="fas fa-star"></i> 4.7
                                    </div>
                                    <small class="text-muted">128 services</small>
                                </div>
                            </div>
                        </div>

                        <div class="list-group-item border-0 px-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge bg-light me-2">4</span>
                                    <strong>Camille Laurent</strong>
                                    <div class="small text-muted">Jardinage</div>
                                </div>
                                <div class="text-end">
                                    <div class="text-warning">
                                        <i class="fas fa-star"></i> 4.6
                                    </div>
                                    <small class="text-muted">95 services</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Services les plus demandés et Statistiques détaillées -->
    <div class="row g-4 mb-4">
        <!-- Services populaires -->
        <div class="col-lg-6">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-fire"></i> Services les Plus Demandés
                </div>
                <div class="card-body-custom">
                    <canvas id="servicesChart" height="120"></canvas>
                </div>
            </div>
        </div>

        <!-- Répartition par statut -->
        <div class="col-lg-6">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-chart-pie"></i> Répartition des Réservations
                </div>
                <div class="card-body-custom">
                    <canvas id="statusChart" height="120"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistiques détaillées -->
    <div class="row g-4">
        <div class="col-lg-4">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-clock"></i> Statistiques Temporelles
                </div>
                <div class="card-body-custom">
                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Réservations aujourd'hui</span>
                            <strong class="text-primary">23</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Réservations cette semaine</span>
                            <strong class="text-success">87</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Réservations ce mois</span>
                            <strong class="text-warning">342</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Moyenne par jour</span>
                            <strong class="text-info">11.4</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-euro-sign"></i> Revenus
                </div>
                <div class="card-body-custom">
                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Revenus aujourd'hui</span>
                            <strong class="text-primary">€1,245</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Revenus cette semaine</span>
                            <strong class="text-success">€4,890</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Revenus ce mois</span>
                            <strong class="text-warning">€18,650</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Panier moyen</span>
                            <strong class="text-info">€54.50</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-percentage"></i> Taux de Conversion
                </div>
                <div class="card-body-custom">
                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Visiteurs → Inscriptions</span>
                            <strong class="text-primary">12.3%</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Inscriptions → Réservations</span>
                            <strong class="text-success">45.8%</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Taux d'annulation</span>
                            <strong class="text-warning">3.2%</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Taux de satisfaction</span>
                            <strong class="text-info">94.5%</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
// Configuration des couleurs
const colors = {
    primary: 'rgba(79, 70, 229, 1)',
    primaryLight: 'rgba(79, 70, 229, 0.1)',
    success: 'rgba(16, 185, 129, 1)',
    successLight: 'rgba(16, 185, 129, 0.1)',
    warning: 'rgba(245, 158, 11, 1)',
    warningLight: 'rgba(245, 158, 11, 0.1)',
    info: 'rgba(59, 130, 246, 1)',
    infoLight: 'rgba(59, 130, 246, 0.1)',
    danger: 'rgba(239, 68, 68, 1)',
    dangerLight: 'rgba(239, 68, 68, 0.1)'
};

// Graphique des réservations
const ctxReservations = document.getElementById('reservationsChart').getContext('2d');
new Chart(ctxReservations, {
    type: 'line',
    data: {
        labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'],
        datasets: [{
            label: 'Réservations 2025',
            data: [45, 52, 67, 73, 89, 95, 102, 98, 115, 128, 142, 156],
            borderColor: colors.primary,
            backgroundColor: colors.primaryLight,
            tension: 0.4,
            fill: true
        }, {
            label: 'Réservations 2024',
            data: [38, 45, 52, 58, 65, 72, 78, 82, 88, 95, 102, 108],
            borderColor: colors.success,
            backgroundColor: colors.successLight,
            tension: 0.4,
            fill: true
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                display: true,
                position: 'top'
            }
        },
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

// Graphique des services populaires
const ctxServices = document.getElementById('servicesChart').getContext('2d');
new Chart(ctxServices, {
    type: 'bar',
    data: {
        labels: ['Plomberie', 'Électricité', 'Ménage', 'Jardinage', 'Peinture', 'Climatisation'],
        datasets: [{
            label: 'Nombre de réservations',
            data: [156, 142, 128, 95, 78, 62],
            backgroundColor: [
                colors.primary,
                colors.success,
                colors.warning,
                colors.info,
                colors.danger,
                'rgba(168, 85, 247, 1)'
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                display: false
            }
        },
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

// Graphique du statut des réservations
const ctxStatus = document.getElementById('statusChart').getContext('2d');
new Chart(ctxStatus, {
    type: 'doughnut',
    data: {
        labels: ['Terminées', 'En cours', 'En attente', 'Annulées'],
        datasets: [{
            data: [68, 18, 11, 3],
            backgroundColor: [
                colors.success,
                colors.info,
                colors.warning,
                colors.danger
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                display: true,
                position: 'bottom'
            }
        }
    }
});
</script>

<jsp:include page="../shared/footer.jsp"/>
