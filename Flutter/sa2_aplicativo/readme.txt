// CRIAR MÉTODO TIPO BOOL

Future<bool> acesoInterno(user, senha) async {
    bool x = false;
    final Database db = await _getDatabase();
    var retorno = db.rawQuery("SELECT * FROM WHERE = 'user' and senha = 'senha' ");
    if (retorno > 0){
        x = true;
    }
    return x;
    // true or false
}