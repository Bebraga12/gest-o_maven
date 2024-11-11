<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    String url = "jdbc:mysql://localhost:3306/coursejdbc?useSSL=false";
    String username = "root";
    String password = "5142";

    // Parâmetros de Login
    String email = request.getParameter("email");
    String userPassword = request.getParameter("password");

    // Parâmetros de Cadastro
    String emailCadastro = request.getParameter("cadastroEmail");
    String nomeCadastro = request.getParameter("cadastroName");
    String cadastroSenha = request.getParameter("cadastroSenha");

    // Lógica de Login
    if (email != null && userPassword != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);
            
            String sql = "SELECT nome FROM usuarios WHERE email = ? AND senha = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, userPassword);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                String nomeUsuario = resultSet.getString("nome");
                
                // Redireciona para o JSP personalizado do usuário
                response.sendRedirect("templates/" + nomeUsuario + ".jsp");
            } else {
                out.println("<script>alert('Email ou senha incorretos.');</script>");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Erro de conexão com o banco de dados.');</script>");
        }
    }

    // Lógica de Cadastro
    else if (emailCadastro != null && nomeCadastro != null && cadastroSenha != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);
            
            String sql = "INSERT INTO usuarios (email, nome, senha) VALUES (?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, emailCadastro);
            statement.setString(2, nomeCadastro);
            statement.setString(3, cadastroSenha);

            int rowsAffected = statement.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("<script>alert('Cadastro realizado com sucesso!');</script>");
            } else {
                out.println("<script>alert('Erro ao cadastrar.');</script>");
            }

            // Define o caminho para a pasta templates usando o contexto do servlet
            String caminhoTemplates = getServletContext().getRealPath("/templates/");
            String caminhoCompleto = caminhoTemplates + nomeCadastro + ".jsp";

            String siteContent = "<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
                "    <title>Perfil</title>\n" +
                "    <link rel=\"stylesheet\" href=\"../css/perfil.css\">\n" +
                "    <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\"\n" +
                "        integrity=\"sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN\" crossorigin=\"anonymous\">\n" +
                "</head>\n" +
                "<body>\n" +
                "    <div class=\"container\">\n" +
                "        <div class=\"perfil\">\n" +
                "            <img id=\"fotoPerfil\" class=\"fotoPerfil\" src=\"../img/icone.jpg\" alt=\"Foto de Perfil\" />\n" +
                "            <h1 class=\"nomePerfil\">" + nomeCadastro + "</h1>\n" +
                "            <input type=\"file\" id=\"fileInput\" accept=\"image/*\" style=\"display: none;\">\n" +
                "            <div class=\"rating\">\n" +
                "                <input type=\"radio\" name=\"star\" id=\"star1\"><label for=\"star1\"></label>\n" +
                "                <input type=\"radio\" name=\"star\" id=\"star2\"><label for=\"star2\"></label>\n" +
                "                <input type=\"radio\" name=\"star\" id=\"star3\"><label for=\"star3\"></label>\n" +
                "                <input type=\"radio\" name=\"star\" id=\"star4\"><label for=\"star4\"></label>\n" +
                "                <input type=\"radio\" name=\"star\" id=\"star5\"><label for=\"star5\"></label>\n" +
                "            </div>\n" +
                "        </div>\n" +
                "        <div class=\"sobreMim\">\n" +
                "            <p id=\"sobreMimTexto\">\n" +
                "                Insira o texto aqui!\n" +
                "            </p>\n" +
                "        </div>\n" +
                "        <iframe class=\"agenda\"\n" +
                "            src=\"https://calendar.google.com/calendar/embed?height=600&wkst=1&ctz=America%2FBahia&bgcolor=%23ffffff&showTitle=0&src=ZWMxMDA4M2U5YzU3NjBiZmEyYTUzNTM2NTQ1MmZkMzdhOThjNDkzMzIzODEzNjU5MWNhZmM0N2M2MGFkNTZhNUBncm91cC5jYWxlbmRhci5nb29nbGUuY29t&color=%23EF6C00\"\n" +
                "            style=\"border:solid 1px #777\" width=\"800\" height=\"600\" frameborder=\"0\" scrolling=\"no\"></iframe>\n" +
                "    </div>\n" +
                "    <script src=\"https://static.elfsight.com/platform/platform.js\" async></script>\n" +
                "    <div class=\"elfsight-app-f5ffc010-3838-4534-9cb4-6b66c1adb62f\" data-elfsight-app-lazy></div>\n" +
                "    <script>\n" +
                "        document.addEventListener('DOMContentLoaded', function () {\n" +
                "            const fotoPerfil = document.getElementById('fotoPerfil');\n" +
                "            const fileInput = document.getElementById('fileInput');\n" +
                "            const sobreMimTexto = document.getElementById('sobreMimTexto');\n" +
                "            if (localStorage.getItem('fotoPerfil')) {\n" +
                "                fotoPerfil.src = localStorage.getItem('fotoPerfil');\n" +
                "            }\n" +
                "            if (localStorage.getItem('sobreMimTexto')) {\n" +
                "                sobreMimTexto.innerHTML = localStorage.getItem('sobreMimTexto');\n" +
                "            }\n" +
                "            fotoPerfil.addEventListener('click', function () {\n" +
                "                fileInput.click();\n" +
                "            });\n" +
                "            fileInput.addEventListener('change', function (event) {\n" +
                "                const file = event.target.files[0];\n" +
                "                if (file) {\n" +
                "                    const reader = new FileReader();\n" +
                "                    reader.onload = function (e) {\n" +
                "                        fotoPerfil.src = e.target.result;\n" +
                "                        localStorage.setItem('fotoPerfil', e.target.result);\n" +
                "                    };\n" +
                "                    reader.readAsDataURL(file);\n" +
                "                }\n" +
                "            });\n" +
                "            sobreMimTexto.addEventListener('click', function () {\n" +
                "                const novoTexto = prompt('Edite o texto sobre você:', sobreMimTexto.innerHTML);\n" +
                "                if (novoTexto !== null) {\n" +
                "                    sobreMimTexto.innerHTML = novoTexto;\n" +
                "                    localStorage.setItem('sobreMimTexto', novoTexto);\n" +
                "                }\n" +
                "            });\n" +
                "        });\n" +
                "    </script>\n" +
                "</body>\n" +
                "</html>";

            // Cria o arquivo JSP na pasta templates
            try (FileWriter writer = new FileWriter(caminhoCompleto)) {
                writer.write(siteContent);
                out.println("Caminho completo do arquivo: " + caminhoCompleto);
                out.println("<p>Arquivo '" + nomeCadastro + ".jsp' criado com sucesso!</p>");
            } catch (IOException e) {
                out.println("<p>Erro ao criar o arquivo: " + e.getMessage() + "</p>");
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
        <form method="POST" action="">
            <h1>Criar conta</h1>
            <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>ou use seu email para cadastro</span>
            <input type="text" name="cadastroName" placeholder="Name" required />
            <input type="email" name="cadastroEmail" placeholder="Email" required />
            <input type="password" name="cadastroSenha" placeholder="Password" required />
            <button type="submit">Inscreva-se</button>
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
