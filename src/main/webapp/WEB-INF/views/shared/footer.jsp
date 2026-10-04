<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
</div> <!-- Fermeture du container principal -->

<!-- Footer Compact -->
<footer class="footer-compact">
    <div class="container">
        <div class="row align-items-center py-4">
            <div class="col-md-4 text-center text-md-start mb-3 mb-md-0">
                <div class="footer-brand">
                    <i class="fas fa-home-lg-alt me-2"></i>
                    <span>Services Domicile</span>
                </div>
            </div>
            <div class="col-md-4 text-center mb-3 mb-md-0">
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-md-4 text-center text-md-end">
                <div class="footer-links">
                    <a href="#">Mentions légales</a>
                    <a href="#">Confidentialité</a>
                    <a href="#">Contact</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom text-center py-3">
            <p class="mb-0">&copy; 2025 <strong>Services à Domicile</strong>. Tous droits réservés.</p>
        </div>
    </div>
</footer>

<style>
    .footer-compact {
        background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
        color: #9ca3af;
        margin-top: 3rem;
    }
    
    .footer-brand {
        color: white;
        font-weight: 700;
        font-size: 1.25rem;
    }
    
    .footer-brand i {
        color: #6366f1;
    }
    
    .social-links {
        display: flex;
        gap: 0.75rem;
        justify-content: center;
    }
    
    .social-links a {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        text-decoration: none;
        font-size: 0.875rem;
        transition: all 0.3s ease;
    }
    
    .social-links a:hover {
        background: #4f46e5;
        transform: translateY(-3px);
    }
    
    .footer-links {
        display: flex;
        gap: 1.5rem;
        justify-content: flex-end;
        flex-wrap: wrap;
    }
    
    .footer-links a {
        color: #9ca3af;
        text-decoration: none;
        font-size: 0.875rem;
        transition: color 0.3s ease;
    }
    
    .footer-links a:hover {
        color: white;
    }
    
    .footer-bottom {
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        font-size: 0.875rem;
    }
    
    .footer-bottom strong {
        color: white;
    }
    
    @media (max-width: 768px) {
        .footer-links {
            justify-content: center;
            gap: 1rem;
        }
    }
</style>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function confirmDelete(message) {
    return confirm(message || 'Êtes-vous sûr de vouloir supprimer cet élément ?');
}

document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(alert) {
        setTimeout(function() {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000);
    });
});

document.querySelectorAll('.btn-delete-confirm').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
        if (!confirm('Êtes-vous sûr de vouloir supprimer cet élément ?')) {
            e.preventDefault();
        }
    });
});

// Les actions qui modifient des données (suppression, changement de statut) sont envoyées
// en POST avec le jeton CSRF, jamais par un simple lien GET.
document.addEventListener('click', function(e) {
    const link = e.target.closest('a[href*="action=delete"], a[href*="action=updateStatus"]');
    if (!link || e.defaultPrevented) {
        return;
    }
    e.preventDefault();

    const url = new URL(link.href, window.location.href);
    const form = document.createElement('form');
    form.method = 'post';
    form.action = url.pathname;
    url.searchParams.forEach(function(value, key) {
        form.appendChild(Object.assign(document.createElement('input'), { type: 'hidden', name: key, value: value }));
    });
    form.appendChild(Object.assign(document.createElement('input'),
        { type: 'hidden', name: '_csrf', value: '${sessionScope._csrf}' }));
    document.body.appendChild(form);
    form.submit();
});
</script>

</body>
</html>