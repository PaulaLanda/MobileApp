
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/editClub.dart';
import 'package:frontend/globals.dart';
import 'Club.dart';
import 'User.dart';
import 'colors.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProperyInfoClub_page extends StatefulWidget {
  static String id = 'clubPage';

  @override
  ProperyInfoClubPageState createState() =>  ProperyInfoClubPageState();
}

class  ProperyInfoClubPageState extends State< ProperyInfoClub_page> {

  Club miClub = Club();
  User prop = User();
  /*String photo = "";
  String address = "";
  String m = "";
  String t = "";
  String w = "";
  String th = "";
  String f = "";
  String s = "";
  String d = "";

  List<dynamic> prices = [];*/

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
                    icon: Icon(Icons.edit, size: 33, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => editClub_page()),
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
                  timetable(context),
                  SizedBox(height: 8),
                  tickets(context),
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


/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'Club.dart';
import 'colors.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';

class editclub_page extends StatefulWidget {
  static String id = 'editclubPage';

  @override
  editclubPageState createState() => editclubPageState();
}

class TimetableEditDialog extends StatelessWidget {


  Club miClub = Club();
*/
/*String photo = "";
  String address = "";
  String m = "";
  String t = "";
  String w = "";
  String th = "";
  String f = "";
  String s = "";
  String d = "";

  List<dynamic> prices = [];*//*


  Future<void> obtenerClub(String id) async {
    final response =
    await http.get(Uri.parse('http://192.168.1.33:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);

        miClub = Club(
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

      */
/*photo = club["photo"];
      address = club["address"];
      m = club["mondaySchedule"];
      t = club["tuesdaySchedule"];
      w = club["wednesdaySchedule"];
      th = club["thursdaySchedule"];
      f = club["fridaySchedule"];
      s = club["saturdaySchedule"];
      d = club["sundaySchedule"];
      prices = club["ticketDtos"];*//*

    } else {
      throw Exception('Error al obtener el club');
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerClub(GlobalVariables.club);
    });
  }

  Widget photo(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width:
          MediaQuery.of(context).size.width, // Ancho igual al de la pantalla
          height: 250,
          child: Image.network(
            'https://via.placeholder.com/500x500', // URL de la imagen
            fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
          ),
        ),
      ],
    );
  }

  Widget mainText(BuildContext context) {
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
                  'Qubeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Envolver el ícono con un GestureDetector
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Controladores para los campos de texto
                      TextEditingController nameController =
                      TextEditingController();
                      TextEditingController addressController =
                      TextEditingController();

                      return AlertDialog(
                        title: Text('Club information'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Campo de texto para el nombre
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(labelText: 'Nombre'),
                            ),
                            SizedBox(height: 10), // Espacio entre campos de texto
                            // Campo de texto para la dirección
                            TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(labelText: 'Dirección'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              // Imprimir la información ingresada por el usuario
                              print('Name: ${nameController.text}');
                              print('Address: ${addressController.text}');

                              // Cerrar la ventana emergente
                              Navigator.of(context).pop();
                            },
                            child: Text('Guardar'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Cerrar la ventana emergente sin guardar
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.edit, size: 33, color: Colors.black),
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
                  'Calle santa maria ',
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

    */
/*return SingleChildScrollView(
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
                'Qubeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
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
                Icon(Icons.edit, size: 33, color: Colors.black),
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
                'Calle santa maria ',
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
  );*//*

  }

  Widget map(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 20.0), // Padding horizontal de 20 en cada lado
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                // Ejemplo con filas de "Monday - CLOSED" para demostración
                for (var i = 0; i < 7; i++)
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
                        "CLOSED",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(width: 50),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TimetableEditDialog();
                  },
                );
              },
              child: Icon(Icons.edit, size: 33, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Timetable'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Generar campos de texto por día para la ventana emergente
            for (var day in [
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday'
            ])
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100, // Ancho específico para el día
                      child: Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter data for $day',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
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
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
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
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
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
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
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
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
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
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
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
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
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
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(width: 50),
          Icon(Icons.edit, size: 33, color: Colors.black),

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tickets",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          'https://via.placeholder.com/50/CCCCCC/000000?text=Placeholder',
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
                              "Before 1:00 am",
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
                              "5€ - 1 cup",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espacio entre los bloques
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              'https://via.placeholder.com/50/CCCCCC/000000?text=Placeholder',
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
                                  "Before 1:00 am",
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
                                  "5€ - 1 cup",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Espacio entre los bloques
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              'https://via.placeholder.com/50/CCCCCC/000000?text=Placeholder',
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
                                  "Before 1:00 am",
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
                                  "5€ - 1 cup",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TicketsEditDialog();
                    },
                  );
                },
                child: Icon(Icons.edit, size: 33, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class TicketsEditDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit tickets'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Generar campos de texto por día para la ventana emergente
            for (var time in [
              'Before 1 am',
              'After 1 am',
            ])
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100, // Ancho específico para el tiempo
                      child: Text(
                        time,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            value: null, // Valor inicial establecido en null
                            items: List.generate(
                              10,
                                  (index) => DropdownMenuItem<String>(
                                value: '${index + 1} cup',
                                child: Text('${index + 1} cup'),
                              ),
                            ),
                            onChanged: (newValue) {
                              // Implementa la lógica aquí
                              print('Nuevo valor: $newValue');
                            },
                            decoration: InputDecoration(
                              hintText: 'Select quantity',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: '',
                            onChanged: (newValue) {
                              // Lógica para el valor ingresado manualmente
                              // Implementa la lógica aquí según tus necesidades
                              print('Nuevo valor manual para $time: $newValue');
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter price manually',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TicketInputDialog(); // Llama a la nueva ventana emergente
              },
            );
            print("Review pressed");
          },
          child: Text(
            'Add new ticket',
            style: TextStyle(color: AppColors.greenApp),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Save',
            style: TextStyle(color: AppColors.greenApp),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.greenApp),
          ),
        ),
      ],
    );
  }
}

class TicketInputDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String description = '';
    String cups = '';
    String price = '';

    return AlertDialog(
      title: Text('Add new ticket'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: null, // Valor inicial establecido en null
              items: List.generate(
                10,
                    (index) => DropdownMenuItem<String>(
                  value: '${index + 1} cup',
                  child: Text('${index + 1} cup'),
                ),
              ),
              onChanged: (newValue) {
                // Implementa la lógica aquí
                print('Nuevo valor: $newValue');
              },
              decoration: InputDecoration(
                hintText: 'Select quantity',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              onChanged: (value) {
                price = value;
              },
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print('Description: $description');
            print('Cups: $cups');
            print('Price: $price');
            Navigator.of(context).pop();
          },
          child: Text('Save',
            style: TextStyle(color: AppColors.greenApp),),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',
            style: TextStyle(color: AppColors.greenApp),),
        ),
      ],
    );
  }
}

class editclubPageState extends State<editclub_page> {
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
                  photo(context),
                  SizedBox(height: 5),
                  mainText(context),
                  SizedBox(height: 5),
                  //map(context),
                  SizedBox(height: 5),
                  timetable(context),
                  SizedBox(height: 8),
                  tickets(context),
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
*/
