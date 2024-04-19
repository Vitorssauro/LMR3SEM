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
        final path = join(databasePath, 'tarefas_app.db');
        // Abre o banco de dados com a versão 1 e uma função onCreate para criar as tabelas
        return await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) {
                // Cria a tabela de usuários
                db.execute('''
                    CREATE TABLE usuarios (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        user TEXT UNIQUE NOT NULL,
                        senha TEXT NOT NULL
                    )
                ''');
                // Cria a tabela de tarefas
                db.execute('''
                    CREATE TABLE tarefas (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        userId INTEGER,
                        desc TEXT NOT NULL,
                        feito INTEGER NOT NULL,
                        FOREIGN KEY (userId) REFERENCES usuarios(id)
                    )
                ''');
            },
        );
    }

    // Funções para usuários

    // Cria um novo usuário com nome de usuário e senha fornecidos
    Future<int> createUser(String user, String senha) async {
        final db = await database;
        // Insere um novo usuário na tabela 'users' e retorna o ID do usuário criado
        final userId = await db.insert('usuarios', {'user': user, 'senha': senha});
        return userId;
    }

    // Obtém um usuário com base no nome de usuário e senha fornecidos
    Future<Map<String, dynamic>?> getUser(String user, String senha) async {
        final db = await database;
        // Consulta a tabela 'users' pelo nome de usuário e senha
        final List<Map<String, dynamic>> users = await db.query(
            'usuarios',
            where: 'user = ? AND senha = ?',
            whereArgs: [user, senha],
        );
        // Retorna o primeiro usuário encontrado ou null se nenhum foi encontrado
        return users.isNotEmpty ? users.first : null;
    }

    // Funções para tarefas

    // Cria uma nova tarefa com um ID de usuário e título fornecidos
    Future<void> createTarefa(int userId, String desc) async {
        final db = await database;
        // Insere uma nova tarefa na tabela 'tarefas' com userId e desc fornecidos
        await db.insert('tarefas', {'userId': userId, 'desc': desc, 'feito': 0});
    }

    // Obtém uma lista de tarefas para um usuário específico (userId)
    Future<List<Map<String, dynamic>>> getTarefas(int userId) async {
        final db = await database;
        // Consulta a tabela 'tarefas' pelo userId
        return await db.query('tarefas', where: 'userId = ?', whereArgs: [userId]);
    }

    // Atualiza o status de conclusão de uma tarefa específica
    Future<void> updateTarefa(int tarefaId, bool feito) async {
        final db = await database;
        // Atualiza o campo 'feito' da tarefa com tarefaId fornecido
        await db.update(
            'tarefas',
            {'feito': feito ? 1 : 0},
            where: 'id = ?',
            whereArgs: [tarefaId],
        );
    }

    // Exclui uma tarefa específica pelo ID da tarefa
    Future<void> deleteTarefa(int tarefaId) async {
        final db = await database;
        // Deleta a tarefa com tarefaId fornecido da tabela 'tarefas'
        await db.delete('tarefas', where: 'id = ?', whereArgs: [tarefaId]);
    }

    // Novo método para atualizar o título de uma tarefa específica
    Future<void> updateTarefaDesc(int tarefaId, String AttDesc) async {
        final db = await database;
        // Atualiza o campo 'desc' da tarefa com tarefaId fornecido
        await db.update(
            'tarefas',
            {'desc': AttDesc},
            where: 'id = ?',
            whereArgs: [tarefaId],
        );
    }
}
