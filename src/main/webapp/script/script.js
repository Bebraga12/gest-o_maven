const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');
const entrarButton = document.getElementById('entrar');

signUpButton.addEventListener('click', () => {
	container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
	container.classList.remove("right-panel-active");
});

/*entrarButton.addEventListener('click', (event) => {
	event.preventDefault();
	window.location.href = 'templates/perfil.jsp';
});*/