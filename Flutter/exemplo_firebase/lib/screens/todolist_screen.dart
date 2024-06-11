import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({super.key, required this.user});

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
