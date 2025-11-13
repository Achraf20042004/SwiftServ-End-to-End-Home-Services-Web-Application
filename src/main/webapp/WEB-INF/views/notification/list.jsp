<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Notifications" scope="request"/>
<jsp:include page="../includes/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h1><i class="fas fa-bell text-gradient me-2"></i> Centre de notifications</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                        <li class="breadcrumb-item active">Notifications</li>
                    </ol>
                </nav>
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-outline-custom" onclick="markAllAsRead()">
                    <i class="fas fa-check-double me-2"></i> Tout marquer comme lu
                </button>
                <a href="${pageContext.request.contextPath}/notification?action=add" class="btn btn-primary-custom">
                    <i class="fas fa-plus me-2"></i> Nouvelle notification
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Filter Tabs -->
<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-body-custom">
                <ul class="nav nav-pills" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" href="?filter=all">
                            <i class="fas fa-inbox me-1"></i> Toutes <span class="badge bg-light text-dark ms-1">24</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?filter=unread">
                            <i class="fas fa-envelope me-1"></i> Non lues <span class="badge bg-primary ms-1">8</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?filter=important">
                            <i class="fas fa-star me-1"></i> Importantes <span class="badge bg-warning ms-1">3</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?filter=archived">
                            <i class="fas fa-archive me-1"></i> Archivées
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Notifications List -->
<div class="row fade-in">
    <div class="col-12">
        <div class="card-modern">
            <div class="card-body-custom p-0">
                <div class="notifications-list">
                    <c:forEach var="notification" items="${notifications}">
                        <div class="notification-item ${notification.statut == 'NON_LUE' ? 'unread' : ''}">
                            <div class="notification-icon ${notification.type}">
                                <c:choose>
                                    <c:when test="${notification.type == 'RESERVATION'}">
                                        <i class="fas fa-calendar-check"></i>
                                    </c:when>
                                    <c:when test="${notification.type == 'INTERVENTION'}">
                                        <i class="fas fa-tools"></i>
                                    </c:when>
                                    <c:when test="${notification.type == 'RECLAMATION'}">
                                        <i class="fas fa-exclamation-triangle"></i>
                                    </c:when>
                                    <c:when test="${notification.type == 'AVIS'}">
                                        <i class="fas fa-star"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-info-circle"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="notification-content flex-grow-1">
                                <div class="d-flex justify-content-between align-items-start mb-1">
                                    <h6 class="mb-0">${notification.titre}</h6>
                                    <small class="text-muted">
                                        <i class="fas fa-clock me-1"></i>
                                        <c:out value="${notification.dateEnvoi}" default="À l'instant"/>
                                    </small>
                                </div>
                                <p class="notification-message mb-2">${notification.message}</p>
                                <div class="notification-meta">
                                    <span class="badge-custom ${notification.type == 'RECLAMATION' ? 'badge-danger-custom' : notification.type == 'INTERVENTION' ? 'badge-warning-custom' : 'badge-info-custom'}">
                                        ${notification.type}
                                    </span>
                                </div>
                            </div>
                            
                            <div class="notification-actions">
                                <c:if test="${notification.statut == 'NON_LUE'}">
                                    <button class="btn btn-sm btn-light" onclick="markAsRead(${notification.id})" title="Marquer comme lu">
                                        <i class="fas fa-check"></i>
                                    </button>
                                </c:if>
                                <button class="btn btn-sm btn-light" onclick="archiveNotification(${notification.id})" title="Archiver">
                                    <i class="fas fa-archive"></i>
                                </button>
                                <a href="${pageContext.request.contextPath}/notification?action=delete&id=${notification.id}" 
                                   class="btn btn-sm btn-light btn-delete-confirm" title="Supprimer">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty notifications}">
                        <div class="text-center py-5">
                            <i class="fas fa-bell-slash fa-3x text-muted mb-3 d-block"></i>
                            <h5 class="text-muted mb-2">Aucune notification</h5>
                            <p class="text-muted mb-0">Vous êtes à jour !</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .notifications-list {
        display: flex;
        flex-direction: column;
    }
    
    .notification-item {
        display: flex;
        gap: 1rem;
        padding: 1.5rem;
        border-bottom: 1px solid #f3f4f6;
        transition: all 0.3s ease;
        background: white;
    }
    
    .notification-item:hover {
        background: #f9fafb;
    }
    
    .notification-item:last-child {
        border-bottom: none;
    }
    
    .notification-item.unread {
        background: #eff6ff;
        border-left: 4px solid var(--primary-color);
    }
    
    .notification-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
        color: white;
        flex-shrink: 0;
    }
    
    .notification-icon.RESERVATION {
        background: linear-gradient(135deg, #10b981, #34d399);
    }
    
    .notification-icon.INTERVENTION {
        background: linear-gradient(135deg, #f59e0b, #fbbf24);
    }
    
    .notification-icon.RECLAMATION {
        background: linear-gradient(135deg, #ef4444, #f87171);
    }
    
    .notification-icon.AVIS {
        background: linear-gradient(135deg, #8b5cf6, #a78bfa);
    }
    
    .notification-icon.SYSTEME {
        background: linear-gradient(135deg, #4f46e5, #6366f1);
    }
    
    .notification-message {
        color: var(--text-secondary);
        font-size: 0.875rem;
        line-height: 1.5;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    
    .notification-actions {
        display: flex;
        gap: 0.5rem;
        flex-shrink: 0;
    }
    
    .nav-pills .nav-link {
        color: var(--text-secondary);
        border-radius: 0.5rem;
        padding: 0.5rem 1rem;
        margin-right: 0.5rem;
    }
    
    .nav-pills .nav-link:hover {
        background-color: var(--light-gray);
    }
    
    .nav-pills .nav-link.active {
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
        color: white;
    }
</style>

<script>
    function markAsRead(id) {
        // Simulate AJAX call
        fetch('${pageContext.request.contextPath}/notification?action=markRead&id=' + id)
            .then(response => {
                if (response.ok) {
                    location.reload();
                }
            });
    }
    
    function markAllAsRead() {
        if (confirm('Marquer toutes les notifications comme lues ?')) {
            fetch('${pageContext.request.contextPath}/notification?action=markAllRead')
                .then(response => {
                    if (response.ok) {
                        location.reload();
                    }
                });
        }
    }
    
    function archiveNotification(id) {
        fetch('${pageContext.request.contextPath}/notification?action=archive&id=' + id)
            .then(response => {
                if (response.ok) {
                    location.reload();
                }
            });
    }
</script>

<jsp:include page="../includes/footer.jsp"/>
