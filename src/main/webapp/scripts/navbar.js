const menBtn = document.getElementById('menu-btn');
const navbar = document.getElementById('navbar');
const menu = document.querySelector('.menu');

//offset when navbar activates
const offset = 50;

//add click event to menu button
menBtn.addEventListener('click', () => {
	//toggler open menu class
	menu.classList.toggle('menu-open');
});

//add scroll even listener to page
window.addEventListener('scroll', () => {
	//if page is not scrolled by 50px or more
	if (pageYOffset > offset) {
		//activate navbar
		navbar.classList.add('navbar-active');
	} else {
		//deactivate navbar
		navbar.classList.remove('navbar-active');
	}
});