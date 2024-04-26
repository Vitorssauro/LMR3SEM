import 'dart:convert';
import 'dart:io';

import '../Model/produto_model.dart';

class ProdutoController {
  // atributo
  List<Produto> _produtos = [];

  // método get
  List<Produto> get produtos {
    return _produtos;
  }

  // Método set
  set produtos(List<Produto> produtos) {
    produtos = produtos;
  }

  // Salvar produtos no Json
  Future<void> salvarJson() async {
    final file = File('produtos.json');
    final jsonList = produtos.map((produtos) => produtos.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  // Carregar produtos do Json
  Future<List> carregarJson() async {
    try {
      final file = File('produtos.json');
      final jsonList = jsonDecode(await file.readAsString());
      _produtos =
          jsonList.map<Produto>((json) => Produto.fromJson(json)).toList();
    } catch (e) {
      _produtos = [];
    }
    return _produtos;
  }
}
