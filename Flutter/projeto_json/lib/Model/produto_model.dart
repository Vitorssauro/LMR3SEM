class Produto {
  // atributos
  final int id;
  final String nome;
  final String descricao;
  final int quantidade;
  final String foto;
  final double preco;
  final List<String> categorias;

  // construtores
  Produto(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.quantidade,
      required this.foto,
      required this.preco,
      required this.categorias});

  // metodos (toJson/fromJson)

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'quantidade': quantidade,
        'foto': foto,
        'preco': preco,
        'categorias': categorias
      };

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      quantidade: json['quantidade'],
      foto: json['foto'],
      preco: json['preco'],
      categorias: List<String>.from(json['categorias']));
}
