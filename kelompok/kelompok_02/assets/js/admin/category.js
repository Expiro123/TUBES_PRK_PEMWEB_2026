
/* =====================================================
   LABCAT - CATEGORY MANAGEMENT JAVASCRIPT
   Halaman: categories.php
   ===================================================== */

document.addEventListener('DOMContentLoaded', () => {

    // Konfirmasi sebelum menghapus kategori
    const deleteForms = document.querySelectorAll('[data-category-delete]');

    deleteForms.forEach((form) => {
        form.addEventListener('submit', (event) => {
            const confirmed = confirm(
                'Hapus kategori ini? Kategori yang masih digunakan alat tidak dapat dihapus.'
            );

            if (!confirmed) {
                event.preventDefault();
            }
        });
    });

});
