class UserModel {
  // Campos do usuário
  final int id;
  final String username;
  final String password;

  // Construtor
  UserModel({
    required this.id,
    required this.username,
    required this.password,
  });

  // Cria um usuário a partir de um mapa
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }

  // Transforma um usuário em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
}
