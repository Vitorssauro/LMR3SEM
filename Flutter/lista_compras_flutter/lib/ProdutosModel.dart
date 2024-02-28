class Produtos {
  String nome;
  double preco;
  int quantidade;
  bool comprado;

  Produtos(this.nome, this.preco, this.quantidade,
      {this.comprado =
          false}); // Adicionado o atributo comprado e inicializado como false
}
