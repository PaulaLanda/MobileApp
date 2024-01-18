import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/chat.dart';
import 'package:frontend/editProfile.dart';
import 'package:frontend/favs.dart';
import 'ProperyInfoClub.dart';
import 'addNewClub.dart';
import 'colors.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'globals.dart';

class mainPageOwner_page extends StatefulWidget {
  static String id = 'mainPageOwner';

  @override
  mainPageOwnerState createState() => mainPageOwnerState();
}
class mainPageOwnerState extends State<mainPageOwner_page> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerUsuario();
    });
  }

  String _usuario = "";
  String _surname = "";
  Future<void> obtenerUsuario() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.2:8082/users/${GlobalVariables.idUsuario}'));
      if (response.statusCode == 200) {
        final dynamic user = jsonDecode(response.body);

        setState(() {
          _usuario = user['body']['name'];
          _surname = user['body']['surname'];
        });

      }
      else {
        throw Exception('Error getting the user');
      }
    } catch (error) {
      print('Error getting the user : $error');
    }
  }

  Future<List<dynamic>> obtenerClubs() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.2:8082/discos/${GlobalVariables.idUsuario}'));
    if (response.statusCode == 200) {
      final List<dynamic> clubs = jsonDecode(response.body);
      return clubs;
    } else {
      throw Exception('Error getting the clubs');
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
                    'Hi $_usuario $_surname',
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
                      icon: Icon(Icons.add, size: 20, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addClub_page()),
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
              'See your clubs',
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

  Widget club(BuildContext context, String name, String address, int id) {
    return GestureDetector(
        onTap: () {
      GlobalVariables.idDisco = id;
      GlobalVariables.club = name;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProperyInfoClub_page()),
      );
    },
    child: Container(
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
                        width: 150,
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
                        width: 150,
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
          ],
        ),
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
              return Text('Error getting the clubs');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No clubs available');
            } else {
              return Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!.map((clubData) {
                    return Column(
                      children: [
                        GestureDetector(
                          child: buildClubWidget(
                              context,
                              clubData['name'],
                              clubData['address'],
                              clubData['id']
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
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

  Widget buildClubWidget(BuildContext context, String name, String address, int id) {
    return club(
        context,
        name,
        address,
        id
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
