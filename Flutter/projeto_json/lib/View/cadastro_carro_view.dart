import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarroCadastroScreen extends StatefulWidget {
  const CarroCadastroScreen({super.key});

  @override
  State<CarroCadastroScreen> createState() => _CarroCadastroScreenState();
}

class _CarroCadastroScreenState extends State<CarroCadastroScreen> {
  TextEditingController _placaController = TextEditingController();
  TextEditingController _modeloController = TextEditingController();
  File? _imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Carro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _placaController,
                    decoration: const InputDecoration(labelText: 'Placa'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Placa Não Pode Ser Vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _modeloController,
                    decoration: const InputDecoration(labelText: 'Modelo'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Placa Não Pode Ser Vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _imagemSelecionada != null
                      ? Image.file(
                          _imagemSelecionada!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: _tirarFoto,
                    child: Text('Tirar Foto'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Cadastrar"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }
}
