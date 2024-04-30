import 'package:flutter/material.dart';

import 'View/lista_livros_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Livros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LivrosPage(),
    );
  }
}
