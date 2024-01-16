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

  Club miClub = Club();
  bool fav = false;


  Future<void> obtenerClub(int id) async {
    final response =
        await http.get(Uri.parse('http://192.168.1.2:8082/discos/get/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
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

@override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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
                  miClub.name,
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

                  IconButton(
                    icon: Icon(Icons.favorite, size: 33, color: fav ? Colors.red : Colors.black,),
                    onPressed: () {
                      String clubId = miClub.id.toString();
                      String userId = GlobalVariables.idUsuario;

                      if(fav){
                        fav=false;
                        final response =
                         http.put(Uri.parse('http://192.168.1.2:8082/users/add-fav/$clubId/$userId'));
                      }
                      else{
                        fav=true;
                        final response =
                        http.put(Uri.parse('http://192.168.1.2:8082/users/delete-fav/$clubId/$userId'));

                      }
                      setState(() {

                      });
                    },
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
                Row(
                  children: [
                    Text(
                      "Monday: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      miClub.m,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Tuesday: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      miClub.t,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Wednesday: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      miClub.w,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Thurday: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      miClub.th,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Friday: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      miClub.f,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Saturday: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      miClub.s,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Sunday: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      miClub.d,
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
              itemCount: miClub.prices.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> ticketInfo = miClub.prices[index];

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
