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

class editClub_page extends StatefulWidget {
  static String id = 'clubPage';

  @override
  editClubPageState createState() => editClubPageState();
}

class editClubPageState extends State<editClub_page> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController mController = TextEditingController();
  final TextEditingController tController = TextEditingController();
  final TextEditingController wController = TextEditingController();
  final TextEditingController thController = TextEditingController();
  final TextEditingController fController = TextEditingController();
  final TextEditingController sController = TextEditingController();
  final TextEditingController dController = TextEditingController();
  final List<List<TextEditingController>> ticketControllerMatrix = [];

/* Puedes agregar controladores dinámicamente según sea necesario
  ticketController.add(TextEditingController());
  ticketController.add(TextEditingController());*/

  Club miClub = Club();
  bool fav = false;

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
        await http.get(Uri.parse('http://192.168.1.33:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      setState(() {
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
      });
      /*photo = club["photo"];
      address = club["address"];
      m = club["mondaySchedule"];
      t = club["tuesdaySchedule"];
      w = club["wednesdaySchedule"];
      th = club["thursdaySchedule"];
      f = club["fridaySchedule"];
      s = club["saturdaySchedule"];
      d = club["sundaySchedule"];
      prices = club["ticketDtos"];*/
    } else {
      throw Exception('Error al obtener las playlists');
    }
  }

  Future<void> updateDisco(BuildContext context) async {
    final url = 'http://192.168.1.33:8082/discos/${GlobalVariables.club}';

    // Aquí deberías construir el cuerpo de la solicitud POST con los parámetros actualizados.
    // Puedes usar el método jsonEncode para convertir un mapa a una cadena JSON.
    final Map<String, dynamic> requestBody = {
      'name': _nombreController.text,
      'address': _addressController.text,
      'mondaySchedule': mController.text,
      'tuesdaySchedule': tController.text,
      'wednesdaySchedule': wController.text,
      'thursdaySchedule': thController.text,
      'fridaySchedule': fController.text,
      'saturdaySchedule': sController.text,
      'sundaySchedule': dController.text,
      'ticketDtos': ticketControllerMatrix.map((rowControllers) {
        return {
          'time': rowControllers[0].text,
          'price': rowControllers[1].text,
        };
      }).toList(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta según sea necesario.
        print('Datos actualizados con éxito');
        // Puedes agregar lógica adicional aquí, como navegar a otra pantalla o mostrar un mensaje de éxito.
      } else {
        // La solicitud no fue exitosa, maneja el error según sea necesario.
        print('Error al actualizar los datos: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja errores de red u otros errores aquí.
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerClub(GlobalVariables.club);
    });
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
                    'Edit the club information',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget changeName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: AppColors.greenApp),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: miClub.name,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              controller: _nombreController,
              onChanged: (value) {
                if (value.isEmpty) {
                  _nombreController.text = miClub.name;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget changeAddress() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: AppColors.greenApp),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: miClub.address,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              controller: _addressController,
              onChanged: (value) {
                if (value.isEmpty) {
                  _addressController.text = miClub.address;
                }
              },
            ),
          ],
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Timetable",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                buildDayRow("Monday", mController, miClub.m),
                buildDayRow("Tuesday", tController, miClub.t),
                buildDayRow("Wednesday", wController, miClub.w),
                buildDayRow("Thursday", thController, miClub.th),
                buildDayRow("Friday", fController, miClub.f),
                buildDayRow("Saturday", sController, miClub.s),
                buildDayRow("Sunday", dController, miClub.d),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDayRow(String day, TextEditingController controller, String hintText) {
    return Row(
      children: [
        Text(
          day,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            style: TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            controller: controller,
            onChanged: (value) {
              if (value.isEmpty) {
                controller.text = hintText;
              }
            },
          ),
        ),
      ],
    );
  }


  /* Widget tickets(BuildContext context) {
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: ticketInfo['time'],
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                controller: ticketController[index],
                                onChanged: (value) {

                                  if (value.isEmpty) {
                                    ticketController[index].text = ticketInfo['time'];
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 150,
                              child:TextField(
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: ticketInfo['price'],
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                controller: ticketController[index],
                                onChanged: (value) {

                                  if (value.isEmpty) {
                                    ticketController[index].text = ticketInfo['price'];
                                  }
                                },
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
  }*/

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
                  "Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 115),
                Text(
                  "Price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: miClub.prices.length,
              itemBuilder: (context, rowIndex) {
                Map<String, dynamic> ticketInfo = miClub.prices[rowIndex];

                // Agregar una nueva fila a la matriz de controladores de texto
                if (ticketControllerMatrix.length <= rowIndex) {
                  ticketControllerMatrix.add([
                    TextEditingController(text: ticketInfo['time']),
                    TextEditingController(text: ticketInfo['price']),
                  ]);
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Time',
                            hintStyle: TextStyle(
                              color: AppColors.greenApp,
                            ),
                          ),
                          controller: ticketControllerMatrix[rowIndex][0],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Price',
                            hintStyle: TextStyle(
                              color: AppColors.greenApp,
                            ),
                          ),
                          controller: ticketControllerMatrix[rowIndex][1],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          // Elimina la entrada correspondiente al índice actual
                          miClub.prices.removeAt(rowIndex);
                          ticketControllerMatrix.removeAt(rowIndex);
                        });
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController newTimeController =
                    TextEditingController();
                    TextEditingController newPriceController =
                    TextEditingController();

                    return AlertDialog(
                      title: Text(
                        'Add new Ticket',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      content: Column(
                        children: [
                          TextField(
                            controller: newTimeController,
                            decoration: InputDecoration(labelText: 'Time'),
                            onChanged: (value) {
                              // Puedes realizar acciones adicionales si es necesario
                            },
                          ),
                          TextField(
                            controller: newPriceController,
                            decoration: InputDecoration(labelText: 'Price'),
                            onChanged: (value) {
                              // Puedes realizar acciones adicionales si es necesario
                            },
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // Agregar un nuevo objeto a la lista de precios solo si ambos campos tienen contenido
                              String time = newTimeController.text;
                              String price = newPriceController.text;

                              if (time.isNotEmpty && price.isNotEmpty) {
                                miClub.prices.add({
                                  'time': time,
                                  'price': price,
                                });

                                // Agregar una nueva fila a la matriz de controladores de texto
                                ticketControllerMatrix.add([
                                  TextEditingController(text: time),
                                  TextEditingController(text: price),
                                ]);
                              }
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Add new ticket',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget commitChangesButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          updateDisco(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenApp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'Commit changes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
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
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  mainText(),
                  SizedBox(height: 20),
                  changeName(),
                  SizedBox(height: 10),
                  changeAddress(),
                  SizedBox(height: 10),
                  timetable(context),
                  SizedBox(height: 10),
                  tickets(context),
                  SizedBox(height: 10),
                  commitChangesButton(context),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
