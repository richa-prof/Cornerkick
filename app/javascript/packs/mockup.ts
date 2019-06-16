document.addEventListener('DOMContentLoaded', () => {

    let menuButton = document.querySelector('.menu-button');

    menuButton.addEventListener('click', () => {
        let menu = document.querySelector('.sidebar') as HTMLElement;
        menu.style.display = 'block';
    });

});