
class User {
  //atributos
  String nome;
  String email;
  String senha;

  // construtor
  User({required this.nome, required this.email, required this.senha});

  // toMap
  // Método para criar um usuário a partir de um mapa
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }

  // fromMap
  // Método para converter o usuário em um mapa
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }
}
