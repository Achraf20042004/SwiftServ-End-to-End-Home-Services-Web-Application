<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouvelle Notification" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-paper-plane text-gradient me-2"></i> Créer une notification</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/notification?action=list">Notifications</a></li>
                    <li class="breadcrumb-item active">Nouvelle</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-envelope me-2"></i> Détails de la notification
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/notification?action=add" method="post">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                    
                    <!-- Recipients Section -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-users me-2"></i> Destinataires
                        </h5>
                        <hr>
                        
                        <div class="mb-3">
                            <label class="form-label-modern">
                                <i class="fas fa-user-friends me-1"></i> Type de destinataire *
                            </label>
                            <div class="recipient-type-selector">
                                <input type="radio" id="type-single" name="recipientType" value="single" checked>
                                <label for="type-single" class="recipient-type-card">
                                    <i class="fas fa-user fa-2x mb-2"></i>
                                    <strong>Individuel</strong>
                                    <small class="text-muted">Un seul client</small>
                                </label>
                                
                                
                                <input type="radio" id="type-all" name="recipientType" value="all">
                                <label for="type-all" class="recipient-type-card">
                                    <i class="fas fa-users fa-2x mb-2"></i>
                                    <strong>Tous</strong>
                                    <small class="text-muted">Tous les clients</small>
                                </label>
                            </div>
                        </div>
                        
                        <div id="single-recipient" class="recipient-selector">
                            <label for="userId" class="form-label-modern">
                                <i class="fas fa-user-circle me-1"></i> Sélectionner le client
                            </label>
                            <select class="form-select-modern" id="userId" name="userId">
                                <option value="">Choisir un client</option>
                                <c:forEach var="user" items="${clients}">
                                    <option value="${user.id}">
                                        ${fn:escapeXml(user.nom)} ${fn:escapeXml(user.prenom)} (${fn:escapeXml(user.email)})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                    </div>
                    
                    <!-- Notification Details -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-file-alt me-2"></i> Contenu de la notification
                        </h5>
                        <hr>
                        
                        <div class="mb-3">
                            <label for="type" class="form-label-modern">
                                <i class="fas fa-tag me-1"></i> Type de notification *
                            </label>
                            <select class="form-select-modern" id="type" name="type" required>
                                <option value="">Sélectionner un type</option>
                                <option value="RESERVATION">📅 Réservation</option>
                                <option value="INTERVENTION">🔧 Intervention</option>
                                <option value="RECLAMATION">⚠️ Réclamation</option>
                                <option value="AVIS">⭐ Avis</option>
                                <option value="SYSTEME">ℹ️ Système</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="titre" class="form-label-modern">
                                <i class="fas fa-heading me-1"></i> Titre *
                            </label>
                            <input type="text" class="form-control-modern" id="titre" name="titre" 
                                   placeholder="Titre de la notification" maxlength="45" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="message" class="form-label-modern">
                                <i class="fas fa-comment-dots me-1"></i> Message *
                            </label>
                            <textarea class="form-control-modern" id="message" name="message" 
                                      rows="4" placeholder="Contenu de la notification..." 
                                      maxlength="250" required></textarea>
                            <div class="d-flex justify-content-end">
                                <small class="text-muted">
                                    <span id="char-count">0</span>/250 caractères
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Preview -->
                    <div class="alert alert-info-modern">
                        <h6 class="mb-3"><i class="fas fa-eye me-2"></i> Aperçu</h6>
                        <div class="notification-preview">
                            <div class="notification-icon-preview SYSTEME">
                                <i class="fas fa-bell"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1" id="preview-titre">Titre de la notification</h6>
                                <p class="preview-message mb-2" id="preview-message">Message de la notification...</p>
                                <small class="text-muted">
                                    <i class="fas fa-clock me-1"></i> À l'instant
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/notification?action=list" 
                           class="btn btn-outline-custom">
                            <i class="fas fa-times me-2"></i> Annuler
                        </a>
                        <button type="reset" class="btn btn-outline-custom">
                            <i class="fas fa-redo me-2"></i> Réinitialiser
                        </button>
                        <button type="submit" class="btn btn-primary-custom">
                            <i class="fas fa-paper-plane me-2"></i> Envoyer la notification
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .recipient-type-selector {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
    }
    
    .recipient-type-selector input {
        display: none;
    }
    
    .recipient-type-card {
        padding: 1.5rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.75rem;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    
    .recipient-type-card:hover {
        border-color: var(--primary-color);
        background: #f9fafb;
    }
    
    .recipient-type-selector input:checked + .recipient-type-card {
        border-color: var(--primary-color);
        background: linear-gradient(135deg, rgba(79, 70, 229, 0.1), rgba(99, 102, 241, 0.05));
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.15);
    }
    
    .notification-preview {
        padding: 1.5rem;
        background: white;
        border-radius: 0.75rem;
        border: 2px dashed #e5e7eb;
        display: flex;
        gap: 1rem;
    }
    
    .notification-icon-preview {
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
    
    .notification-icon-preview.RESERVATION {
        background: linear-gradient(135deg, #10b981, #34d399);
    }
    
    .notification-icon-preview.INTERVENTION {
        background: linear-gradient(135deg, #f59e0b, #fbbf24);
    }
    
    .notification-icon-preview.RECLAMATION {
        background: linear-gradient(135deg, #ef4444, #f87171);
    }
    
    .notification-icon-preview.AVIS {
        background: linear-gradient(135deg, #8b5cf6, #a78bfa);
    }
    
    .notification-icon-preview.SYSTEME {
        background: linear-gradient(135deg, #4f46e5, #6366f1);
    }
    
    .preview-message {
        color: var(--text-secondary);
        font-size: 0.875rem;
    }
</style>

<script>
    // Character counter
    document.getElementById('message').addEventListener('input', function(e) {
        document.getElementById('char-count').textContent = e.target.value.length;
        document.getElementById('preview-message').textContent = e.target.value || 'Message de la notification...';
    });
    
    // Preview titre
    document.getElementById('titre').addEventListener('input', function(e) {
        document.getElementById('preview-titre').textContent = e.target.value || 'Titre de la notification';
    });
    
    // Type preview
    document.getElementById('type').addEventListener('change', function(e) {
        const iconPreview = document.querySelector('.notification-icon-preview');
        iconPreview.className = 'notification-icon-preview ' + e.target.value;
        
        const icons = {
            'RESERVATION': 'fa-calendar-check',
            'INTERVENTION': 'fa-tools',
            'RECLAMATION': 'fa-exclamation-triangle',
            'AVIS': 'fa-star',
            'SYSTEME': 'fa-info-circle'
        };
        
        iconPreview.innerHTML = '<i class="fas ' + (icons[e.target.value] || 'fa-bell') + '"></i>';
    });
    
    // Recipient type selector
    document.querySelectorAll('input[name="recipientType"]').forEach(function(input) {
        input.addEventListener('change', function() {
            document.getElementById('single-recipient').style.display = 'none';
            
            if (this.value === 'single') {
                document.getElementById('single-recipient').style.display = 'block';
            }
        });
    });
</script>

<jsp:include page="../shared/footer.jsp"/>
