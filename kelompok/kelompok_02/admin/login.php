<?php
require_once __DIR__ . '/../includes/bootstrap.php';

if (admin_logged_in()) {
    redirect('admin/dashboard.php');
}

// 1. SISTEM KEAMANAN ANTI-BRUTE FORCE
$maxAttempts = 5;       // Maksimal percobaan salah
$lockoutTime = 60;      // Waktu kunci (detik)

if (!isset($_SESSION['login_attempts'])) {
    $_SESSION['login_attempts'] = 0;
}
if (!isset($_SESSION['login_lockout_until'])) {
    $_SESSION['login_lockout_until'] = 0;
}

$isLocked = time() < $_SESSION['login_lockout_until'];
$remainingLockout = $isLocked ? ($_SESSION['login_lockout_until'] - time()) : 0;

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verify_csrf();

    if ($isLocked) {
        $error = "Terlalu banyak percobaan gagal. Akun dikunci sementara. Silakan tunggu $remainingLockout detik.";
    } else {
        $email = trim((string) ($_POST['email'] ?? ''));
        $password = (string) ($_POST['password'] ?? '');
        $rememberMe = !empty($_POST['remember_me']);

        $stmt = $pdo->prepare('SELECT id, name, email, password_hash FROM admins WHERE email = :email LIMIT 1');
        $stmt->execute(['email' => $email]);
        $admin = $stmt->fetch();

        if ($admin && password_verify($password, $admin['password_hash'])) {
            // Reset percobaan gagal jika sukses
            $_SESSION['login_attempts'] = 0;
            $_SESSION['login_lockout_until'] = 0;

            // Fitur Ingat Saya (Cookie 30 Hari)
            if ($rememberMe) {
                setcookie('remember_admin_email', $email, time() + (30 * 24 * 3600), '/', '', false, true);
            } else {
                setcookie('remember_admin_email', '', time() - 3600, '/');
            }

            session_regenerate_id(true);
            $_SESSION['admin'] = [
                'id' => (int) $admin['id'],
                'name' => $admin['name'],
                'email' => $admin['email'],
            ];
            set_flash('success', 'Selamat datang kembali, ' . $admin['name'] . '.');
            redirect('admin/dashboard.php');
        } else {
            // Tambah hitungan gagal
            $_SESSION['login_attempts']++;
            if ($_SESSION['login_attempts'] >= $maxAttempts) {
                $_SESSION['login_lockout_until'] = time() + $lockoutTime;
                $error = "Terlalu banyak percobaan login gagal! Akses login dikunci selama $lockoutTime detik demi keamanan.";
                $isLocked = true;
                $remainingLockout = $lockoutTime;
            } else {
                $sisa = $maxAttempts - $_SESSION['login_attempts'];
                $error = "Email atau password tidak sesuai. (Sisa percobaan: $sisa kali lagi)";
            }
        }
    }
}

// Cek email tersimpan dari cookie "Ingat Saya"
$savedEmail = $_COOKIE['remember_admin_email'] ?? ($_POST['email'] ?? '');
$flash = get_flash();
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Admin | LABCAT</title>
    <link rel="stylesheet" href="<?= url('assets/css/admin/auth.css') ?>?v=<?= time() ?>">
    <script defer src="<?= url('assets/js/admin/auth.js') ?>?v=<?= time() ?>"></script>
</head>
<body class="login-page">
    <div class="login-card">
        <a class="brand brand-login" href="<?= url('index.php') ?>">
            <img class="brand-icon brand-icon-navy" src="<?= url('assets/images/flask-mark-navy.svg') ?>" alt="">
            <span class="brand-copy"><strong>LABCAT</strong><small>LABORATORY CATALOG SYSTEM</small></span>
        </a>

        <div class="login-heading">
            <span class="eyebrow eyebrow-blue">ADMINISTRATOR AREA</span>
            <h1>Login Admin</h1>
            <p>Masuk untuk mengelola data alat laboratorium.</p>
        </div>

        <?php if ($flash): ?>
            <div class="alert alert-<?= e($flash['type']) ?>"><?= e($flash['message']) ?></div>
        <?php endif; ?>

        <?php if ($error): ?>
            <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endif; ?>

        <form method="post" class="form-stack">
            <?= csrf_field() ?>
            <label>Email Administrator
                <span class="input-icon">✉</span>
                <input type="email" name="email" placeholder="admin@labcat.ac.id" required autocomplete="username" value="<?= e($savedEmail) ?>" <?= $isLocked ? 'disabled' : '' ?>>
            </label>

            <label>Password
                <span class="input-icon">▣</span>
                <input type="password" name="password" placeholder="Masukkan password" required autocomplete="current-password" data-password <?= $isLocked ? 'disabled' : '' ?>>
                <button class="password-toggle" type="button" data-password-toggle aria-label="Lihat password">
                    <svg class="eye-open" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/></svg>
                    <svg class="eye-closed" style="display:none;" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m9.88 9.88a3 3 0 1 0 4.24 4.24"/><path d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68"/><path d="M6.61 6.61A13.526 13.526 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61"/><line x1="2" x2="22" y1="2" y2="22"/></svg>
                </button>
            </label>

            <!-- Indikator Caps Lock Otomatis -->
            <div class="caps-warning" data-caps-warning>
                <span>⚠️</span> Caps Lock sedang aktif
            </div>

            <!-- Fitur Ingat Saya -->
           <div class="remember-row">
            <input type="checkbox" id="remember_me" name="remember_me" value="1" <?= !empty($_COOKIE['remember_admin_email']) ? 'checked' : '' ?>>
            <label for="remember_me" class="remember-label">Ingat Saya</label>
        </div>

            <button class="btn btn-primary btn-block" type="submit" <?= $isLocked ? 'disabled' : '' ?>>
                <?= $isLocked ? 'Terkunci Sementara' : 'Masuk ke Dashboard <span>→</span>' ?>
            </button>
        </form>

        <a class="login-back" href="<?= url('index.php') ?>">← Kembali ke Katalog Publik</a>
    </div>
</body>
</html>