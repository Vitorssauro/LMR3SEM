import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'task_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Cria uma instância do DatabaseHelper para realizar operações de banco de dados
  final DatabaseHelper _dbHelper = DatabaseHelper();
  // Controladores de texto para capturar as entradas de nome de usuário e senha
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função para lidar com o processo de login
  void _login() async {
    // Captura os valores de nome de usuário e senha dos campos de texto
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Chama o método getUser para verificar as credenciais no banco de dados
    final user = await _dbHelper.getUser(username, password);
    
    if (user != null) {
      // Se o usuário for encontrado, extrai o ID do usuário
      final userId = user['id'];
      // Navega para a TaskScreen com o ID do usuário
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskScreen(userId: userId),
        ),
      );
    } else {
      // Se o usuário não for encontrado, exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nome de usuário ou senha incorretos.')),
      );
    }
  }

  // Função para navegar para a tela de cadastro
  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Cria uma coluna para organizar os widgets na tela
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de texto para capturar o nome de usuário
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Nome de usuário'),
            ),
            // Campo de texto para capturar a senha
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true, // Oculta o texto da senha para privacidade
            ),
            const SizedBox(height: 16.0),
            // Botão para iniciar o processo de login
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 8.0),
            // Botão para navegar para a tela de cadastro
            TextButton(
              onPressed: _navigateToRegister,
              child: const Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }
}
