import 'package:flutter/material.dart';
import 'package:sa3_vitor_jesus/Controller/TarefasController.dart';

class TarefasView extends StatefulWidget {
  final int userId;

  const TarefasView({required this.userId, Key? key}) : super(key: key);

  @override
  _TarefasViewState createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  final TarefasController _tarefasController = TarefasController();
  final TextEditingController _tarefaController = TextEditingController();
  List<Map<String, dynamic>> _tarefas = [];

  // Estado do filtro atual (todas, feitas, não feitas)
  String currentFilter = "todas";

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    // Carrega as tarefas do usuário com base no filtro atual
    _tarefas = await _tarefasController.carregarTarefas(widget.userId, currentFilter);
    setState(() {});
  }

  Future<void> _adicionarTarefa() async {
    try {
      await _tarefasController.adicionarTarefa(widget.userId, _tarefaController.text);
      _tarefaController.clear();
      _carregarTarefas();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira a descrição da tarefa')),
      );
    }
  }

  Future<void> _atualizarTarefa(int tarefaId, bool feito) async {
    await _tarefasController.atualizarTarefa(tarefaId, feito);
    _carregarTarefas();
  }

  Future<void> _excluirTarefa(int tarefaId) async {
    await _tarefasController.excluirTarefa(tarefaId);
    _carregarTarefas();
  }

  Future<void> _editarTarefa(int tarefaId, String currentDesc) async {
    final TextEditingController editController = TextEditingController(text: currentDesc);

    final newDesc = await showDialog<String?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Tarefa'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(labelText: 'Novo Título'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, editController.text),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (newDesc != null && newDesc.isNotEmpty && newDesc != currentDesc) {
      await _tarefasController.atualizarTarefaDesc(tarefaId, newDesc);
      _carregarTarefas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        actions: [
          // Menu suspenso para selecionar o estado de filtro
          DropdownButton<String>(
            value: currentFilter,
            items: const [
              DropdownMenuItem(value: 'todas', child: Text('Todas')),
              DropdownMenuItem(value: 'feitas', child: Text('Feitas')),
              DropdownMenuItem(value: 'não feitas', child: Text('Não feitas')),
            ],
            onChanged: (value) {
              // Atualiza o estado de filtro e recarrega as tarefas
              setState(() {
                currentFilter = value!;
              });
              _carregarTarefas();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tarefaController,
                    decoration: const InputDecoration(
                      labelText: 'Nova Tarefa',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _adicionarTarefa,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = _tarefas[index];
                return ListTile(
                  title: Text(
                    tarefa['desc'],
                    style: TextStyle(
                      decoration: tarefa['feito'] == 1 ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  onTap: () {
                    _editarTarefa(tarefa['id'], tarefa['desc']);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          tarefa['feito'] == 1 ? Icons.check_box : Icons.check_box_outline_blank,
                        ),
                        onPressed: () {
                          _atualizarTarefa(tarefa['id'], tarefa['feito'] == 0);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _excluirTarefa(tarefa['id']);
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
