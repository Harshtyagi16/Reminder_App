import "package:flutter/material.dart";
import 'package:one_page_to_another_page/model/todo.dart';
import 'package:one_page_to_another_page/screens/AddTodo.dart';
import 'package:one_page_to_another_page/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ToDoController())
    ], child: MaterialApp(title: "Reminder App", home: Home()));
  }
}
