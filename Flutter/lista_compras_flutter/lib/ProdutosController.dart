import 'package:flutter/material.dart';
import 'package:lista_compras_flutter/ProdutosModel.dart';

class ProdutosController extends ChangeNotifier {
  // Lista de produtos
  List<Produtos> _produtos = [];

  // Getter para acessar a lista
  List<Produtos> get produtos => _produtos;

  // Método para adicionar um novo produto
  void adicionarProduto(String nome, double preco, int quantidade) {
    if (nome.trim().isNotEmpty) {
      _produtos.add(Produtos(nome, preco, quantidade));
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  // Método para excluir um produto com base no índice
  void excluirProduto(int indice) {
    if (indice >= 0 && indice < _produtos.length) {
      _produtos.removeAt(indice);
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  // Variáveis para armazenar os detalhes do produto em edição
  String _nomeEmEdicao;
  double _precoEmEdicao;
  int _quantidadeEmEdicao;

  // Método para iniciar a edição de um produto existente
  void iniciarEdicaoProduto(Produtos produto) {
    _nomeEmEdicao = produto.nome;
    _precoEmEdicao = produto.preco;
    _quantidadeEmEdicao = produto.quantidade;
  }

  // Método para adicionar ou atualizar um produto
  void alterarProduto() {
    if (_nomeEmEdicao != null) {
      if (_estaEditando) {
        // Atualiza o produto existente
        atualizarProduto(_indiceProdutoEditado, _nomeEmEdicao, _precoEmEdicao,
            _quantidadeEmEdicao);
        // Reinicia o estado de edição
        _estaEditando = false;
        _indiceProdutoEditado = null;
      } else {
        // Adiciona um novo produto
        adicionarProduto(_nomeEmEdicao, _precoEmEdicao, _quantidadeEmEdicao);
      }
      // Limpa os detalhes do produto em edição
      _limparDetalhesEdicao();
    }
  }

  // Método para limpar os detalhes do produto em edição
  void _limparDetalhesEdicao() {
    _nomeEmEdicao = null;
    _precoEmEdicao = null;
    _quantidadeEmEdicao = null;
  }
}
