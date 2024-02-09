package View;

import java.util.List;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

import Connection.ToDoDAO;
import Controller.ToDoControl;

import java.awt.GridLayout;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;


import Model.TodoList;

public class ToDoPainel extends JPanel {
    // Atributos(componentes)
    private JButton criar, apagar, editar;
    private JTextField idField, tarefaField, statusField;
    private List<TodoList> todo;
    private JTable table;
    private DefaultTableModel tableModel;
    private int linhaSelecionada = -1;

    // Construtor(GUI-JPanel)
    public ToDoPainel() {
        super();
        // entrada de dados
        setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
        add(new JLabel("To Do List"));
        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new GridLayout(5, 2));
        inputPanel.add(new JLabel("ID"));
        idField = new JTextField(20);
        inputPanel.add(idField);
        inputPanel.add(new JLabel("Endereço"));
        tarefaField = new JTextField(20);
        inputPanel.add(tarefaField);
        inputPanel.add(new JLabel("Fone"));
        statusField = new JTextField(20);
        inputPanel.add(statusField);
        add(inputPanel);
        JPanel botoes = new JPanel();
        botoes.add(criar = new JButton("Criar"));
        botoes.add(editar = new JButton("Editar"));
        botoes.add(apagar = new JButton("Apagar"));
        add(botoes);
        // tabela de clientes
        JScrollPane jSPane = new JScrollPane();
        add(jSPane);
        tableModel = new DefaultTableModel(new Object[][] {},
                new String[] { "Nome", "Endereço", "Fone", "CPF"});
        table = new JTable(tableModel);
        jSPane.setViewportView(table);

        // criar o banco de dados
        new ToDoDAO().criaTabela();
        // executar o método de atualizar tabela
        atualizarTabela();
        // tratamento de eventos(construtor)
        
        //tratamento para click do mouse na tabela
        table.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent evt) {
                linhaSelecionada = table.rowAtPoint(evt.getPoint());
                if (linhaSelecionada != -1) {
                    idField.setText((String) table.getValueAt(linhaSelecionada, 0));
                    tarefaField.setText((String) table.getValueAt(linhaSelecionada, 1));
                    statusField.setText((String) table.getValueAt(linhaSelecionada, 2));
                }
            }
        });

        ToDoControl operacoes = new ToDoControl(clientes, tableModel, table);

        //tratamento para botão criar
        criar.addActionListener(e->{
            operacoes.criar(idField.getText(), tarefaField.getText(),
                                statusField.getText());
            idField.setText("");
            tarefaField.setText("");
            statusField.setText("");
        });

        //tratamento do botão editar
        editar.addActionListener(e->{
            operacoes.atualizar(idField.getText(), tarefaField.getText(),
                                statusField.getText());
            idField.setText("");
            tarefaField.setText("");
            statusField.setText("");
        });

        //tratamento do botão apagar
        apagar.addActionListener(e->{
            operacoes.apagar(idField.getText());
            idField.setText("");
            tarefaField.setText("");
            statusField.setText("");
        });


    }

    // métodos (atualizar tabela)
    // Método para atualizar a tabela de exibição com dados do banco de dados
    private void atualizarTabela() {
        tableModel.setRowCount(0); // Limpa todas as linhas existentes na tabela
        clientes = new ToDoDAO().listarTodos();
        // Obtém os clientes atualizados do banco de dados
        for (TodoList cliente : clientes) {
            // Adiciona os dados de cada cliente como uma nova linha na tabela Swing
            tableModel.addRow(new Object[] { cliente.getNome(), cliente.getEndereco(), cliente.getFone(), cliente.getCpf() });
        }
    }
}
