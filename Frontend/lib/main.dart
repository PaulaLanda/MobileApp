import 'package:flutter/material.dart';
import 'package:frontend/chat.dart';
import 'changePassword.dart';
import 'editClub.dart';
import 'editProfile.dart';
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
      home: recup_pswd(),
    );
  }
}
