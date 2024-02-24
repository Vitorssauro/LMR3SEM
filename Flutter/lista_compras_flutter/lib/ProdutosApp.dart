import 'package:flutter/material.dart';
import 'package:lista_compras_flutter/ProdutosController.dart';
import 'package:lista_compras_flutter/ProdutosView.dart';
import 'package:provider/provider.dart';

class ProdutosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definindo a tela inicial como a TarefaScreen
      home: ChangeNotifierProvider(
        create: (context) => ProdutosController(),
        child: ProdutosScreen(),
      ),
    );
  }
}
