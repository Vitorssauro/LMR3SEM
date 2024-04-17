import 'package:flutter/material.dart';
import 'database_helper.dart';

class TaskScreen extends StatefulWidget {
    // O identificador do usuário é passado como parâmetro para carregar as tarefas do usuário específico
    final int userId;

    // Construtor para receber o userId
    const TaskScreen({required this.userId, Key? key}) : super(key: key);

    @override
    _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
    // Instância de DatabaseHelper para interagir com o banco de dados
    final DatabaseHelper _dbHelper = DatabaseHelper();
    // Controlador de texto para capturar a entrada da nova tarefa
    final TextEditingController _taskController = TextEditingController();
    // Lista de tarefas carregadas do banco de dados
    List<Map<String, dynamic>> _tasks = [];

    // Método de inicialização que carrega as tarefas do usuário
    @override
    void initState() {
        super.initState();
        _loadTasks();
    }

    // Carrega as tarefas do usuário a partir do banco de dados
    Future<void> _loadTasks() async {
        _tasks = await _dbHelper.getTasks(widget.userId);
        setState(() {});
    }

    // Adiciona uma nova tarefa ao banco de dados
    Future<void> _addTask() async {
        if (_taskController.text.isNotEmpty) {
            await _dbHelper.createTask(widget.userId, _taskController.text);
            _taskController.clear();
            _loadTasks();
        }
    }

    // Atualiza o status de conclusão de uma tarefa no banco de dados
    Future<void> _updateTask(int taskId, bool isDone) async {
        await _dbHelper.updateTask(taskId, isDone);
        _loadTasks();
    }

    // Exclui uma tarefa do banco de dados
    Future<void> _deleteTask(int taskId) async {
        await _dbHelper.deleteTask(taskId);
        _loadTasks();
    }

    // Função para editar uma tarefa
    Future<void> _editTask(int taskId, String currentTitle) async {
        // Mostra um diálogo para capturar o novo título da tarefa
        final TextEditingController editController = TextEditingController(text: currentTitle);

        final newTitle = await showDialog<String?>(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Editar Tarefa'),
                    content: TextField(
                        controller: editController,
                        decoration: const InputDecoration(labelText: 'Novo Título'),
                    ),
                    actions: [
                        // Botão para cancelar a edição
                        TextButton(
                            onPressed: () => Navigator.pop(context, null),
                            child: const Text('Cancelar'),
                        ),
                        // Botão para salvar a nova tarefa
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context, editController.text),
                            child: const Text('Salvar'),
                        ),
                    ],
                );
            },
        );

        // Se um novo título foi fornecido, atualize a tarefa
        if (newTitle != null && newTitle.isNotEmpty && newTitle != currentTitle) {
            await _dbHelper.updateTaskTitle(taskId, newTitle);
            _loadTasks();
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Lista de Tarefas'),
            ),
            body: Column(
                children: [
                    // Campo para adicionar uma nova tarefa
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: [
                                Expanded(
                                    child: TextField(
                                        controller: _taskController,
                                        decoration: const InputDecoration(
                                            labelText: 'Nova Tarefa',
                                        ),
                                    ),
                                ),
                                // Botão para adicionar a tarefa
                                IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: _addTask,
                                ),
                            ],
                        ),
                    ),
                    // Lista de tarefas
                    Expanded(
                        child: ListView.builder(
                            itemCount: _tasks.length,
                            itemBuilder: (context, index) {
                                final task = _tasks[index];
                                return ListTile(
                                    // Mostra o título da tarefa, riscado se a tarefa estiver concluída
                                    title: Text(
                                        task['title'],
                                        style: TextStyle(
                                            decoration: task['isDone'] == 1 ? TextDecoration.lineThrough : null,
                                        ),
                                    ),
                                    // Ao clicar na tarefa, inicia o processo de edição
                                    onTap: () {
                                        _editTask(task['id'], task['title']);
                                    },
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            // Botão para marcar a tarefa como concluída ou não concluída
                                            IconButton(
                                                icon: Icon(
                                                    task['isDone'] == 1 ? Icons.check_box : Icons.check_box_outline_blank,
                                                ),
                                                onPressed: () {
                                                    _updateTask(task['id'], task['isDone'] == 0);
                                                },
                                            ),
                                            // Botão para excluir a tarefa
                                            IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                    _deleteTask(task['id']);
                                                },
                                            ),
                                        ],
                                    ),
                                );
                            },
                        ),
                    ),
                ],
            ),
        );
    }
}
