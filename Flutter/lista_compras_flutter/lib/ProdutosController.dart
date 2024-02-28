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

// Método para marcar um produto como comprado com base no índice
  void marcarComoComprado(int indice) {
    if (indice >= 0 && indice < _produtos.length) {
      if (_produtos[indice].comprado) {
        _produtos[indice].comprado = false;
      } else {
        _produtos[indice].comprado = true;
      }
      // Notifica os ouvinter sobre a mudança no estado
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
}
