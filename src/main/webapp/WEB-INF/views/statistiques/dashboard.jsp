<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
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
                <div class="stat-icon bg-primary"><i class="fas fa-users"></i></div>
                <div class="stat-value">${stats.totalClients}</div>
                <div class="stat-label">Clients Inscrits</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-success"><i class="fas fa-user-tie"></i></div>
                <div class="stat-value">${stats.totalPrestataires}</div>
                <div class="stat-label">Prestataires Actifs</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-warning"><i class="fas fa-calendar-check"></i></div>
                <div class="stat-value">${stats.totalReservations}</div>
                <div class="stat-label">Réservations Totales</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="stat-card fade-in">
                <div class="stat-icon bg-info"><i class="fas fa-chart-line"></i></div>
                <div class="stat-value">${String.format("%.1f", stats.averageRating * 20)}%</div>
                <div class="stat-label">Taux de Satisfaction</div>
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
                        <c:forEach var="p" items="${stats.topPrestataires}" varStatus="i">
                            <div class="list-group-item border-0 px-0">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="badge ${i.index == 0 ? 'bg-warning' : i.index == 1 ? 'bg-secondary' : i.index == 2 ? 'bg-warning' : 'bg-light'} me-2">
                                            ${i.index == 0 ? '🥇' : i.index == 1 ? '🥈' : i.index == 2 ? '🥉' : i.count}
                                        </span>
                                        <strong>${p[1]} ${p[0]}</strong>
                                        <div class="small text-muted">${p[2] != null ? p[2] : 'N/A'}</div>
                                    </div>
                                    <div class="text-end">
                                        <div class="text-warning"><i class="fas fa-star"></i> ${String.format("%.1f", p[4])}</div>
                                        <small class="text-muted">${p[3]} services</small>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
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
                            <strong class="text-primary">${stats.reservationsToday}</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Réservations cette semaine</span>
                            <strong class="text-success">${stats.reservationsThisWeek}</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Réservations ce mois</span>
                            <strong class="text-warning">${stats.reservationsThisMonth}</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Moyenne par jour</span>
                            <strong class="text-info">${String.format("%.1f", stats.reservationsThisMonth / 30.0)}</strong>
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
                            <strong class="text-primary">€${String.format("%.2f", stats.revenueToday)}</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Revenus cette semaine</span>
                            <strong class="text-success">€${String.format("%.2f", stats.revenueThisWeek)}</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Revenus ce mois</span>
                            <strong class="text-warning">€${String.format("%.2f", stats.revenueThisMonth)}</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Panier moyen</span>
                            <strong class="text-info">€${String.format("%.2f", stats.panierMoyen)}</strong>
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
                            <span class="text-muted">Réservations terminées</span>
                            <strong class="text-primary">${stats.totalReservations > 0 ? String.format("%.1f", (stats.reservationsTerminees * 100.0 / stats.totalReservations)) : 0}%</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Réservations en cours</span>
                            <strong class="text-success">${stats.totalReservations > 0 ? String.format("%.1f", (stats.reservationsEnCours * 100.0 / stats.totalReservations)) : 0}%</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Taux d'annulation</span>
                            <strong class="text-warning">${stats.totalReservations > 0 ? String.format("%.1f", (stats.reservationsAnnulees * 100.0 / stats.totalReservations)) : 0}%</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Taux de satisfaction</span>
                            <strong class="text-info">${String.format("%.1f", stats.averageRating * 20)}%</strong>
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
const colors = {
    primary: 'rgba(79, 70, 229, 1)',
    primaryLight: 'rgba(79, 70, 229, 0.1)',
    success: 'rgba(16, 185, 129, 1)',
    successLight: 'rgba(16, 185, 129, 0.1)',
    warning: 'rgba(245, 158, 11, 1)',
    info: 'rgba(59, 130, 246, 1)',
    danger: 'rgba(239, 68, 68, 1)'
};

// Graphique des réservations
new Chart(document.getElementById('reservationsChart').getContext('2d'), {
    type: 'line',
    data: {
        labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'],
        datasets: [{
            label: 'Réservations ${stats.anneeCourante}',
            data: [<c:forEach var="n" items="${stats.reservationsAnneeCourante}" varStatus="i">${n}<c:if test="${!i.last}">,</c:if></c:forEach>],
            borderColor: colors.primary,
            backgroundColor: colors.primaryLight,
            tension: 0.4,
            fill: true
        }, {
            label: 'Réservations ${stats.anneeCourante - 1}',
            data: [<c:forEach var="n" items="${stats.reservationsAnneePrecedente}" varStatus="i">${n}<c:if test="${!i.last}">,</c:if></c:forEach>],
            borderColor: colors.success,
            backgroundColor: colors.successLight,
            tension: 0.4,
            fill: true
        }]
    },
    options: { responsive: true, maintainAspectRatio: true }
});


// Graphique des services
new Chart(document.getElementById('servicesChart').getContext('2d'), {
    type: 'bar',
    data: {
        labels: [<c:forEach var="s" items="${stats.topServices}" varStatus="i">'${fn:escapeXml(s[0])}'<c:if test="${!i.last}">,</c:if></c:forEach>],
        datasets: [{
            data: [<c:forEach var="s" items="${stats.topServices}" varStatus="i">${s[1]}<c:if test="${!i.last}">,</c:if></c:forEach>],
            backgroundColor: [colors.primary, colors.success, colors.warning, colors.info, colors.danger, 'rgba(168, 85, 247, 1)']
        }]
    },
    options: { responsive: true, plugins: { legend: { display: false } } }
});

// Graphique des statuts
new Chart(document.getElementById('statusChart').getContext('2d'), {
    type: 'doughnut',
    data: {
        labels: ['Terminées', 'En cours', 'En attente', 'Annulées'],
        datasets: [{
            data: [${stats.reservationsTerminees}, ${stats.reservationsEnCours}, ${stats.reservationsEnAttente}, ${stats.reservationsAnnulees}],
            backgroundColor: [colors.success, colors.info, colors.warning, colors.danger]
        }]
    },
    options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
});
</script>

<jsp:include page="../shared/footer.jsp"/>