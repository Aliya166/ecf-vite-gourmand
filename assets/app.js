import './stimulus_bootstrap.js';
/*
 * Welcome to your app's main JavaScript file!
 *
 * This file will be included onto the page via the importmap() Twig function,
 * which should already be in your base.html.twig.
 */
import './styles/app.css';

document.addEventListener('DOMContentLoaded', () => {
    const mainImage = document.querySelector('#mainMenuImage');
    const thumbnails = document.querySelectorAll('.js-menu-thumb');

    if (!mainImage || thumbnails.length === 0) {
        return;
    }

    thumbnails.forEach((thumbnail) => {
        thumbnail.addEventListener('click', () => {
            const newImage = thumbnail.dataset.image;

            if (newImage) {
                mainImage.src = newImage;
            }

            thumbnails.forEach((item) => {
                item.classList.remove('menu-detail-thumb-active');
            });

            thumbnail.classList.add('menu-detail-thumb-active');
        });
    });
});

document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('cancelOrderModal');
    const confirmLink = document.getElementById('confirmCancelOrder');
    const openButtons = document.querySelectorAll('.js-open-cancel-modal');
    const closeButtons = document.querySelectorAll('[data-close-cancel-modal]');

    if (!modal || !confirmLink || openButtons.length === 0) {
        return;
    }

    const openModal = (cancelUrl) => {
        confirmLink.setAttribute('href', cancelUrl);
        modal.classList.add('is-visible');
        modal.setAttribute('aria-hidden', 'false');
        document.body.classList.add('modal-open');
    };

    const closeModal = () => {
        modal.classList.remove('is-visible');
        modal.setAttribute('aria-hidden', 'true');
        confirmLink.setAttribute('href', '#');
        document.body.classList.remove('modal-open');
    };

    openButtons.forEach((button) => {
        button.addEventListener('click', () => {
            const cancelUrl = button.dataset.cancelUrl;

            if (cancelUrl) {
                openModal(cancelUrl);
            }
        });
    });

    closeButtons.forEach((button) => {
        button.addEventListener('click', closeModal);
    });

    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape' && modal.classList.contains('is-visible')) {
            closeModal();
        }
    });
});

function initMenuGallery() {
    const mainImage = document.getElementById('mainMenuImage');
    const thumbnails = Array.from(
        document.querySelectorAll('.js-menu-thumb')
    );
    const previousButton = document.getElementById('prevMenuImage');
    const nextButton = document.getElementById('nextMenuImage');

    if (!mainImage || thumbnails.length === 0) {
        return;
    }

    let currentIndex = thumbnails.findIndex((thumbnail) =>
        thumbnail.classList.contains('menu-detail-thumb-active')
    );

    if (currentIndex < 0) {
        currentIndex = 0;
    }

    const showImage = (index) => {
        currentIndex = (index + thumbnails.length) % thumbnails.length;

        const selectedThumbnail = thumbnails[currentIndex];

        mainImage.src = selectedThumbnail.src;

        thumbnails.forEach((thumbnail) => {
            thumbnail.classList.remove('menu-detail-thumb-active');
        });

        selectedThumbnail.classList.add('menu-detail-thumb-active');
    };

    thumbnails.forEach((thumbnail, index) => {
        if (thumbnail.dataset.galleryInitialized === 'true') {
            return;
        }

        thumbnail.dataset.galleryInitialized = 'true';

        thumbnail.addEventListener('click', () => {
            showImage(index);
        });
    });

    if (
        previousButton &&
        previousButton.dataset.galleryInitialized !== 'true'
    ) {
        previousButton.dataset.galleryInitialized = 'true';

        previousButton.addEventListener('click', () => {
            showImage(currentIndex - 1);
        });
    }

    if (
        nextButton &&
        nextButton.dataset.galleryInitialized !== 'true'
    ) {
        nextButton.dataset.galleryInitialized = 'true';

        nextButton.addEventListener('click', () => {
            showImage(currentIndex + 1);
        });
    }
}

document.addEventListener('DOMContentLoaded', initMenuGallery);
document.addEventListener('turbo:load', initMenuGallery);


