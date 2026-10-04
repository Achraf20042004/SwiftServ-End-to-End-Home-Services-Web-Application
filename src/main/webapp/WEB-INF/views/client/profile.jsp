<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Mon Profil" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container">
    <div class="page-header fade-in">
        <h1>
            <i class="fas fa-user-circle text-gradient"></i>
            Mon Profil
        </h1>
        <p class="text-muted mb-0">Gérez vos informations personnelles</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-user-edit"></i> Informations Personnelles
                </div>
                <div class="card-body-custom">
                    <form method="post" action="${pageContext.request.contextPath}/profile">
<input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nom" class="form-label-modern">
                                    <i class="fas fa-user"></i> Nom *
                                </label>
                                <input type="text" 
                                       class="form-control form-control-modern" 
                                       id="nom" 
                                       name="nom" 
                                       value="${fn:escapeXml(user.nom)}"
                                       required>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="prenom" class="form-label-modern">
                                    <i class="fas fa-user"></i> Prénom *
                                </label>
                                <input type="text" 
                                       class="form-control form-control-modern" 
                                       id="prenom" 
                                       name="prenom" 
                                       value="${fn:escapeXml(user.prenom)}"
                                       required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label-modern">
                                <i class="fas fa-envelope"></i> Email *
                            </label>
                            <input type="email" 
                                   class="form-control form-control-modern" 
                                   id="email" 
                                   name="email" 
                                   value="${fn:escapeXml(user.email)}"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label for="telephone" class="form-label-modern">
                                <i class="fas fa-phone"></i> Téléphone
                            </label>
                            <input type="tel" 
                                   class="form-control form-control-modern" 
                                   id="telephone" 
                                   name="telephone" 
                                   value="${fn:escapeXml(user.telephone)}">
                        </div>

                        <hr class="my-4">

                        <h5 class="mb-3">
                            <i class="fas fa-map-marker-alt"></i> Adresse
                        </h5>

                        <div class="mb-3">
                            <label for="adresse" class="form-label-modern">
                                <i class="fas fa-home"></i> Adresse
                            </label>
                            <input type="text" 
                                   class="form-control form-control-modern" 
                                   id="adresse" 
                                   name="adresse" 
                                   value="${fn:escapeXml(user.adresse)}">
                        </div>

                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label for="ville" class="form-label-modern">
                                    <i class="fas fa-city"></i> Ville
                                </label>
                                <input type="text" 
                                       class="form-control form-control-modern" 
                                       id="ville" 
                                       name="ville" 
                                       value="${fn:escapeXml(user.ville)}">
                            </div>

                            <div class="col-md-4 mb-3">
                                <label for="codePostal" class="form-label-modern">
                                    <i class="fas fa-mail-bulk"></i> Code Postal
                                </label>
                                <input type="text" 
                                       class="form-control form-control-modern" 
                                       id="codePostal" 
                                       name="codePostal" 
                                       value="${fn:escapeXml(user.codePostal)}">
                            </div>
                        </div>

                        <hr class="my-4">

                        <h5 class="mb-3">
                            <i class="fas fa-lock"></i> Changer le mot de passe
                        </h5>

                        <div class="mb-3">
                            <label for="newPassword" class="form-label-modern">
                                <i class="fas fa-key"></i> Nouveau mot de passe
                            </label>
                            <input type="password" 
                                   class="form-control form-control-modern" 
                                   id="newPassword" 
                                   name="newPassword"
                                   minlength="6">
                            <small class="text-muted">Laissez vide pour ne pas changer</small>
                        </div>

                        <div class="d-flex gap-2 justify-content-end mt-4">
                            <a href="${pageContext.request.contextPath}/dashboard" 
                               class="btn btn-outline-secondary">
                                <i class="fas fa-times"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-primary-custom">
                                <i class="fas fa-save"></i> Enregistrer
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card card-modern fade-in mt-4">
                <div class="card-body-custom">
                    <h6 class="mb-3">
                        <i class="fas fa-info-circle"></i> Informations du compte
                    </h6>
                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-2">
                                <strong>Rôle :</strong> 
                                <span class="badge badge-success-custom">Client</span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-2">
                                <strong>Date d'inscription :</strong> 
                                ${user.dateInscription}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../shared/footer.jsp"/>
