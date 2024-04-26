import 'package:path/path.dart';
import 'package:sa2_correcao/UserModel.dart';
import 'package:sqflite/sqflite.dart';

class BancoDadosCrud {
  static const String DB_NOME = 'users.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'users'; // Nome da tabela
  static const String
      SCRIPT_CRIACAO_TABELA = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY," +
          "nome TEXT, " +
          "email TEXT, " +
          "senha TEXT)";

  Future<Database> _chamarBanco() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            SCRIPT_CRIACAO_TABELA); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }

  // Método para criar um novo contato no banco de dados
  Future<void> create(User user) async {
    try {
      final Database db = await _chamarBanco();
      await db.insert(
          TABLE_NOME, user.toMap()); // Insere o contato no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // Método para buscar o user do banco de dados
  Future<User?> getUser(String email, String senha) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME,
          where: 'email = ? AND senha = ?',
          whereArgs: [email,senha]
          ); // Consulta todos os contatos na tabela

      if (maps.isNotEmpty){
        return User.fromMap(maps.first);
      }else{
        return null;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  //CRIAR UM MÉTODO DO TIPO BOOL
  Future<bool> existsUser(String email, String senha) async {
    bool acessoPermitido = false;
    try{
    final Database db = await _chamarBanco();
    final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME,
          where: 'email = ? AND senha = ?',
          whereArgs: [email,senha]
          ); // Consulta todos os contatos na tabela

      if (maps.isNotEmpty){
        acessoPermitido = true;
        return acessoPermitido;
      }else{
        return acessoPermitido;
      }
    } catch (ex) {
      print(ex);
      return acessoPermitido;
    }
  }
}
