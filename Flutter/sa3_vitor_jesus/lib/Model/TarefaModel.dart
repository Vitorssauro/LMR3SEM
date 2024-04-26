class TarefaModel {
  // Campos da tarefa
  final int id;
  final int userId;
  final String desc;
  final bool feito;

  // Construtor
  TarefaModel({
    required this.id,
    required this.userId,
    required this.desc,
    required this.feito,
  });

  // Cria uma tarefa a partir de um mapa
  factory TarefaModel.fromMap(Map<String, dynamic> map) {
    return TarefaModel(
      id: map['id'],
      userId: map['userId'],
      desc: map['desc'],
      feito: map['feito'] == 1,
    );
  }

  // Transforma uma tarefa em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'desc': desc,
      'feito': feito ? 1 : 0,
    };
  }
}
