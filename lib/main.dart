import 'package:flutter/material.dart';
import 'package:frontendapp/gradiente.dart';
import 'package:frontendapp/login.dart';
import 'package:frontendapp/registerOwner.dart';

import 'clubInformation.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RomeDance',
      debugShowCheckedModeBanner: false,
      home: club_page(),
    );
  }
}
