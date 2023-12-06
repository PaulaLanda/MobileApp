import 'package:flutter/material.dart';
import 'package:frontendapp/reviewPage.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RomeDance',
      debugShowCheckedModeBanner: false,
      home: review_page(),
    );
  }
}
