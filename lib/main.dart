import 'package:flutter/material.dart';
import 'package:frontendapp/gradiente.dart';
import 'package:frontendapp/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decibely',
      debugShowCheckedModeBanner: false,
      home: Register_page(), // Suponiendo que Gradiente es el nombre de tu widget
    );
  }
}
