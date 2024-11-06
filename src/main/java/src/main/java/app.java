package src.main.java;

import java.io.IOException;

public class app {
    public static void main(String[] args)  throws IOException {
        GeradorDeArquivos gerador = new GeradorDeArquivos();

        try {
            gerador.criarArquivo("AAA");
        } catch (IOException e) {
            System.err.println("Erro ao criar o arquivo: " + e.getMessage());
        }
    }
}
