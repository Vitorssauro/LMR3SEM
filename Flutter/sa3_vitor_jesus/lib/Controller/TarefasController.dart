import 'DataBaseController.dart';

class TarefasController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Carrega as tarefas do usuário com base no filtro especificado
  Future<List<Map<String, dynamic>>> carregarTarefas(int userId, String filtro) async {
    // Carrega todas as tarefas do usuário
    List<Map<String, dynamic>> todasAsTarefas = await _dbHelper.getTarefas(userId);
    
    // Filtra as tarefas com base no estado de filtro
    if (filtro == "feitas") {
      return todasAsTarefas.where((tarefa) => tarefa['feito'] == 1).toList();
    } else if (filtro == "não feitas") {
      return todasAsTarefas.where((tarefa) => tarefa['feito'] == 0).toList();
    } else {
      return todasAsTarefas;
    }
  }

  // Adiciona uma nova tarefa ao banco de dados
  Future<void> adicionarTarefa(int userId, String desc) async {
    if (desc.isNotEmpty) {
      await _dbHelper.createTarefa(userId, desc);
    } else {
      throw Exception('Insira a descrição da tarefa');
    }
  }

  // Atualiza o status de conclusão de uma tarefa no banco de dados
  Future<void> atualizarTarefa(int tarefaId, bool feito) async {
    await _dbHelper.updateTarefa(tarefaId, feito);
  }

  // Exclui uma tarefa do banco de dados
  Future<void> excluirTarefa(int tarefaId) async {
    await _dbHelper.deleteTarefa(tarefaId);
  }

  // Atualiza a descrição de uma tarefa no banco de dados
  Future<void> atualizarTarefaDesc(int tarefaId, String novaDesc) async {
    await _dbHelper.updateTarefaDesc(tarefaId, novaDesc);
  }
}
