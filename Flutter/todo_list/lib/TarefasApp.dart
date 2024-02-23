import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/TarefasController.dart';
import 'package:todo_list/TarefasView.dart';

class TarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definindo a tela inicial como a TarefaScreen
      home: ChangeNotifierProvider(
        create: (context) => TarefasController(),
        child: TarefasScreen(),
      ),
    );
  }
}
