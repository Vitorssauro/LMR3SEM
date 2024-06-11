import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: 'Email'),
                        validator: (value) {}),
                    TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: 'Senha'),
                        validator: (value) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _loginUser();
                        },
                        child: const Text("Login"))
                  ]))),
    ));
  }

  Future<User?> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      return await _auth.loginUsuario(
          _emailController.text, _passwordController.text);
    }
  }
}
