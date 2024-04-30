class Livro {
  // atributos
  final String titulo;
  final String autor;
  final String sinopse;
  final String categoria;
  final int isbn;

  Livro(
      {required this.titulo,
      required this.autor,
      required this.sinopse,
      required this.categoria,
      required this.isbn});

  // métodos (mapeamento)
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'sinopse': sinopse,
      'categoria': categoria,
      'isbn': isbn
    };
  }

  factory Livro.fromJson(Map<String, dynamic> map) {
    return Livro(
      titulo: map['titulo'],
      autor: map['autor'],
      sinopse: map['sinopse'],
      categoria: map['categoria'],
      isbn: map['isbn'],
    );
  }
}
