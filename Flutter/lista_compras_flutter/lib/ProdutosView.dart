import 'package:flutter/material.dart';
import 'package:lista_compras_flutter/ProdutosController.dart';
import 'package:provider/provider.dart';

class ProdutosScreen extends StatelessWidget {
  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      // Corpo principal do aplicativo
      body: Column(
        children: [
          // Campo de texto para adicionar novo produto
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome do Produto',
                    ),
                  ),
                ),
                SizedBox(width: 10), // Espaçamento entre os campos
                Expanded(
                  child: TextField(
                    controller: _precoController,
                    decoration: InputDecoration(
                      labelText: 'Preço',
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(width: 10), // Espaçamento entre os campos
                Expanded(
                  child: TextField(
                    controller: _quantidadeController,
                    decoration: InputDecoration(
                      labelText: 'Quantidade',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                // Ícone para adicionar produto ao pressionar o botão
                IconButton(
                  onPressed: () {
                    // Chamando o método adicionarProduto do Provider para atualizar o estado
                    Provider.of<ProdutosController>(context, listen: false)
                        .adicionarProduto(
                      _nomeController.text,
                      double.parse(_precoController.text),
                      int.parse(_quantidadeController.text),
                    );
                    // Limpar os campos de texto após adicionar o produto
                    _nomeController.clear();
                    _precoController.clear();
                    _quantidadeController.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          // Lista de produtos usando um Consumer do Provider para atualização automática
          Expanded(
            child: Consumer<ProdutosController>(
              builder: (context, model, child) {
                return DataTable(
                  columns: [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Preço')),
                    DataColumn(label: Text('Quantidade')),
                    DataColumn(label: Text('Ações')), // Coluna para ações
                  ],
                  rows: model.produtos.map((produto) {
                    // Obtém o índice do produto atual
                    final index = model.produtos.indexOf(produto);
                    return DataRow(
                      cells: [
                        DataCell(Text(produto.nome)),
                        DataCell(
                            Text('R\$ ${produto.preco.toStringAsFixed(2)}')),
                        DataCell(Text(produto.quantidade.toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Chamando o método alterarProduto do Provider para atualizar o estado
                                  Provider.of<ProdutosController>(context,
                                          listen: false)
                                      .adicionarProduto(
                                    _nomeController.text,
                                    double.parse(_precoController.text),
                                    int.parse(_quantidadeController.text),
                                  );
                                  // Limpar os campos de texto após adicionar o produto
                                  _nomeController.clear();
                                  _precoController.clear();
                                  _quantidadeController.clear();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Chama o método excluirProduto do ProdutosController, passando o índice do produto
                                  model.excluirProduto(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
