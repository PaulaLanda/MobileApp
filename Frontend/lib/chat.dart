import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Club.dart';
import 'colors.dart';

import 'package:http/http.dart' as http;

class chat_page extends StatefulWidget {
  static String id = 'chatPage';

  @override
  chatPageState createState() => chatPageState();
}



class chatPageState extends State<chat_page> {

  Club miClub = Club();

  Future<void> obtenerClub(String id) async {
    final response =
    await http.get(Uri.parse('http://192.168.1.2:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      setState(() {
        miClub = Club(
          name: club["name"],
          photo: club["photo"],
          address: club["address"],
          m: club["mondaySchedule"],
          t: club["tuesdaySchedule"],
          w: club["wednesdaySchedule"],
          th: club["thursdaySchedule"],
          f: club["fridaySchedule"],
          s: club["saturdaySchedule"],
          d: club["sundaySchedule"],
          prices: club["ticketDtos"],
        );
      });
    } else {
      throw Exception('Error al obtener las playlists');
    }
  }

  Widget mainText() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'Chats',
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget chat(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: AppColors.greenApp,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 150, // Ajusta el ancho máximo de la dirección
                        child: Text(
                          "Nombre",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.delete, size: 70, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
                  SizedBox(height: 30),
                  mainText(),
                  SizedBox(height: 30),
                  chat(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
