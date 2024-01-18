import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/mainPageOwner.dart';

import 'package:image_picker/image_picker.dart';
import 'Club.dart';

import 'colors.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

import 'dart:convert';

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

  late ImagePicker _imagePicker;
  XFile? _image;

  Club miClub = Club();
  bool fav = false;

  @override
  void initState() {
    print("Hi" + GlobalVariables.idDisco.toString());
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerClub(GlobalVariables.idDisco.toString());
    });
  }

  Future<void> updateDisco(BuildContext context) async {
    final url = Uri.parse('http://192.168.56.1:8082/discos/update/${GlobalVariables.idDisco}');

    try {
      var headers = {'Content-Type': 'application/json'};
      var body = {
        'name': _nombreController.text.isEmpty ? miClub.name : _nombreController.text,
        'address': _addressController.text.isEmpty ? miClub.address : _addressController.text,
        'userEmail': GlobalVariables.user,
        'mondaySchedule': mController.text.isEmpty ? miClub.m : mController.text,
        'tuesdaySchedule': tController.text.isEmpty ? miClub.t : tController.text,
        'wednesdaySchedule': wController.text.isEmpty ? miClub.w : wController.text,
        'thursdaySchedule': thController.text.isEmpty ? miClub.th : thController.text,
        'fridaySchedule': fController.text.isEmpty ? miClub.f : fController.text,
        'saturdaySchedule': sController.text.isEmpty ? miClub.s : sController.text,
        'sundaySchedule': dController.text.isEmpty ? miClub.d : dController.text,
        'photoUrl': 'https://via.placeholder.com/200',
        'ticketDtos': ticketControllerMatrix.map((rowControllers) {
          return {
            'description': rowControllers[0].text.isNotEmpty ? rowControllers[0].text : miClub.prices[ticketControllerMatrix.indexOf(rowControllers)]['description'],
            'price': rowControllers[1].text.isNotEmpty ? rowControllers[1].text : miClub.prices[ticketControllerMatrix.indexOf(rowControllers)]['price'],
            'drinksNumber': rowControllers[2].text.isNotEmpty ? rowControllers[2].text : miClub.prices[ticketControllerMatrix.indexOf(rowControllers)]['drinksNumber'],
          };
        }).toList(),
      };

      var response = await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => mainPageOwner_page()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error in club update'),
            content: Text('Something went wrong, try again'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> obtenerClub(String id) async {
    final response =
    await http.get(Uri.parse('http://192.168.56.1:8082/discos/get/${GlobalVariables.idDisco}'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      setState(() {
        miClub = Club(
          name: club['name'],
          photo: club["photoUrl"],
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
      throw Exception('Error getting the clubs');
    }
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
                  color: Colors.black,
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
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 50),
                Text(
                  "Price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 50),
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

                if (ticketControllerMatrix.length <= rowIndex) {
                  ticketControllerMatrix.add([
                    TextEditingController(text: ticketInfo['description']),
                    TextEditingController(text: ticketInfo['price'].toString()),
                    TextEditingController(text: ticketInfo['drinksNumber'].toString()),
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
                            hintText: 'Description',
                            hintStyle: TextStyle(
                              color: Colors.grey,
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
                              color: Colors.grey,
                            ),
                          ),
                          controller: ticketControllerMatrix[rowIndex][1],
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
                            hintText: 'Drink number',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          controller: ticketControllerMatrix[rowIndex][2],
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
                    TextEditingController drinkController =
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
                            decoration: InputDecoration(labelText: 'Description'),
                            onChanged: (value) {
                             },
                          ),
                          TextField(
                            controller: newPriceController,
                            decoration: InputDecoration(labelText: 'Price'),
                            onChanged: (value) {
                            },
                          ),
                          TextField(
                            controller: drinkController,
                            decoration: InputDecoration(labelText: 'Drinks Number'),
                            onChanged: (value) {
                            },
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              String description = newTimeController.text;
                              String price = newPriceController.text;
                              String driks = drinkController.text;

                              if (description.isNotEmpty && price.isNotEmpty) {
                                miClub.prices.add({
                                  'description': description,
                                  'price': price,
                                  'drinksNumber': driks
                                });

                                ticketControllerMatrix.add([
                                  TextEditingController(text: description),
                                  TextEditingController(text: price),
                                  TextEditingController(text: driks),
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
