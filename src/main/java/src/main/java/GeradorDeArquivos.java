package src.main.java;

import java.io.FileWriter;
import java.io.IOException;

public class GeradorDeArquivos {
    public void criarArquivo(String nomeArquivo) throws IOException {
        // Construir o caminho completo do arquivo
        // Adapte o caminho base de acordo com a sua necessidade
        String caminhoCompleto = "C:\\Users\\bebra\\OneDrive\\Documentos\\Faculdade\\Gestão do conhecimento\\projeto_maven\\src\\main\\webapp\\templates" + nomeArquivo + ".txt";

        // Criar o arquivo
        try (FileWriter writer = new FileWriter(caminhoCompleto)) {
            // Escrever algo no arquivo (opcional)
            writer.write("Conteúdo inicial do arquivo");
        } catch (IOException e) {
            System.err.println("Erro ao criar o arquivo: " + e.getMessage());
            throw e; // Re-lançar a exceção para o método chamador
        }
    }
}