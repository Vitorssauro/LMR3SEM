import 'package:flutter/material.dart';

import 'View/ProdutosView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo Json',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage(),
    );
  }
}
