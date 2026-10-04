<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Gestion des Catégories" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="container-fluid">
    <div class="page-header fade-in">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1>
                    <i class="fas fa-tags text-gradient"></i>
                    Gestion des Catégories
                </h1>
                <p class="text-muted mb-0">Liste de toutes les catégories de services</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/categorie?action=add" 
                   class="btn btn-primary-custom">
                    <i class="fas fa-plus-circle"></i> Nouvelle Catégorie
                </a>
            </div>
        </div>
    </div>

    <div class="card card-modern fade-in">
        <div class="card-body-custom">
            <c:if test="${empty categories}">
                <div class="text-center py-5">
                    <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">Aucune catégorie</h4>
                    <p class="text-muted">Commencez par créer votre première catégorie</p>
                    <a href="${pageContext.request.contextPath}/categorie?action=add" 
                       class="btn btn-primary-custom">
                        <i class="fas fa-plus-circle"></i> Créer une catégorie
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty categories}">
                <div class="table-responsive">
                    <table class="table table-modern">
                        <thead>
                            <tr>
                                <th width="10%">ID</th>
                                <th width="25%">Nom</th>
                                <th width="45%">Description</th>
                                <th width="20%" class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="categorie" items="${categories}">
                                <tr>
                                    <td>
                                        <span class="badge badge-primary-custom">#${categorie.id}</span>
                                    </td>
                                    <td>
                                        <strong>${fn:escapeXml(categorie.nom)}</strong>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty categorie.description}">
                                                ${fn:escapeXml(categorie.description)}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted fst-italic">Aucune description</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/categorie?action=edit&id=${categorie.id}" 
                                               class="btn btn-action btn-sm btn-warning" 
                                               title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/categorie?action=delete&id=${categorie.id}" 
                                               class="btn btn-action btn-sm btn-danger" 
                                               onclick="return confirmDelete('Êtes-vous sûr de vouloir supprimer cette catégorie ?')"
                                               title="Supprimer">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="../shared/footer.jsp"/>
