package Model;

public class Clientes {
    // atributos
    private String nome;
    private String endereco;
    private String fone;
    private String cpf;

    // construtores
    public Clientes(String nome, String endereco, String fone, String cpf) {
        this.nome = nome;
        this.endereco = endereco;
        this.fone = fone;
        this.cpf = cpf;
    }

    // getters and setters
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getFone() {
        return fone;
    }

    public void setFone(String fone) {
        this.fone = fone;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

}
