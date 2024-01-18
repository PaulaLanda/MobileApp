import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/chat.dart';
import 'package:frontend/editProfile.dart';
import 'package:frontend/favs.dart';
import 'clubInformation.dart';
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

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerUsuario();
      print("success");
      obtenerClubsFav();
    });
  }

  String _usuario = "";
  String _surname = "";
  List<dynamic> clubFavs = [];

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
        print("object" + _usuario + _surname);
      }
      else {
        throw Exception('Error getting the user');
      }
    } catch (error) {
      print('Error al obtener el usuario : $error');
    }
  }

  Future<void> obtenerClubsFav() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.2:8082/discos/${GlobalVariables.idUsuario}'));
    if (response.statusCode == 200) {
      final List<dynamic> favs = jsonDecode(response.body);
      print(favs);
      clubFavs = favs.map((fav) => fav['id']).toList();
      print(clubFavs);
    } else {
      throw Exception('1: Error getting the clubs');
    }
  }

  Future<dynamic> obtenerClub(String id) async {
    final response = await http.get(
        Uri.parse('http://192.168.1.2:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      return club;
    } else {
      throw Exception('Error getting the club');
    }
  }

  Future<List<dynamic>> obtenerClubs() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.2:8082/discos'));
    print('http://192.168.1.2:8082/discos');
    print(response.statusCode);
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

  Widget club(BuildContext context, String photo, String name, String address, int id) {
    bool isFavorited = clubFavs.contains(id);


    return GestureDetector(
      onTap: () {
        GlobalVariables.idDisco = id;
        GlobalVariables.club = name;

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => club_page()),
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
                          width: 150,
                          child: Text(
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
              GestureDetector(
                onTap: () async {
                  if (isFavorited) {
                    await http.get(Uri.parse('http://192.168.1.2:8082/users/delete-fav/${id}/${GlobalVariables.idUsuario}'));
                    isFavorited = false;
                  } else {
                    await http.get(Uri.parse('http://192.168.1.2:8082/users/add-fav/${id}/${GlobalVariables.idUsuario}'));
                    isFavorited = true;
                  }
                  await obtenerClubsFav();
                  setState(() {});
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      size: 50,
                      color: isFavorited ? Colors.redAccent : Colors.black,
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

  Widget buildClubWidget(BuildContext context, String photoUrl, String name, String address, int id) {
    return club(
        context,
        photoUrl,
        name,
        address,
        id
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
              return Text('${snapshot.error}');
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
                            clubData['photoUrl'],
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
