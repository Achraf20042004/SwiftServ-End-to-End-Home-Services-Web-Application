<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Modifier Catégorie" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container">
    <div class="page-header fade-in">
        <h1>
            <i class="fas fa-edit text-gradient"></i>
            Modifier Catégorie
        </h1>
        <p class="text-muted mb-0">Modifier les informations de la catégorie #${categorie.id}</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card card-modern fade-in">
                <div class="card-header-custom">
                    <i class="fas fa-edit"></i> Informations de la Catégorie
                </div>
                <div class="card-body-custom">
                    <form method="post" action="${pageContext.request.contextPath}/categorie">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="${categorie.id}">

                        <div class="mb-4">
                            <label for="nom" class="form-label-modern">
                                <i class="fas fa-tag"></i> Nom de la catégorie *
                            </label>
                            <input type="text" 
                                   class="form-control form-control-modern" 
                                   id="nom" 
                                   name="nom" 
                                   value="${categorie.nom}"
                                   required 
                                   autofocus>
                        </div>

                        <div class="mb-4">
                            <label for="description" class="form-label-modern">
                                <i class="fas fa-align-left"></i> Description
                            </label>
                            <textarea class="form-control form-control-modern" 
                                      id="description" 
                                      name="description" 
                                      rows="4">${categorie.description}</textarea>
                            <small class="text-muted">Optionnel</small>
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <a href="${pageContext.request.contextPath}/categorie?action=list" 
                               class="btn btn-outline-secondary">
                                <i class="fas fa-times"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-primary-custom">
                                <i class="fas fa-save"></i> Mettre à jour
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../shared/footer.jsp"/>
