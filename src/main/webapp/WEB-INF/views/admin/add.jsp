<%@ include file="../includes/header.jsp" %>

<h2><i class="fa-solid fa-user-plus"></i> Ajouter un administrateur</h2>

<form action="admin" method="post">
    <input type="hidden" name="action" value="add">
    
    <div class="row mb-3">
        <div class="col-md-6">
            <label>Nom :</label>
            <input type="text" name="nom" class="form-control" required>
        </div>
        <div class="col-md-6">
            <label>Prénom :</label>
            <input type="text" name="prenom" class="form-control" required>
        </div>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <label>Email :</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="col-md-6">
            <label>Téléphone :</label>
            <input type="text" name="telephone" class="form-control">
        </div>
    </div>

    <div class="mb-3">
        <label>Mot de passe :</label>
        <input type="password" name="motDePasse" class="form-control" required>
    </div>

    <button type="submit" class="btn btn-success"><i class="fa-solid fa-check"></i> Enregistrer</button>
    <a href="admin?action=list" class="btn btn-secondary">Annuler</a>
</form>

<%@ include file="../includes/footer.jsp" %>
