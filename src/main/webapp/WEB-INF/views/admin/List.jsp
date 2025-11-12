<%@ include file="../includes/header.jsp" %>

<h2 class="mb-4"><i class="fa-solid fa-users-gear"></i> Liste des administrateurs</h2>

<a href="${pageContext.request.contextPath}/admin?action=add" class="btn btn-primary mb-3">
    <i class="fa-solid fa-plus"></i> Ajouter un administrateur
</a>

<table class="table table-striped table-hover">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Email</th>
            <th>Téléphone</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="admin" items="${admins}">
            <tr>
                <td>${admin.id}</td>
                <td>${admin.nom}</td>
                <td>${admin.prenom}</td>
                <td>${admin.email}</td>
                <td>${admin.telephone}</td>
                <td>
                    <a href="admin?action=edit&id=${admin.id}" class="btn btn-warning btn-sm"><i class="fa-solid fa-pen"></i></a>
                    <a href="admin?action=delete&id=${admin.id}" class="btn btn-danger btn-sm"
                       onclick="return confirm('Confirmer la suppression ?')"><i class="fa-solid fa-trash"></i></a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%@ include file="../includes/footer.jsp" %>
