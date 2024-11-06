import java.io.FileWriter;
import java.io.IOException;

public class TemplateFactory {
    private String nome;

    public TemplateFactory() {
    }

    public TemplateFactory(String nome) {
        this.nome = nome;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String site() {
        return "<!DOCTYPE html>\n" +
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
                "            <h1 class=\"nomePerfil\">" + getNome() + "</h1>\n" +
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
    }

    public void gerarTemplate() {
        String nomeArquivo = getNome() + ".jsp";
        String url2 = "C:\\Users\\bebra\\OneDrive\\Documentos\\Faculdade\\Gestão do conhecimento\\projeto_maven\\src\\main\\webapp\\templates\\" + nomeArquivo;
        try (FileWriter writer = new FileWriter(url2)) {
            writer.write(site());
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("<script>alert('Erro ao salvar o perfil');</script>");
        }
    }
}
