import 'package:flutter/material.dart';
import 'package:projeto_json/View/cadastro_carro_view.dart';
import 'package:projeto_json/View/listar_carros_view.dart';

import 'View/home_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loja Carros",
      theme: ThemeData(
        primarySwatch: Colors.grey
      ),
      home: HomeScreenPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/listar' : (context) => CarrosListarScreen(),
        '/cadastrar' :(context) => CarroCadastroScreen()

      },
    );
  }
}