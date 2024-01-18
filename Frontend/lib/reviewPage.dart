import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/clubInformation.dart';
import 'package:frontend/globals.dart';
import 'Club.dart';
import 'Review.dart';
import 'colors.dart';

import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';


import 'package:http/http.dart' as http;


class review_page extends StatefulWidget {
  static String id = 'reviewPage';

  @override
  reviewPageState createState() => reviewPageState();
}

class reviewPageState extends State<review_page> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerClub(GlobalVariables.club);
    });
  }

  final TextEditingController _reviewController = TextEditingController();
  
  Club c = Club();


  Future<void> obtenerClub(String id) async {
    final response =
    await http.get(Uri.parse('http://192.168.56.1:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      c = Club(id: club["id"], name: club["name"], address: club["address"], userP: club["user_id"], m: club["monday_schedule"], t:club["tuesday_schedule"], w: club["wednesday_schedule"], th: club["thuesday_schedule"], f: club["friday_schedule"], s: club["saturday_schedule"], d: club["sunday_schedule"]);

    } else {
      throw Exception('Error getting the club');
    }
  }

  Future<void> addReview(Review r) async {
    final String apiUrl = 'http://192.168.56.1:8082/discos/add-review';


      var response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': r.userId,
          'discoId': r.clubId.toString(),
          'message': r.text,
          'photoUrl': "",
        }),
      );


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => club_page()),
        );

  }

  void submitReview() async {
    String reviewText = _reviewController.text;

    Review newReview = Review(
      userId: GlobalVariables.idUsuario,
      clubId: c.id,
      text: reviewText,
    );

    try {
      await addReview(newReview);
    } catch (e) {
      print('Error adding review: $e');
    }
  }



  Widget review(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write a Review',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 8,
                decoration: InputDecoration.collapsed(
                  hintText: 'Write your review here...',
                ),
                controller: _reviewController,
              ),
            ),
          ),

          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: submitReview,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenApp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
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

                  SizedBox(height: 20),
                  review(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

