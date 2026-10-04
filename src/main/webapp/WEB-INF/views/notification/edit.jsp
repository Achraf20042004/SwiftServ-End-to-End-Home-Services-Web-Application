<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Modifier la notification" scope="request"/>
<jsp:include page="../shared/header.jsp"/>

<div class="row mb-4 fade-in">
    <div class="col-12">
        <div class="page-header">
            <h1><i class="fas fa-edit text-gradient me-2"></i> Modifier la notification</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/notification?action=list">Notifications</a></li>
                    <li class="breadcrumb-item active">Modifier</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="row fade-in">
    <div class="col-lg-8 mx-auto">
        <div class="card-modern">
            <div class="card-header-custom">
                <i class="fas fa-envelope me-2"></i> Notification #${notification.id}
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/notification?action=edit" method="post">
                    <input type="hidden" name="_csrf" value="${sessionScope._csrf}">
                    <input type="hidden" name="id" value="${notification.id}">

                    <div class="mb-3">
                        <label for="clientId" class="form-label-modern">
                            <i class="fas fa-user-circle me-1"></i> Client *
                        </label>
                        <select class="form-select-modern" id="clientId" name="clientId" required>
                            <c:forEach var="client" items="${clients}">
                                <option value="${client.id}" ${client.id == notification.client.id ? 'selected' : ''}>
                                    ${fn:escapeXml(client.nom)} ${fn:escapeXml(client.prenom)} (${fn:escapeXml(client.email)})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label for="message" class="form-label-modern">
                            <i class="fas fa-comment-dots me-1"></i> Message *
                        </label>
                        <textarea class="form-control-modern" id="message" name="message" rows="4"
                                  maxlength="300" required>${fn:escapeXml(notification.message)}</textarea>
                    </div>

                    <div class="d-flex gap-2 justify-content-end">
                        <a href="${pageContext.request.contextPath}/notification?action=list" class="btn btn-outline-custom">
                            <i class="fas fa-times me-2"></i> Annuler
                        </a>
                        <button type="submit" class="btn btn-primary-custom">
                            <i class="fas fa-save me-2"></i> Enregistrer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../shared/footer.jsp"/>
