import 'package:flutter/material.dart';
import 'package:todo_list/TarefasModel.dart';

class TarefasController extends ChangeNotifier {
// Lista de tarefas
  List<Tarefa> _tarefas = [];
// getter para acessar a lista
  List<Tarefa> get tarefas => _tarefas;

//Método para adicionar uma nova tarefa
  void adicionarTarefa(String descricao) {
    if (descricao.trim().isNotEmpty) {
      _tarefas.add(Tarefa(descricao, false));
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

// Método para marcar uma tarefa como concluída com base no índice
  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas[indice].concluida = true;
      // Notifica os ouvinter sobre a mudança no estado
      notifyListeners();
    }
  }

// Métodopara excluir uma tarefa com base no índice
  void excluirTarefa(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas.removeAt(indice);
      // Notifica os ouvinter sobre a mudança no estado
      notifyListeners();
    }
  }
}
