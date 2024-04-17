// Importação necessária para manipulação de banco de dados
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
    // Instância singleton de DatabaseHelper para reutilização em toda a aplicação
    static final DatabaseHelper _instance = DatabaseHelper._internal();

    // Construtor de fábrica que retorna a instância única (singleton)
    factory DatabaseHelper() => _instance;

    // Atributo para armazenar a instância do banco de dados
    Database? _database;

    // Construtor privado para garantir o padrão singleton
    DatabaseHelper._internal();

    // Método para obter a instância do banco de dados, cria se não existir
    Future<Database> get database async {
        if (_database != null) return _database!;
        _database = await _initDatabase();
        return _database!;
    }

    // Método para inicializar o banco de dados
    Future<Database> _initDatabase() async {
        // Obtém o caminho do banco de dados
        final databasePath = await getDatabasesPath();
        // Cria o caminho completo para o banco de dados
        final path = join(databasePath, 'tasks_app.db');
        // Abre o banco de dados com a versão 1 e uma função onCreate para criar as tabelas
        return await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) {
                // Cria a tabela de usuários
                db.execute('''
                    CREATE TABLE users (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        username TEXT UNIQUE NOT NULL,
                        password TEXT NOT NULL
                    )
                ''');
                // Cria a tabela de tarefas
                db.execute('''
                    CREATE TABLE tasks (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        userId INTEGER,
                        title TEXT NOT NULL,
                        isDone INTEGER NOT NULL,
                        FOREIGN KEY (userId) REFERENCES users(id)
                    )
                ''');
            },
        );
    }

    // Funções para usuários

    // Cria um novo usuário com nome de usuário e senha fornecidos
    Future<int> createUser(String username, String password) async {
        final db = await database;
        // Insere um novo usuário na tabela 'users' e retorna o ID do usuário criado
        final userId = await db.insert('users', {'username': username, 'password': password});
        return userId;
    }

    // Obtém um usuário com base no nome de usuário e senha fornecidos
    Future<Map<String, dynamic>?> getUser(String username, String password) async {
        final db = await database;
        // Consulta a tabela 'users' pelo nome de usuário e senha
        final List<Map<String, dynamic>> users = await db.query(
            'users',
            where: 'username = ? AND password = ?',
            whereArgs: [username, password],
        );
        // Retorna o primeiro usuário encontrado ou null se nenhum foi encontrado
        return users.isNotEmpty ? users.first : null;
    }

    // Funções para tarefas

    // Cria uma nova tarefa com um ID de usuário e título fornecidos
    Future<void> createTask(int userId, String title) async {
        final db = await database;
        // Insere uma nova tarefa na tabela 'tasks' com userId e title fornecidos
        await db.insert('tasks', {'userId': userId, 'title': title, 'isDone': 0});
    }

    // Obtém uma lista de tarefas para um usuário específico (userId)
    Future<List<Map<String, dynamic>>> getTasks(int userId) async {
        final db = await database;
        // Consulta a tabela 'tasks' pelo userId
        return await db.query('tasks', where: 'userId = ?', whereArgs: [userId]);
    }

    // Atualiza o status de conclusão de uma tarefa específica
    Future<void> updateTask(int taskId, bool isDone) async {
        final db = await database;
        // Atualiza o campo 'isDone' da tarefa com taskId fornecido
        await db.update(
            'tasks',
            {'isDone': isDone ? 1 : 0},
            where: 'id = ?',
            whereArgs: [taskId],
        );
    }

    // Exclui uma tarefa específica pelo ID da tarefa
    Future<void> deleteTask(int taskId) async {
        final db = await database;
        // Deleta a tarefa com taskId fornecido da tabela 'tasks'
        await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
    }

    // Novo método para atualizar o título de uma tarefa específica
    Future<void> updateTaskTitle(int taskId, String newTitle) async {
        final db = await database;
        // Atualiza o campo 'title' da tarefa com taskId fornecido
        await db.update(
            'tasks',
            {'title': newTitle},
            where: 'id = ?',
            whereArgs: [taskId],
        );
    }
}
