/**
 * LABCAT - Auth & Login Interactive JavaScript
 */
document.addEventListener('DOMContentLoaded', () => {
    const passwordToggle = document.querySelector('[data-password-toggle]');
    const passwordInput = document.querySelector('[data-password]');
    const capsWarning = document.querySelector('[data-caps-warning]');

    // 1. Fitur Toggle Mata SVG (Show/Hide Password)
    if (passwordToggle && passwordInput) {
        passwordToggle.addEventListener('click', () => {
            const isPassword = passwordInput.type === 'password';
            passwordInput.type = isPassword ? 'text' : 'password';

            const eyeOpen = passwordToggle.querySelector('.eye-open');
            const eyeClosed = passwordToggle.querySelector('.eye-closed');
            if (eyeOpen && eyeClosed) {
                eyeOpen.style.display = isPassword ? 'none' : 'block';
                eyeClosed.style.display = isPassword ? 'block' : 'none';
            }
            passwordToggle.setAttribute('aria-label', isPassword ? 'Sembunyikan password' : 'Lihat password');
        });
    }

    // 2. Fitur Deteksi Otomatis Tombol Caps Lock
    if (passwordInput && capsWarning) {
        ['keydown', 'keyup'].forEach(evt => {
            passwordInput.addEventListener(evt, (e) => {
                if (e.getModifierState && e.getModifierState('CapsLock')) {
                    capsWarning.classList.add('active');
                } else {
                    capsWarning.classList.remove('active');
                }
            });
        });

        passwordInput.addEventListener('blur', () => {
            capsWarning.classList.remove('active');
        });
    }
});