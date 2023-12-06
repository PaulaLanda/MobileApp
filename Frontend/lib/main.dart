import 'package:flutter/material.dart';
import 'package:frontend/chat.dart';
import 'reviewPage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RomeDance',
      debugShowCheckedModeBanner: false,
      home: chat_page(),
    );
  }
}
