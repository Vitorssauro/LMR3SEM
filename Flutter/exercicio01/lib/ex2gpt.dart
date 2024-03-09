import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exemplo Row & Column'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Exemplo de Row e Column',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.indigo),
                  SizedBox(width: 10),
                  Text('Item 1', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 20),
                  Icon(Icons.star, color: Colors.orange),
                  SizedBox(width: 10),
                  Text('Item 2', style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/image.png', width: 100, height: 100),
                  SizedBox(height: 10),
                  Text('Imagem de Exemplo'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.thumb_up, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Like', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 20),
                      Icon(Icons.comment, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Comentário', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
