import 'package:flutter/material.dart';
import 'package:segundo_parcial2/todo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tareas',
      home: TodoListPage(),
    );
  }
}
