import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Controller/BDController.dart';
import '../Model/UserModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _loading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String senha = _senhaController.text;

      setState(() {
        _loading = true;
      });

      BancoDadosCrud bancoDados = BancoDadosCrud();
      try {
        User? user = await bancoDados.getUser(email, senha);
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfiguracoesPage(email: user.email),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Email ou senha incorretos'),
          ));
        }
      } catch (e) {
        print('Erro durante o login: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro durante o login. Tente novamente mais tarde.'),
        ));
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  } else if (!isValidEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text('Acessar'),
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()),
                  );
                },
                child: Text('Não tem uma conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}