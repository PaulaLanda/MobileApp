import 'package:flutter/material.dart';
import 'package:frontend/MessageData.dart';
import 'package:frontend/chat.dart';
import 'package:frontend/gradiente.dart';
import 'addNewClub.dart';
import 'camera.dart';
import 'changePassword.dart';
import 'chatScreen.dart';
import 'clubInformation.dart';
import 'ProperyInfoClub.dart';

import 'editClub.dart';
import 'editProfile.dart';
import 'galeria.dart';
import 'login.dart';
import 'reviewPage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MessageData messageData = MessageData(senderName: "Paula", message: "Hola", messageDate: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RomeDance',
      debugShowCheckedModeBanner: false,
      home: gradiente(),
    );
  }
}
