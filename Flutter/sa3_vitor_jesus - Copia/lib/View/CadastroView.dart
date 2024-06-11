import 'package:flutter/material.dart';
import '../Controller/DataBaseController.dart';

class RegisterScreen extends StatefulWidget {
    const RegisterScreen({Key? key}) : super(key: key);

    @override
    _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    // Cria uma instância de DatabaseHelper para realizar operações de banco de dados
    final DatabaseHelper _dbHelper = DatabaseHelper();
    // Controladores de texto para capturar as entradas de nome de usuário, senha e confirmação de senha
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

    // Função para lidar com o processo de registro
    void _register() async {
        // Captura os valores de nome de usuário, senha e confirmação de senha dos campos de texto
        final username = _usernameController.text.trim();
        final password = _passwordController.text.trim();
        final confirmPassword = _confirmPasswordController.text.trim();

        // Verifica se o nome de usuário, senha ou confirmação de senha estão vazios
        if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preencha todos os campos.')),
            );
            return;
        }

        // Verifica se a senha e a confirmação de senha correspondem
        if (password != confirmPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('As senhas não conferem.')),
            );
            return;
        }

        try {
            // Cria um novo usuário no banco de dados com o nome de usuário e senha fornecidos
            await _dbHelper.createUser(username, password);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastro realizado com sucesso!')),
            );
            // Retorna para a tela anterior
            Navigator.pop(context);
        } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Falha ao se cadastrar. Tente novamente.')),
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Cadastro'),
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
                        // Campo de texto para capturar a confirmação de senha
                        TextField(
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(labelText: 'Confirmação da senha'),
                            obscureText: true, // Oculta o texto da senha para privacidade
                        ),
                        const SizedBox(height: 16.0),
                        // Botão para iniciar o processo de cadastro
                        ElevatedButton(
                            onPressed: _register,
                            child: const Text('Cadastrar'),
                        ),
                    ],
                ),
            ),
        );
    }
}
