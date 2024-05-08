import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_json/Controller/carros_controller.dart';

class CarrosListarScreen extends StatefulWidget {
  const CarrosListarScreen({super.key});

  @override
  State<CarrosListarScreen> createState() => _CarrosListarScreenState();
}

class _CarrosListarScreenState extends State<CarrosListarScreen> {
  CarrosController controller = CarrosController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Carros'),
        ),
        body: Padding(
            padding: EdgeInsets.all(12),
            child: Expanded(
              child: FutureBuilder(
                future: controller.loadCarrosFromFile(), 
                builder: (context,snapshot){
                  if(controller.carroList.isEmpty){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: controller.carroList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.file(File(controller.carroList[index].foto)),
                          title: Text(controller.carroList[index].modelo),
                          subtitle: Text(controller.carroList[index].marca),
                        );
                      },
                    );
                  }
                }),
            )));
  }
}
