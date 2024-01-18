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
import 'package:geolocator/geolocator.dart';
import 'globals.dart';
import 'package:permission_handler/permission_handler.dart';


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
      obtenerClubsFav();
      await obtenerUserCoordinates();
    });
  }

  String _usuario = "";
  String _surname = "";
  String _userCoordinates = "";
  List<dynamic> clubFavs = [];

  Future<void> obtenerUserCoordinates() async {
    // Solicitar permisos de ubicación
    var status = await Permission.location.request();

    if (status.isGranted) {
      print("Cojo cordenadas");
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _userCoordinates =
          'Latitud: ${position.latitude}, Longitud: ${position.longitude}';
        });
      } catch (error) {
        print('Error al obtener las coordenadas del usuario: $error');
      }
    } else {
      print('Permiso de ubicación denegado');
    }
  }

  Future<void> obtenerUsuario() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1:8082/users/${GlobalVariables.idUsuario}'));
      if (response.statusCode == 200) {
        final dynamic user = jsonDecode(response.body);
        setState(() {
          _usuario = user['body']['name'];
          _surname = user['body']['surname'];
        });
        print("object" + _usuario + _surname);
      }
      else {
        throw Exception('Error al obtener el usuario');
      }
    } catch (error) {
      print('Error al obtener el usuario : $error');
    }
  }

  Future<void> obtenerClubsFav() async {
    final response = await http
        .get(Uri.parse('http://192.168.56.1:8082/discos/${GlobalVariables.idUsuario}'));
    if (response.statusCode == 200) {
      final List<dynamic> favs = jsonDecode(response.body);
      print(favs);
      clubFavs = favs.map((fav) => fav['id']).toList();
      print(clubFavs);
    } else {
      throw Exception('Error al obtener los clubs');
    }
  }

  Future<dynamic> obtenerClub(String id) async {
    final response = await http.get(
        Uri.parse('http://192.168.56.1:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      print("Club " + club);
      return club;
    } else {
      throw Exception('Error al obtener el club');
    }
  }

  Future<List<dynamic>> obtenerClubs() async {
    final response = await http
        .get(Uri.parse('http://192.168.56.1:8082/discos'));
    if (response.statusCode == 200) {
      print("Llego a coger clubs");
      final List<dynamic> clubs = jsonDecode(response.body);
      print(clubs);
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
            Text(
              'User Coordinates: $_userCoordinates',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget club(BuildContext context,  String name, String address, int id) {
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
                    print('http://192.168.56.1:8082/users/delete-fav/${id}/${GlobalVariables.idUsuario}');
                    await http.get(Uri.parse('http://192.168.56.1:8082/users/delete-fav/${id}/${GlobalVariables.idUsuario}'));
                    print("object");
                    isFavorited = false;
                  } else {
                    print('http://192.168.56.1:8082/users/add-fav/${id}/${GlobalVariables.idUsuario}');
                    await http.get(Uri.parse('http://192.168.56.1:8082/users/add-fav/${id}/${GlobalVariables.idUsuario}'));
                    print("object");
                    isFavorited = true;
                  }
                  // Actualizar la lista de favoritos después de agregar/quitar
                  await obtenerClubsFav();
                  // Actualizar el estado para reflejar cambios en la interfaz de usuario
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

  Widget buildClubWidget(BuildContext context, String name, String address, int id) {
    return club(
        context,
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
              return Text('Error al obtener los clubs');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No hay clubs disponibles');
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
