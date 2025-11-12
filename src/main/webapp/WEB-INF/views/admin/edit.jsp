<%@ include file="../includes/header.jsp" %>

<h2><i class="fa-solid fa-user-pen"></i> Modifier un administrateur</h2>

<form action="admin" method="post">
    <input type="hidden" name="action" value="edit">
    <input type="hidden" name="id" value="${admin.id}">
    
    <div class="row mb-3">
        <div class="col-md-6">
            <label>Nom :</label>
            <input type="text" name="nom" class="form-control" value="${admin.nom}" required>
        </div>
        <div class="col-md-6">
            <label>Prénom :</label>
            <input type="text" name="prenom" class="form-control" value="${admin.prenom}" required>
        </div>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <label>Email :</label>
            <input type="email" name="email" class="form-control" value="${admin.email}" required>
        </div>
        <div class="col-md-6">
            <label>Téléphone :</label>
            <input type="text" name="telephone" class="form-control" value="${admin.telephone}">
        </div>
    </div>

    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-save"></i> Enregistrer</button>
    <a href="admin?action=list" class="btn btn-secondary">Annuler</a>
</form>

<%@ include file="../includes/footer.jsp" %>
