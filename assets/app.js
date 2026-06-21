import './stimulus_bootstrap.js';
/*
 * Welcome to your app's main JavaScript file!
 *
 * This file will be included onto the page via the importmap() Twig function,
 * which should already be in your base.html.twig.
 */
import './styles/app.css';

console.log('This log comes from assets/app.js - welcome to AssetMapper! 🎉');

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
