import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/colors.dart';

class mainPage_page extends StatefulWidget {
  static String id = 'mainPage';

  @override
  mainPageState createState() => mainPageState();
}


Widget mainText(){
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: EdgeInsets.only(left: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Hi Luca!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 200),
              Icon(Icons.settings, size: 20, color: Colors.black), // Icono de ajustes
              SizedBox(width: 10), // Espacio entre el texto y el siguiente icono
              Icon(Icons.message, size: 20, color: Colors.black), // Icono de mensajes
            ],
          ),
          Text(
            'Where do you want to go today?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}


class mainPageState extends State<mainPage_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  SizedBox(width: 70),
                  mainText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
