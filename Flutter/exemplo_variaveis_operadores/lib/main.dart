// import 'package:flutter/material.dart';

// void main() {
//   // declarando e inicializando variáveis
//   String nome = "João";
//   int idade = 25;
//   double alutra = 1.75;
//   bool estudnte = true;

//   // Imprimindo variáveis
//   print("Nome: $nome");
//   print("Idade: $idade");
//   print("Altura: $alutra metros");
//   print("Estudante: $estudnte");
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exemplo de Frase'),
        ),
        body: Center(
          child: Text(
            'Olá, mundo!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
