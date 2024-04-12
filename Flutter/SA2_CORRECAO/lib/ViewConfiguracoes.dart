import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ConfiguracoesScreen extends StatelessWidget {
  late String email;

  ConfiguracoesScreen({required String email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Teste Shared Preferences",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: ConfiguracoesPage(email));
  }
}

// ignore: must_be_immutable
class ConfiguracoesPage extends StatefulWidget {

  late String email;

  ConfiguracoesPage(String email);

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState(email);
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  //Atributos
    
  late SharedPreferences _prefs;
  bool $email_darkMode = false;
  
  _ConfiguracoesPageState(String email);

  //Métodos
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      $email_darkMode = _prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> _mudancaDarkMode() async {
    setState(() {
      $email_darkMode = !$email_darkMode;
    });
    await _prefs.setBool('darkMode', $email_darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: $email_darkMode
          ? ThemeData.dark()
          : ThemeData.light(), // Define o tema com base no modo escuro
      duration: Duration(milliseconds: 500), // Define a duração da transição
      child: Scaffold(
        appBar: AppBar(
          title: Text('Teste de Armazenamento Interno'),
        ),
        body: Center(
          child: Switch(
            value: $email_darkMode,
            onChanged: (value) {
              _mudancaDarkMode();
            },
          ),
        ),
      ),
    );
  }
}
