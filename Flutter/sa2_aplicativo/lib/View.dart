
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Isso Tela de Login'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Usuário'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu usuário';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Senha'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira sua senha';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Aqui você pode adicionar a lógica de autenticação
                // Por exemplo, verificar o usuário e senha no backend
                // e navegar para a próxima tela se as credenciais estiverem corretas
                print('Usuário: $_username');
                print('Senha: $_password');
              }
            },
            child: Text('Entrar'),
          ),
          TextButton(
            onPressed: () {
              // Aqui você pode adicionar a navegação para a tela de registro
              print('Navegar para a tela de registro');
            },
            child: Text('Ou faça o cadastro'),
          ),
        ],
      ),
    );
  }
}
