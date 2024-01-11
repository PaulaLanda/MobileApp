import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/globals.dart';
import 'colors.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class club_page extends StatefulWidget {
  static String id = 'clubPage';

  @override
  clubPageState createState() => clubPageState();
}

class clubPageState extends State<club_page> {
  String photo = "";
  String address = "";
  String m = "";
  String t = "";
  String w = "";
  String th = "";
  String f = "";
  String s = "";
  String d = "";

  List<dynamic> prices = [];

  Future<void> obtenerClub(String id) async {
    final response =
        await http.get(Uri.parse('http://192.168.1.33:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      photo = club["photo"];
      address = club["address"];
      m = club["mondaySchedule"];
      t = club["tuesdaySchedule"];
      w = club["wednesdaySchedule"];
      th = club["thursdaySchedule"];
      f = club["fridaySchedule"];
      s = club["saturdaySchedule"];
      d = club["sundaySchedule"];
      prices = club["ticketDtos"];
    } else {
      throw Exception('Error al obtener las playlists');
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerClub(GlobalVariables.club);
    });
  }

  Widget Photo(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context)
              .size
              .width, // Ancho igual al de la pantalla
          height: 250,
          child: Image.network(
            photo,
            fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: Icon(Icons.close, size: 30, color: Colors.redAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget mainText() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Text(
                  GlobalVariables.club,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.favorite, size: 33, color: Colors.black),
                  SizedBox(height: 10),
                  Icon(Icons.messenger, size: 33, color: Colors.black),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Address: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget map(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 20.0), // Padding horizontal de 20 en cada lado
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Image.network(
              'https://via.placeholder.com/500x500',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10), // Espacio entre la imagen y el texto
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Distance: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '15 km',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget timetable(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: AppColors.greenApp,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Timetable",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 20),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Monday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      m,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Tuesday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      t,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Wednesday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      w,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Thurday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      th,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Fiday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      f,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Saturday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      s,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Sunday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      d,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget tickets(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: AppColors.greenApp,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tickets",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: prices.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> ticketInfo = prices[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            ticketInfo['image'],
                            width: 25,
                            height: 25,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                ticketInfo['time'],
                                style: TextStyle(
                                  fontSize: 16,
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
                                ticketInfo['price'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Espacio entre los bloques
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget addAReview(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextButton(
            onPressed: () => print("Review preses"),
            //Navigator.pushNamed(context, Registro.id);
            child: Text(
              'Add a review!',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
          ),
        ],
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
                  Photo(context),
                  SizedBox(height: 5),
                  mainText(),
                  SizedBox(height: 5),
                  map(context),
                  SizedBox(height: 5),
                  timetable(context),
                  SizedBox(height: 8),
                  tickets(context),
                  SizedBox(height: 8),
                  addAReview(context),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
