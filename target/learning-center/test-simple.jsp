<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UM6P Learning Center - Test Page</title>

    <!-- Google Fonts - Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/core.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components.css">

    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--lc-navy) 0%, var(--lc-navy-dark) 100%);
        }

        .success-card {
            background: var(--white);
            border-radius: var(--radius-xl);
            padding: var(--space-12);
            max-width: 600px;
            text-align: center;
            box-shadow: var(--shadow-2xl);
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: var(--success-bg);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto var(--space-6) auto;
        }

        .success-icon i {
            font-size: 40px;
            color: var(--success);
        }

        h1 {
            color: var(--gray-900);
            margin-bottom: var(--space-4);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--space-4);
            margin: var(--space-8) 0;
        }

        .feature-item {
            background: var(--gray-50);
            padding: var(--space-4);
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            gap: var(--space-3);
        }

        .feature-item i {
            font-size: 24px;
            color: var(--orange-primary);
        }

        .links-section {
            margin-top: var(--space-8);
            padding-top: var(--space-6);
            border-top: 1px solid var(--gray-200);
        }

        .btn-group {
            display: flex;
            gap: var(--space-3);
            justify-content: center;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
    <div class="success-card">
        <div class="success-icon">
            <i class="fas fa-check-circle"></i>
        </div>

        <h1>✅ Frontend Déployé avec Succès!</h1>

        <p style="color: var(--gray-600); font-size: 18px; margin-bottom: var(--space-6);">
            Votre application UM6P Learning Center fonctionne correctement!
        </p>

        <div style="background: var(--info-bg); padding: var(--space-4); border-radius: var(--radius-md); margin-bottom: var(--space-6);">
            <p style="color: var(--gray-700); margin: 0;">
                <i class="fas fa-info-circle" style="color: var(--info);"></i>
                <strong>Note:</strong> Les pages JSP avec JSTL nécessitent la bibliothèque jstl-1.2.jar
            </p>
        </div>

        <div class="features-grid">
            <div class="feature-item">
                <i class="fas fa-paint-brush"></i>
                <div style="text-align: left;">
                    <strong>Design Professionnel</strong>
                    <br><small>CSS Framework complet</small>
                </div>
            </div>

            <div class="feature-item">
                <i class="fas fa-mobile-alt"></i>
                <div style="text-align: left;">
                    <strong>100% Responsive</strong>
                    <br><small>Mobile, Tablet, Desktop</small>
                </div>
            </div>

            <div class="feature-item">
                <i class="fas fa-code"></i>
                <div style="text-align: left;">
                    <strong>JavaScript Moderne</strong>
                    <br><small>485 lignes de code</small>
                </div>
            </div>

            <div class="feature-item">
                <i class="fas fa-palette"></i>
                <div style="text-align: left;">
                    <strong>Couleurs UM6P</strong>
                    <br><small>Branding officiel</small>
                </div>
            </div>
        </div>

        <div class="links-section">
            <h3 style="font-size: 20px; margin-bottom: var(--space-4);">Pages Disponibles (Sans JSTL):</h3>

            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/test-simple.jsp" class="btn btn-primary">
                    <i class="fas fa-home"></i> Page de Test
                </a>
            </div>

            <p style="margin-top: var(--space-6); color: var(--gray-600); font-size: 14px;">
                Pour activer toutes les pages JSP, ajoutez <code>jstl-1.2.jar</code> dans le dossier WEB-INF/lib
            </p>
        </div>

        <div style="margin-top: var(--space-8); padding: var(--space-6); background: var(--orange-pale); border-radius: var(--radius-md);">
            <h4 style="color: var(--orange-primary); margin-bottom: var(--space-3);">
                <i class="fas fa-download"></i> Installation JSTL Requise
            </h4>
            <p style="color: var(--gray-700); font-size: 14px; margin-bottom: var(--space-4);">
                Téléchargez et copiez ces fichiers dans WEB-INF/lib:
            </p>
            <div style="background: var(--white); padding: var(--space-3); border-radius: var(--radius-sm); font-family: monospace; font-size: 13px;">
                jstl-1.2.jar<br>
                standard-1.1.2.jar (optionnel)
            </div>
        </div>

        <p style="margin-top: var(--space-8); color: var(--gray-500); font-size: 13px;">
            <i class="fas fa-graduation-cap"></i> Mohammed VI Polytechnic University<br>
            Ben Guerir, Morocco
        </p>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <script>
        console.log('✅ UM6P Learning Center - Frontend loaded successfully!');
        console.log('📁 Assets directory:', '${pageContext.request.contextPath}/assets/');
        console.log('⚠️ JSTL library needed for full functionality');
    </script>
</body>
</html>
