<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</div> <!-- Fermeture du container principal -->

<!-- Footer -->
<footer class="footer-custom mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0 text-muted">
                    <i class="fas fa-copyright me-1"></i> 2025 Services à Domicile. Tous droits réservés.
                </p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <a href="#" class="text-muted text-decoration-none me-3"><i class="fas fa-shield-alt me-1"></i> Confidentialité</a>
                <a href="#" class="text-muted text-decoration-none"><i class="fas fa-file-contract me-1"></i> Conditions</a>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script>
    // Auto-hide alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    });
    
    // Confirm delete actions
    document.querySelectorAll('.btn-delete-confirm').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            if (!confirm('Êtes-vous sûr de vouloir supprimer cet élément ?')) {
                e.preventDefault();
            }
        });
    });
</script>

</body>
</html>
