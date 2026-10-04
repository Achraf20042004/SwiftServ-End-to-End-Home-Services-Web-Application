<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Notifications" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid px-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="notif-header">
                <div class="notif-header-content">
                    <div class="notif-header-text">
                        <h1>
                            <i class="fas fa-bell"></i>
                            Centre de Notifications
                        </h1>
                        <p>Restez informé de toutes vos activités</p>
                    </div>
                    <c:if test="${sessionScope.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/notification?action=add" class="btn-add-notif">
                            <i class="fas fa-plus"></i>
                            <span>Nouvelle notification</span>
                        </a>
                    </c:if>
                </div>
                <div class="notif-header-decoration">
                    <div class="floating-bell bell-1"><i class="fas fa-bell"></i></div>
                    <div class="floating-bell bell-2"><i class="fas fa-bell"></i></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="notif-stat-card stat-total">
                <div class="stat-card-icon">
                    <i class="fas fa-bell"></i>
                </div>
                <div class="stat-card-info">
                    <div class="stat-card-value">${totalNotifications != null ? totalNotifications : 0}</div>
                    <div class="stat-card-label">Total Notifications</div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="notif-stat-card stat-unread">
                <div class="stat-card-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="stat-card-info">
                    <div class="stat-card-value">${totalNotifications != null ? totalNotifications : 0}</div>
                    <div class="stat-card-label">Non lues</div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="notif-stat-card stat-today">
                <div class="stat-card-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stat-card-info">
                    <div class="stat-card-value">0</div>
                    <div class="stat-card-label">Aujourd'hui</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Section Title -->
    <div class="row mb-3">
        <div class="col-12">
            <div class="section-header">
                <h3><i class="fas fa-list-ul me-2"></i>Toutes les notifications</h3>
            </div>
        </div>
    </div>

    <!-- Notifications List -->
    <div class="row">
        <div class="col-12">
            <div class="notif-list-container">
                <c:forEach var="notification" items="${notifications}" varStatus="status">
                    <div class="notif-card" style="animation-delay: ${status.index * 0.1}s">
                        <div class="notif-card-indicator"></div>
                        <div class="notif-card-icon">
                            <i class="fas fa-info-circle"></i>
                        </div>
                        <div class="notif-card-content">
                            <p class="notif-message">${fn:escapeXml(notification.message)}</p>
                            <div class="notif-meta">
                                <span class="notif-time">
                                    <i class="fas fa-clock"></i>
                                    <fmt:formatDate value="${notification.dateNotification}" pattern="dd MMM yyyy à HH:mm"/>
                                </span>
                                <c:if test="${sessionScope.role == 'admin'}">
                                    <span class="notif-client">
                                        <i class="fas fa-user"></i>
                                        ${fn:escapeXml(notification.client.prenom)} ${fn:escapeXml(notification.client.nom)}
                                    </span>
                                </c:if>
                            </div>
                        </div>
                        <div class="notif-card-actions">
                            <a href="${pageContext.request.contextPath}/notification?action=delete&id=${notification.id}" 
                               class="btn-delete btn-delete-confirm" title="Supprimer">
                                <i class="fas fa-trash"></i>
                            </a>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty notifications}">
                    <div class="empty-notif">
                        <div class="empty-icon">
                            <i class="fas fa-bell-slash"></i>
                        </div>
                        <h4>Aucune notification</h4>
                        <p>Vous êtes à jour ! Aucune nouvelle notification pour le moment.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Section Conseils (affichée quand peu de notifications) -->
    <c:if test="${totalNotifications == null || totalNotifications < 3}">
        <div class="row mt-4">
            <div class="col-12">
                <div class="tips-section">
                    <h5><i class="fas fa-lightbulb me-2"></i>Le saviez-vous ?</h5>
                    <div class="tips-grid">
                        <div class="tip-card">
                            <div class="tip-icon"><i class="fas fa-calendar-check"></i></div>
                            <div class="tip-content">
                                <h6>Gérez vos réservations</h6>
                                <p>Suivez l'état de vos réservations en temps réel</p>
                            </div>
                        </div>
                        <div class="tip-card">
                            <div class="tip-icon"><i class="fas fa-star"></i></div>
                            <div class="tip-content">
                                <h6>Laissez un avis</h6>
                                <p>Partagez votre expérience avec la communauté</p>
                            </div>
                        </div>
                        <div class="tip-card">
                            <div class="tip-icon"><i class="fas fa-headset"></i></div>
                            <div class="tip-content">
                                <h6>Besoin d'aide ?</h6>
                                <p>Notre équipe est disponible pour vous aider</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

</div>

<style>
    /* Header */
    .notif-header {
        background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
        border-radius: 1.5rem;
        padding: 2.5rem;
        position: relative;
        overflow: hidden;
        color: white;
    }
    
    .notif-header-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: relative;
        z-index: 2;
    }
    
    .notif-header-text h1 {
        font-size: 2rem;
        font-weight: 800;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    
    .notif-header-text p {
        opacity: 0.9;
        margin: 0;
        font-size: 1rem;
    }
    
    .btn-add-notif {
        background: rgba(255, 255, 255, 0.2);
        backdrop-filter: blur(10px);
        border: 2px solid rgba(255, 255, 255, 0.3);
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 0.75rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    
    .btn-add-notif:hover {
        background: white;
        color: #1d4ed8;
        transform: translateY(-2px);
    }
    
    .notif-header-decoration {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        width: 40%;
    }
    
    .floating-bell {
        position: absolute;
        color: rgba(255, 255, 255, 0.15);
        animation: ring 2s ease-in-out infinite;
    }
    
    .bell-1 { top: 20%; right: 15%; font-size: 3rem; }
    .bell-2 { top: 60%; right: 25%; font-size: 2rem; animation-delay: 0.5s; }
    
    @keyframes ring {
        0%, 100% { transform: rotate(0deg); }
        25% { transform: rotate(15deg); }
        75% { transform: rotate(-15deg); }
    }
    
    /* Stat Cards */
    .notif-stat-card {
        background: white;
        border-radius: 1.25rem;
        padding: 1.5rem;
        display: flex;
        align-items: center;
        gap: 1rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
    }
    
    .notif-stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
    }
    
    .stat-card-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
        color: white;
    }
    
    .stat-total .stat-card-icon { background: linear-gradient(135deg, #3b82f6, #60a5fa); }
    .stat-unread .stat-card-icon { background: linear-gradient(135deg, #f59e0b, #fbbf24); }
    .stat-today .stat-card-icon { background: linear-gradient(135deg, #10b981, #34d399); }
    
    .stat-card-value {
        font-size: 1.75rem;
        font-weight: 800;
        color: #1f2937;
        line-height: 1;
    }
    
    .stat-card-label {
        font-size: 0.8rem;
        color: #6b7280;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }
    
    /* Section Header */
    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .section-header h3 {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1f2937;
        margin: 0;
    }
    
    /* Notification Cards */
    .notif-list-container {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    
    .notif-card {
        background: white;
        border-radius: 1rem;
        padding: 1.25rem 1.5rem;
        display: flex;
        align-items: center;
        gap: 1rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        animation: fadeInUp 0.5s ease forwards;
        opacity: 0;
    }
    
    .notif-card:hover {
        transform: translateX(5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .notif-card-indicator {
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 4px;
        background: linear-gradient(180deg, #3b82f6, #60a5fa);
    }
    
    .notif-card-icon {
        width: 45px;
        height: 45px;
        border-radius: 12px;
        background: linear-gradient(135deg, #3b82f6, #60a5fa);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1rem;
        flex-shrink: 0;
    }
    
    .notif-card-content {
        flex: 1;
    }
    
    .notif-message {
        margin: 0 0 0.5rem;
        font-size: 0.95rem;
        color: #1f2937;
        line-height: 1.5;
    }
    
    .notif-meta {
        display: flex;
        gap: 1.5rem;
        font-size: 0.8rem;
        color: #6b7280;
    }
    
    .notif-meta i {
        margin-right: 0.25rem;
        color: #3b82f6;
    }
    
    .notif-card-actions {
        display: flex;
        gap: 0.5rem;
    }
    
    .btn-delete {
        width: 36px;
        height: 36px;
        border-radius: 8px;
        border: 1px solid #fee2e2;
        background: #fef2f2;
        color: #ef4444;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
    }
    
    .btn-delete:hover {
        background: #ef4444;
        border-color: #ef4444;
        color: white;
    }
    
    /* Empty State */
    .empty-notif {
        text-align: center;
        padding: 4rem 2rem;
        background: white;
        border-radius: 1.5rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    }
    
    .empty-icon {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(29, 78, 216, 0.1));
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem;
        font-size: 2.5rem;
        color: #3b82f6;
    }
    
    .empty-notif h4 {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 0.5rem;
    }
    
    .empty-notif p {
        color: #6b7280;
        max-width: 400px;
        margin: 0 auto;
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .notif-header-content {
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
        }
        
        .notif-header-text h1 {
            font-size: 1.5rem;
        }
        
        .btn-add-notif {
            width: 100%;
            justify-content: center;
        }
        
        .notif-meta {
            flex-direction: column;
            gap: 0.25rem;
        }
        /* Tips Section */
.tips-section {
    background: linear-gradient(135deg, rgba(59, 130, 246, 0.05), rgba(29, 78, 216, 0.05));
    border-radius: 1rem;
    padding: 1.5rem;
    border: 1px solid rgba(59, 130, 246, 0.1);
}

.tips-section h5 {
    font-size: 1rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1rem;
}

.tips-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
}

.tip-card {
    background: white;
    border-radius: 0.75rem;
    padding: 1rem;
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.tip-icon {
    width: 36px;
    height: 36px;
    border-radius: 8px;
    background: linear-gradient(135deg, #3b82f6, #60a5fa);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 0.875rem;
    flex-shrink: 0;
}

.tip-content h6 {
    margin: 0 0 0.25rem;
    font-size: 0.875rem;
    font-weight: 600;
    color: #1f2937;
}

.tip-content p {
    margin: 0;
    font-size: 0.75rem;
    color: #6b7280;
}
    }
 /* Tips Section */
.tips-section {
    background: linear-gradient(135deg, rgba(59, 130, 246, 0.05), rgba(29, 78, 216, 0.05));
    border-radius: 1rem;
    padding: 1.5rem;
    border: 1px solid rgba(59, 130, 246, 0.1);
}

.tips-section h5 {
    font-size: 1rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1rem;
}

.tips-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
}

.tip-card {
    background: white;
    border-radius: 0.75rem;
    padding: 1rem;
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
}

.tip-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.tip-icon {
    width: 36px;
    height: 36px;
    border-radius: 8px;
    background: linear-gradient(135deg, #3b82f6, #60a5fa);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 0.875rem;
    flex-shrink: 0;
}

.tip-content h6 {
    margin: 0 0 0.25rem;
    font-size: 0.875rem;
    font-weight: 600;
    color: #1f2937;
}

.tip-content p {
    margin: 0;
    font-size: 0.75rem;
    color: #6b7280;
    line-height: 1.4;
}

@media (max-width: 768px) {
    .tips-grid {
        grid-template-columns: 1fr;
    }
}
</style>

<jsp:include page="../shared/footer.jsp"/>