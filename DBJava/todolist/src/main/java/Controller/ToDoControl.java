package Controller;

import java.util.List;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import Connection.ToDoDAO;
import Model.ToDo;

public class ToDoControl {

    // atributos
    private List<ToDo> todoList;
    private DefaultTableModel tableModel;
    private JTable table;

    // construtor
    public ToDoControl(List<ToDo> todoList, DefaultTableModel tableModel, JTable table) {
        this.todoList = todoList;
        this.tableModel = tableModel;
        this.table = table;
    }

    // métodos do modelo CRUD
    // Método para atualizar a tabela de exibição com dados do banco de dados
    private void atualizarTabela() {
        tableModel.setRowCount(0); // Limpa todas as linhas existentes na tabela
        todoList = new ToDoDAO().listarTodos();
        // Obtém os clientes atualizados do banco de dados
        for (ToDo todo : todoList) {
            // Adiciona os dados de cada cliente como uma nova linha na tabela Swing
            tableModel.addRow(new Object[] { todo.getId(), todo.getTarefa(),
                    todo.getStatus()});
        }
    }

    // Método para cadastrar um novo cliente no banco de dados
    public void cadastrar(int id, String tarefa, String status) {
        new ToDoDAO().cadastrar(id, tarefa, status);
        // Chama o método de cadastro no banco de dados
        atualizarTabela(); // Atualiza a tabela de exibição após o cadastro
    }

    // Método para atualizar os dados de um cliente no banco de dados
    public void atualizar(int id, String tarefa, String status) {
        new ToDoDAO().atualizar(id, status, tarefa, status)
        // Chama o método de atualização no banco de dados
        atualizarTabela(); // Atualiza a tabela de exibição após a atualização
    }

    // Método para apagar um cliente do banco de dados
    public void apagar(String cpf) {
        new ToDoDAO().apagar(cpf);
        // Chama o método de exclusão no banco de dados
        atualizarTabela(); // Atualiza a tabela de exibição após a exclusão
    }
}
