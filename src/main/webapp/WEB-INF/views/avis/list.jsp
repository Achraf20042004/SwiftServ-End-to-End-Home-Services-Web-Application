<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Gestion des Avis" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid px-4">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="avis-header">
                <div class="avis-header-content">
                    <div class="avis-header-text">
                        <h1>
                            <i class="fas fa-star"></i>
                            <c:choose>
                                <c:when test="${sessionScope.role == 'client'}">Mes Avis</c:when>
                                <c:when test="${sessionScope.role == 'prestataire'}">Avis Reçus</c:when>
                                <c:otherwise>Gestion des Avis</c:otherwise>
                            </c:choose>
                        </h1>
                        <p>Consultez et gérez tous vos avis en un seul endroit</p>
                    </div>
                    <c:if test="${sessionScope.role == 'client'}">
                        <a href="${pageContext.request.contextPath}/avis?action=add" class="btn-add-avis">
                            <i class="fas fa-plus"></i>
                            <span>Nouvel avis</span>
                        </a>
                    </c:if>
                </div>
                <div class="avis-header-decoration">
                    <div class="floating-star star-1"><i class="fas fa-star"></i></div>
                    <div class="floating-star star-2"><i class="fas fa-star"></i></div>
                    <div class="floating-star star-3"><i class="fas fa-star"></i></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="avis-stat-card stat-note">
                <div class="stat-card-bg"></div>
                <div class="stat-card-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-card-info">
                    <div class="stat-card-value">
                        <fmt:formatNumber value="${noteMoyenne != null ? noteMoyenne : 0}" maxFractionDigits="1"/>
                    </div>
                    <div class="stat-card-label">Note Moyenne</div>
                    <div class="stat-card-stars">
                        <c:forEach begin="1" end="5" var="i">
                            <i class="fas fa-star ${i <= noteMoyenne ? 'active' : ''}"></i>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6">
            <div class="avis-stat-card stat-total">
                <div class="stat-card-bg"></div>
                <div class="stat-card-icon">
                    <i class="fas fa-comments"></i>
                </div>
                <div class="stat-card-info">
                    <div class="stat-card-value">${totalAvis != null ? totalAvis : 0}</div>
                    <div class="stat-card-label">Total Avis</div>
                    <div class="stat-card-trend">
                        <i class="fas fa-arrow-up"></i> Tous les temps
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6">
            <div class="avis-stat-card stat-satisfaction">
                <div class="stat-card-bg"></div>
                <div class="stat-card-icon">
                    <i class="fas fa-heart"></i>
                </div>
                <div class="stat-card-info">
                    <div class="stat-card-value">
                        <fmt:formatNumber value="${tauxSatisfaction != null ? tauxSatisfaction : 0}" maxFractionDigits="0"/>%
                    </div>
                    <div class="stat-card-label">Satisfaction</div>
                    <div class="stat-card-progress">
                        <div class="progress-fill" style="width: ${tauxSatisfaction != null ? tauxSatisfaction : 0}%"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6">
            <div class="avis-stat-card stat-month">
                <div class="stat-card-bg"></div>
                <div class="stat-card-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-card-info">
                    <div class="stat-card-value">${totalAvis != null ? totalAvis : 0}</div>
                    <div class="stat-card-label">Ce Mois</div>
                    <div class="stat-card-trend">
                        <i class="fas fa-chart-line"></i> En progression
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Section Title -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="section-header">
                <h3><i class="fas fa-list-ul me-2"></i>Liste des Avis</h3>
                <div class="section-actions">
                    <button class="btn-filter active"><i class="fas fa-th-large"></i></button>
                    <button class="btn-filter"><i class="fas fa-list"></i></button>
                </div>
            </div>
        </div>
    </div>

    <!-- Reviews Grid -->
    <div class="row g-4">
        <c:forEach var="avis" items="${avisList}" varStatus="status">
            <div class="col-lg-6 col-xl-4">
                <div class="avis-card" style="animation-delay: ${status.index * 0.1}s">
                    <div class="avis-card-header">
                        <div class="avis-user">
                            <div class="avis-avatar">
                                <span>${avis.client.prenom.charAt(0)}${avis.client.nom.charAt(0)}</span>
                                <div class="avatar-status"></div>
                            </div>
                            <div class="avis-user-info">
                                <h5>${fn:escapeXml(avis.client.prenom)} ${fn:escapeXml(avis.client.nom)}</h5>
                                <span class="avis-badge">Client vérifié</span>
                            </div>
                        </div>
                        <div class="dropdown">
                            <button class="btn-menu" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-ellipsis-h"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <c:if test="${sessionScope.role == 'client' || sessionScope.role == 'admin'}">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/avis?action=edit&id=${avis.id}">
                                            <i class="fas fa-edit"></i> Modifier
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item text-danger btn-delete-confirm" 
                                           href="${pageContext.request.contextPath}/avis?action=delete&id=${avis.id}">
                                            <i class="fas fa-trash"></i> Supprimer
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="avis-rating">
                        <div class="stars">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star ${i <= avis.note ? 'active' : ''}"></i>
                            </c:forEach>
                        </div>
                        <span class="rating-text">${avis.note}/5</span>
                    </div>
                    
                    <div class="avis-content">
                        <p>"${fn:escapeXml(avis.commentaire)}"</p>
                    </div>
                    
                    <div class="avis-footer">
                        <div class="avis-prestataire">
                            <i class="fas fa-user-tie"></i>
                            <span>${fn:escapeXml(avis.prestataire.prenom)} ${fn:escapeXml(avis.prestataire.nom)}</span>
                        </div>
                        <div class="avis-actions">
                            <button class="btn-like"><i class="fas fa-thumbs-up"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty avisList}">
            <div class="col-12">
                <div class="empty-avis">
                    <div class="empty-icon">
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <h4>Aucun avis pour le moment</h4>
                    <p>
                        <c:choose>
                            <c:when test="${sessionScope.role == 'client'}">
                                Partagez votre expérience en laissant votre premier avis !
                            </c:when>
                            <c:when test="${sessionScope.role == 'prestataire'}">
                                Vos clients n'ont pas encore laissé d'avis.
                            </c:when>
                            <c:otherwise>
                                Aucun avis n'a été enregistré dans le système.
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${sessionScope.role == 'client'}">
                        <a href="${pageContext.request.contextPath}/avis?action=add" class="btn-add-first">
                            <i class="fas fa-plus me-2"></i> Ajouter mon premier avis
                        </a>
                    </c:if>
                </div>
            </div>
        </c:if>
    </div>
</div>

<style>
    /* Header */
    .avis-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 1.5rem;
        padding: 2.5rem;
        position: relative;
        overflow: hidden;
        color: white;
    }
    
    .avis-header-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: relative;
        z-index: 2;
    }
    
    .avis-header-text h1 {
        font-size: 2rem;
        font-weight: 800;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    
    .avis-header-text p {
        opacity: 0.9;
        margin: 0;
        font-size: 1rem;
    }
    
    .btn-add-avis {
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
    
    .btn-add-avis:hover {
        background: white;
        color: #764ba2;
        transform: translateY(-2px);
    }
    
    .avis-header-decoration {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        width: 40%;
    }
    
    .floating-star {
        position: absolute;
        color: rgba(255, 255, 255, 0.2);
        animation: float 3s ease-in-out infinite;
    }
    
    .star-1 { top: 20%; right: 20%; font-size: 2rem; animation-delay: 0s; }
    .star-2 { top: 50%; right: 10%; font-size: 1.5rem; animation-delay: 0.5s; }
    .star-3 { top: 70%; right: 30%; font-size: 1rem; animation-delay: 1s; }
    
    @keyframes float {
        0%, 100% { transform: translateY(0) rotate(0deg); }
        50% { transform: translateY(-10px) rotate(10deg); }
    }
    
    /* Stat Cards */
    .avis-stat-card {
        background: white;
        border-radius: 1.25rem;
        padding: 1.5rem;
        position: relative;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
    }
    
    .avis-stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
    }
    
    .stat-card-bg {
        position: absolute;
        top: -50%;
        right: -30%;
        width: 150px;
        height: 150px;
        border-radius: 50%;
        opacity: 0.1;
    }
    
    .stat-note .stat-card-bg { background: #f59e0b; }
    .stat-total .stat-card-bg { background: #4f46e5; }
    .stat-satisfaction .stat-card-bg { background: #10b981; }
    .stat-month .stat-card-bg { background: #3b82f6; }
    
    .stat-card-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
        color: white;
        margin-bottom: 1rem;
    }
    
    .stat-note .stat-card-icon { background: linear-gradient(135deg, #f59e0b, #fbbf24); }
    .stat-total .stat-card-icon { background: linear-gradient(135deg, #4f46e5, #6366f1); }
    .stat-satisfaction .stat-card-icon { background: linear-gradient(135deg, #10b981, #34d399); }
    .stat-month .stat-card-icon { background: linear-gradient(135deg, #3b82f6, #60a5fa); }
    
    .stat-card-value {
        font-size: 2rem;
        font-weight: 800;
        color: #1f2937;
    }
    
    .stat-card-label {
        font-size: 0.875rem;
        color: #6b7280;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        margin-bottom: 0.5rem;
    }
    
    .stat-card-stars {
        display: flex;
        gap: 2px;
    }
    
    .stat-card-stars i {
        font-size: 0.75rem;
        color: #e5e7eb;
    }
    
    .stat-card-stars i.active {
        color: #f59e0b;
    }
    
    .stat-card-trend {
        font-size: 0.75rem;
        color: #10b981;
    }
    
    .stat-card-progress {
        height: 4px;
        background: #e5e7eb;
        border-radius: 2px;
        overflow: hidden;
    }
    
    .progress-fill {
        height: 100%;
        background: linear-gradient(90deg, #10b981, #34d399);
        border-radius: 2px;
        transition: width 1s ease;
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
    
    .section-actions {
        display: flex;
        gap: 0.5rem;
    }
    
    .btn-filter {
        width: 36px;
        height: 36px;
        border-radius: 8px;
        border: 1px solid #e5e7eb;
        background: white;
        color: #6b7280;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .btn-filter.active,
    .btn-filter:hover {
        background: #4f46e5;
        border-color: #4f46e5;
        color: white;
    }
    
    /* Avis Card */
    .avis-card {
        background: white;
        border-radius: 1.25rem;
        padding: 1.5rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
        animation: fadeInUp 0.5s ease forwards;
        opacity: 0;
    }
    
    .avis-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .avis-card-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 1rem;
    }
    
    .avis-user {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    
    .avis-avatar {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        background: linear-gradient(135deg, #667eea, #764ba2);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 0.875rem;
        position: relative;
    }
    
    .avatar-status {
        position: absolute;
        bottom: 2px;
        right: 2px;
        width: 10px;
        height: 10px;
        background: #10b981;
        border-radius: 50%;
        border: 2px solid white;
    }
    
    .avis-user-info h5 {
        margin: 0;
        font-size: 0.95rem;
        font-weight: 600;
        color: #1f2937;
    }
    
    .avis-badge {
        font-size: 0.7rem;
        background: rgba(16, 185, 129, 0.1);
        color: #059669;
        padding: 0.2rem 0.5rem;
        border-radius: 0.25rem;
        font-weight: 500;
    }
    
    .btn-menu {
        width: 32px;
        height: 32px;
        border-radius: 8px;
        border: none;
        background: #f3f4f6;
        color: #6b7280;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .btn-menu:hover {
        background: #e5e7eb;
    }
    
    .avis-rating {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        margin-bottom: 1rem;
    }
    
    .stars {
        display: flex;
        gap: 3px;
    }
    
    .stars i {
        font-size: 1rem;
        color: #e5e7eb;
        transition: all 0.3s ease;
    }
    
    .stars i.active {
        color: #f59e0b;
    }
    
    .rating-text {
        font-weight: 700;
        color: #1f2937;
        font-size: 0.9rem;
    }
    
    .avis-content {
        flex: 1;
        margin-bottom: 1rem;
    }
    
    .avis-content p {
        margin: 0;
        color: #4b5563;
        font-size: 0.9rem;
        line-height: 1.6;
        font-style: italic;
    }
    
    .avis-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 1rem;
        border-top: 1px solid #f3f4f6;
    }
    
    .avis-prestataire {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.8rem;
        color: #6b7280;
    }
    
    .avis-prestataire i {
        color: #4f46e5;
    }
    
    .btn-like {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        border: 1px solid #e5e7eb;
        background: white;
        color: #6b7280;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .btn-like:hover {
        background: #fef2f2;
        border-color: #fecaca;
        color: #ef4444;
    }
    
    /* Empty State */
    .empty-avis {
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
        background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem;
        font-size: 2.5rem;
        color: #667eea;
    }
    
    .empty-avis h4 {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 0.5rem;
    }
    
    .empty-avis p {
        color: #6b7280;
        margin-bottom: 1.5rem;
        max-width: 400px;
        margin-left: auto;
        margin-right: auto;
    }
    
    .btn-add-first {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 0.75rem;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        transition: all 0.3s ease;
    }
    
    .btn-add-first:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        color: white;
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .avis-header-content {
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
        }
        
        .avis-header-text h1 {
            font-size: 1.5rem;
        }
        
        .btn-add-avis {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<jsp:include page="../shared/footer.jsp"/>