import 'package:flutter/material.dart';
import 'package:projeto_api_geo/View/search_screen.dart';


import 'View/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Project API GEO",
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes:{
        '/search':(context) => const SearchScreen()        
      } ,
    );
  }
}