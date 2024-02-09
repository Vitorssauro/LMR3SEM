package Model;

public class TodoList {
    // atributos
    private int id;
    private String tarefa;
    private String status;

    // construtores
    public TodoList(int id, String tarefa, String status, String cpf) {
        this.id = id;
        this.tarefa = tarefa;
        this.status = status;
    }

    // getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTarefa() {
        return tarefa;
    }

    public void setTarefa(String tarefa) {
        this.tarefa = tarefa;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
