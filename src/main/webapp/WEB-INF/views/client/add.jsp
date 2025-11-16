<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Nouveau Client" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-user-plus text-gradient me-2"></i> Ajouter un nouveau client</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/client?action=list">Clients</a></li>
                    <li class="breadcrumb-item active">Nouveau</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-user-circle me-2"></i> Informations du client
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/client?action=add" method="post">
                    
                    <!-- Informations personnelles -->
                    <div class="row">
                        <div class="col-12 mb-4">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-id-card me-2"></i> Informations personnelles
                            </h5>
                            <hr>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="nom" class="form-label-modern">
                                <i class="fas fa-user me-1"></i> Nom *
                            </label>
                            <input type="text" class="form-control-modern" id="nom" name="nom" 
                                   placeholder="Nom de famille" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="prenom" class="form-label-modern">
                                <i class="fas fa-user me-1"></i> Prénom *
                            </label>
                            <input type="text" class="form-control-modern" id="prenom" name="prenom" 
                                   placeholder="Prénom" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label-modern">
                                <i class="fas fa-envelope me-1"></i> Email *
                            </label>
                            <input type="email" class="form-control-modern" id="email" name="email" 
                                   placeholder="client@example.com" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="telephone" class="form-label-modern">
                                <i class="fas fa-phone me-1"></i> Téléphone *
                            </label>
                            <input type="tel" class="form-control-modern" id="telephone" name="telephone" 
                                   placeholder="0600000000" required>
                        </div>
                        
                        <div class="col-12 mb-3">
                            <label for="motDePasse" class="form-label-modern">
                                <i class="fas fa-lock me-1"></i> Mot de passe *
                            </label>
                            <input type="password" class="form-control-modern" id="motDePasse" name="motDePasse" 
                                   placeholder="Minimum 6 caractères" minlength="6" required>
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i> Minimum 6 caractères
                            </small>
                        </div>
                    </div>
                    
                    <!-- Adresse -->
                    <div class="row mt-4">
                        <div class="col-12 mb-4">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-map-marker-alt me-2"></i> Adresse
                            </h5>
                            <hr>
                        </div>
                        
                        <div class="col-12 mb-3">
                            <label for="adresse" class="form-label-modern">
                                <i class="fas fa-home me-1"></i> Adresse complète
                            </label>
                            <textarea class="form-control-modern" id="adresse" name="adresse" 
                                      rows="2" placeholder="Numéro et rue"></textarea>
                        </div>
                        
                        <div class="col-md-8 mb-3">
                            <label for="ville" class="form-label-modern">
                                <i class="fas fa-city me-1"></i> Ville
                            </label>
                            <input type="text" class="form-control-modern" id="ville" name="ville" 
                                   placeholder="Ville">
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="codePostal" class="form-label-modern">
                                <i class="fas fa-mail-bulk me-1"></i> Code postal
                            </label>
                            <input type="text" class="form-control-modern" id="codePostal" name="codePostal" 
                                   placeholder="75001" pattern="[0-9]{5}">
                        </div>
                    </div>
                    
                    <!-- Actions -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <hr class="mb-4">
                            <div class="d-flex gap-2 justify-content-end">
                                <a href="${pageContext.request.contextPath}/client?action=list" 
                                   class="btn btn-outline-custom">
                                    <i class="fas fa-times me-2"></i> Annuler
                                </a>
                                <button type="reset" class="btn btn-outline-custom">
                                    <i class="fas fa-redo me-2"></i> Réinitialiser
                                </button>
                                <button type="submit" class="btn btn-success-custom">
                                    <i class="fas fa-save me-2"></i> Enregistrer
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Help Card -->
        <div class="card-modern mt-4">
            <div class="card-body-custom">
                <h6 class="text-primary mb-3">
                    <i class="fas fa-question-circle me-2"></i> Aide
                </h6>
                <ul class="mb-0 text-muted small">
                    <li>Les champs marqués d'un astérisque (*) sont obligatoires</li>
                    <li>L'email doit être unique dans le système</li>
                    <li>Le mot de passe doit contenir au moins 6 caractères</li>
                    <li>Le numéro de téléphone doit être valide</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
    // Validation du formulaire
    document.querySelector('form').addEventListener('submit', function(e) {
        const email = document.getElementById('email').value;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        if (!emailRegex.test(email)) {
            e.preventDefault();
            alert('Veuillez entrer une adresse email valide');
            return false;
        }
        
        const telephone = document.getElementById('telephone').value;
        const telRegex = /^[0-9]{10}$/;
        
        if (!telRegex.test(telephone.replace(/\s/g, ''))) {
            e.preventDefault();
            alert('Le numéro de téléphone doit contenir 10 chiffres');
            return false;
        }
    });
    
    // Auto-formatage du téléphone
    document.getElementById('telephone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\s/g, '');
        if (value.length > 10) value = value.slice(0, 10);
        e.target.value = value;
    });
</script>

<jsp:include page="../shared/footer.jsp"/>
