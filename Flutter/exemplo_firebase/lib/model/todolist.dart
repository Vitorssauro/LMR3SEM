class Todolist {
  //atributos
  final String id;
  final String titulo;
  final String userId;
  final DateTime timestamp;

  Todolist({required this.id, required this.titulo, required this.userId, required this.timestamp});

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'userId': userId,
      'timestamp': timestamp
    };
  }
  // fromMap
  factory Todolist.fromMap(Map<String, dynamic> map) {
    return Todolist(
      id: map['id'],
      titulo: map['titulo'],
      userId: map['userId'],
      timestamp: map['timestamp'],
    );
  }
}