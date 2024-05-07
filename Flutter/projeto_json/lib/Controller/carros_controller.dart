import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../Model/carros_model.dart';

class CarrosController {
  List<Carro> _carroList = [];

  List<Carro> get carroList {
    return _carroList;
  }

  void addCarro(Carro carro) {
    _carroList.add(carro);
    saveCarrosToFile();
  }

  //Salva para o Jsonabelhaz
  Future<void> saveCarrosToFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    final file = File('$path/carros.json');
    final jsonList = _carroList.map((carro) => carro.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  //Buscar do Json
  Future<void> loadCarrosFromFile() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      final file = File('$path/carros.json');
      final jsonList = jsonDecode(await file.readAsString());
      _carroList = jsonList.map<Carro>((json) => Carro.fromJson(json)).toList();
    } catch (e) {
      _carroList = [];
    }
  }
}
