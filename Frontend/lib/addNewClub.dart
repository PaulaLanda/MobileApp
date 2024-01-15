import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/reviewPage.dart';
import 'Club.dart';
import 'chat.dart';
import 'colors.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'dart:convert';


class addClub_page extends StatefulWidget {
  static String id = 'clubPage';

  @override
  addClubPageState createState() => addClubPageState();
}

class addClubPageState extends State<addClub_page> {
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


  Club miClub = Club();

  late ImagePicker _imagePicker;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _pickImage() async {
    try {
      XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _takePhoto() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    } catch (e) {
      print(e);
    }
  }

 /* Future<void> updateDisco(BuildContext context) async {
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
  }*/

  Future<void> updateDisco(BuildContext context) async {
    final url = 'http://192.168.1.33:8082/discos/${GlobalVariables.club}';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Agregar campos de texto al cuerpo de la solicitud
      request.fields['name'] = _nombreController.text;
      request.fields['address'] = _addressController.text;
      request.fields['mondaySchedule'] = mController.text;
      request.fields['tuesdaySchedule'] = tController.text;
      request.fields['wednesdaySchedule'] = wController.text;
      request.fields['thursdaySchedule'] = thController.text;
      request.fields['fridaySchedule'] = fController.text;
      request.fields['saturdaySchedule'] = sController.text;
      request.fields['sundaySchedule'] = dController.text;

      // Agregar la imagen al cuerpo de la solicitud como un campo de archivo
      if (_image != null) {
        var imageFile = await http.MultipartFile.fromPath(
          'photo',
          _image!.path,
          contentType: MediaType('image', 'jpeg'), // Ajusta el tipo de contenido según tu imagen
        );
        request.files.add(imageFile);
      } else {
        // Si la imagen está vacía, usa la URL de relleno
        request.fields['photo'] = 'https://via.placeholder.com/200';
      }

      // Agregar los datos del ticket al cuerpo de la solicitud
      request.fields['ticketDtos'] = jsonEncode(ticketControllerMatrix.map((rowControllers) {
        return {
          'time': rowControllers[0].text,
          'price': rowControllers[1].text,
        };
      }).toList());

      // Enviar la solicitud
      var response = await request.send();

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

  Widget addPhoto(BuildContext context) {
    return Row(
      children: [
        Container(
          height: _image == null ? 20.0 : 150.0,
          width: _image == null ? 150.0 : 150.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),

          child: Center(
            child: _image == null
                ? Text('No Image Selected')
                : Stack(
              children: [
                Image.file(File(_image!.path)),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _image = null;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Row(
          children: [
            FloatingActionButton(
              onPressed: _pickImage,
              tooltip: 'Select Image',
              child: Icon(
                Icons.add_photo_alternate_outlined,
                color: AppColors.greenApp,
                size: 40,
              ),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: _takePhoto,
              tooltip: 'Take Photo',
              child: Icon(
                Icons.camera_alt,
                color: AppColors.greenApp,
                size: 40,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ],
    );

  }

  Widget mainText() {
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
                    'Register a new club',
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

  Widget buildDayRow(
      String day, TextEditingController controller, String hintText) {
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
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
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
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
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
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
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
                  addPhoto(context),
                  SizedBox(height: 10),
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