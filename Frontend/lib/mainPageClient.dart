import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/chat.dart';
import 'package:frontend/editProfile.dart';
import 'package:frontend/favs.dart';
import 'colors.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'globals.dart';

class mainPage_page extends StatefulWidget {
  static String id = 'mainPage';

  @override
  mainPageState createState() => mainPageState();
}




class mainPageState extends State<mainPage_page> {
  String _usuario = "";
  Future<void> obtenerUsuario() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.33:8082/users/${GlobalVariables.user}'));
      if (response.statusCode == 200) {
        final dynamic user = json.decode(response.body);
        setState(() {
          _usuario = user['username'];
        });

      }
      else {
        throw Exception('Error al obtener el usuario');
      }
    } catch (error) {
      print('Error al obtener el usuario : $error');
    }
  }

  Future<dynamic> obtenerClub(String id) async {
    final response = await http.get(
        Uri.parse('http://192.168.1.33:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      return club;
    } else {
      throw Exception('Error al obtener el club');
    }
  }

  Future<List<dynamic>> obtenerClubs() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.33:8082/discos'));
    if (response.statusCode == 200) {
      final List<dynamic> clubs = jsonDecode(response.body);
      return clubs;
    } else {
      throw Exception('Error al obtener los clubs');
    }
  }

  Widget mainText(){
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Hi $_usuario',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.settings, size: 20, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => editarPerfil_page()),
                        );
                      },
                    ),

                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.favorite, size: 20, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => fav_page()),
                        );
                      },
                    ),

                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.message, size: 20, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => chat_page()),
                        );
                      },
                    ),

                  ],
                ),
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

  Widget club(BuildContext context, String photo, String name, String address) {
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      photo,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 150, // Ajusta el ancho máximo de la dirección
                        child:Text(
                          name,
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 150, // Ajusta el ancho máximo de la dirección
                        child: Text(
                          address,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Distance: ",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "15 km",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.favorite, size: 50, color: Colors.redAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget clubs(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        child: FutureBuilder<List<dynamic>>(
          future: obtenerClubs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error al obtener los clubs');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No hay clubs disponibles');
            } else {
              return Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!.map((clubData) {
                    return club(
                      context,
                      clubData['photo'],
                      clubData['name'],
                      clubData['address'],
                    );
                  }).toList(),
                ),
              );
            }
          },
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
                  SizedBox(height: 20),
                  clubs(context),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
