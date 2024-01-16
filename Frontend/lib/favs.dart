import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'globals.dart';

class fav_page extends StatefulWidget {
  static String id = 'favPage';

  @override
  favPageState createState() => favPageState();
}



class favPageState extends State<fav_page> {

  Future<List<dynamic>> obtenerClubs() async {
    final response = await http
        .get(Uri.parse('http://192.168.56.1:8082/discos/${GlobalVariables.idUsuario}'));
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
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Favorites',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
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
                    return Column(
                      children: [
                        GestureDetector(
                          child: buildClubWidget(
                            context,
                            clubData['photoUrl'],
                            clubData['name'],
                            clubData['address'],
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

  Widget buildClubWidget(BuildContext context, String photoUrl, String name, String address) {
    return club(
      context,
      photoUrl,
      name,
      address,
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
                  SizedBox(height: 20),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
