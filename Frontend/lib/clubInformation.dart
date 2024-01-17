import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/reviewPage.dart';
import 'Club.dart';
import 'chat.dart';
import 'colors.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class club_page extends StatefulWidget {
  static String id = 'clubPage';

  @override
  clubPageState createState() => clubPageState();
}

class clubPageState extends State<club_page> {

  List<dynamic> clubFavs = [];

  Club miClub = Club();
  bool fav = false;
  bool isFavorited = false;

  Future<void> obtenerClub(int id) async {
    final response =
        await http.get(Uri.parse('http://192.168.56.1:8082/discos/get/$id'));
    print("llego aquo");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      print("My club" );
      print(club);
      setState(() {
        miClub = Club(
          photo: club["photoUrl"],
          name: club["name"],
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
      throw Exception('Error getting current club info');
    }
  }

  Future<void> obtenerClubsFav() async {
    final response = await http
        .get(Uri.parse('http://192.168.56.1:8082/discos/${GlobalVariables.idUsuario}'));
    if (response.statusCode == 200) {
      final List<dynamic> favs = jsonDecode(response.body);
      print(favs);
      clubFavs = favs.map((fav) => fav['id']).toList();
      isFavorited = clubFavs.contains(GlobalVariables.idDisco);
      print(clubFavs);
    } else {
      throw Exception('Error al obtener los clubs');
    }
  }

@override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerClubsFav();
      obtenerClub(GlobalVariables.idDisco);
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
            miClub.photo,
            fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
          ),
        ),
        /*Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: Icon(Icons.close, size: 30, color: Colors.redAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),*/
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

                  GestureDetector(
                    onTap: () async {
                      if (isFavorited) {
                        print('http://192.168.56.1:8082/users/delete-fav/${GlobalVariables.idDisco}/${GlobalVariables.idUsuario}');
                        await http.get(Uri.parse('http://192.168.56.1:8082/users/delete-fav/${GlobalVariables.idDisco}/${GlobalVariables.idUsuario}'));
                        print("object");
                        isFavorited = false;
                      } else {
                        print('http://192.168.56.1:8082/users/add-fav/${GlobalVariables.idDisco}/${GlobalVariables.idUsuario}');
                        await http.get(Uri.parse('http://192.168.56.1:8082/users/add-fav/${GlobalVariables.idDisco}/${GlobalVariables.idUsuario}'));
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
                          size: 33,
                          color: isFavorited ? Colors.redAccent : Colors.black,
                        ),
                        IconButton(
                          icon: Icon(Icons.messenger, size: 33, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => chat_page()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
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
                  miClub.address,
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
                _buildTimetableRow("Monday", miClub.m),
                _buildTimetableRow("Tuesday", miClub.t),
                _buildTimetableRow("Wednesday", miClub.w),
                _buildTimetableRow("Thursday", miClub.th),
                _buildTimetableRow("Friday", miClub.f),
                _buildTimetableRow("Saturday", miClub.s),
                _buildTimetableRow("Sunday", miClub.d),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimetableRow(String day, String schedule) {
    return Row(
      children: [
        Text(
          day + ":",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(width: 10),
        Text(
          schedule,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
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
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "Descripcion",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 40),
                Text(
                  "Price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 70),
                Text(
                  "Drinks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: miClub.prices.length,
              itemBuilder: (context, rowIndex) {
                Map<String, dynamic> ticketInfo = miClub.prices[rowIndex];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          ticketInfo['description'],
                          style: TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          ticketInfo['price'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          ticketInfo['drinksNumber'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => review_page()),
              );
            },
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
