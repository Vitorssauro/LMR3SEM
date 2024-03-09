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
          title: Text('Container Example'),
        ),
        body: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Widget 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 50,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Widget 2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Widget 3',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
