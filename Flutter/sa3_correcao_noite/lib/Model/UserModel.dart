class User {
  // Campos do usuário
  int? id;
  String nome;
  String email;
  String senha;

  // Construtor
  User({required this.nome, required this.email, required this.senha, id});

  // Cria um usuário a partir de um mapa
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }

  // Transforma um usuário em um mapa
  Map<String, dynamic> toMap() {
    return {
      'u_nome': nome,
      'u_email': email, 
      'u_senha': senha,
    };
  }
}
