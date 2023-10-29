import 'package:flutter/material.dart';
import 'package:trabalho_final/pages/home_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "To-Do List",
      home: HomePage(),
    );
  }
}
