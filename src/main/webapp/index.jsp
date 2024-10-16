<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/coursejdbc?useSSL=false";
    String username = "root";
    String password = "5142";
    String email = request.getParameter("email");
    String userPassword = request.getParameter("password");

    if (email != null && userPassword != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);
            
            String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, userPassword);

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                response.sendRedirect("templates/perfil.html");
            } else {
                out.println("<script>alert('Email ou senha inválidos!');</script>");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Ocorreu um erro de conexão com o banco de dados');</script>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container" id="container">
    <div class="form-container sign-up-container">
        <form action="#">
            <h1>Criar conta</h1>
            <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>ou use seu email para cadastro</span>
            <input type="text" placeholder="Name" />
            <input type="email" placeholder="Email" />
            <input type="password" placeholder="Password" />
            <button>Inscreva-se</button>
        </form>
    </div>
    <div class="form-container sign-in-container">
        <form method="POST" action="">
            <h1>Login</h1>
            <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>ou use sua conta</span>
            <input type="email" name="email" placeholder="Email" required />
            <input type="password" name="password" placeholder="Password" required />
            <a href="#">Esqueceu sua senha?</a>
            <button type="submit">Entrar</button>
        </form>
    </div>
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>Bem vindo de volta</h1>
                <p>Para fazer login use suas informações pessoais</p>
                <button class="ghost" id="signIn">Login</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>Bem vindo!</h1>
                <p>Primeira vez? Crie uma conta!</p>
                <button class="ghost" id="signUp">Criar conta</button>
            </div>
        </div>
    </div>
</div>

<script src="script/script.js"></script>
</body>
</html>
