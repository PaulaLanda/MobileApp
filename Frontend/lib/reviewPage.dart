import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/globals.dart';
import 'Club.dart';
import 'Review.dart';
import 'colors.dart';

import 'package:http/http.dart' as http;


class review_page extends StatefulWidget {
  static String id = 'reviewPage';

  @override
  reviewPageState createState() => reviewPageState();
}

class reviewPageState extends State<review_page> {


  final TextEditingController _reviewController = TextEditingController();

  String photo = "";
  Club c = Club();

  Future<void> obtenerClub(String id) async {
    final response =
    await http.get(Uri.parse('http://192.168.1.33:8082/discos/$id'));
    if (response.statusCode == 200) {
      final dynamic club = jsonDecode(response.body);
      c = Club(id: club["id"], name: club["name"], address: club["address"], userP: club["user_id"], m: club["monday_schedule"], t:club["tuesday_schedule"], w: club["wednesday_schedule"], th: club["thuesday_schedule"], f: club["friday_schedule"], s: club["saturday_schedule"], d: club["sunday_schedule"]);
      photo = club["photo"];
    } else {
      throw Exception('Error al obtener el club');
    }
  }

  Future<List<Review>> addReview(Club d, Review r) async {
    const String apiUrl = 'tu_url_api_aqui';

    final Map<String, dynamic> data = {
      'name': d.name,
      'review': {
        'user': r.userId,
        'club': r.clubId,
        'text':r.text,

      },
    };

    final response = await http.post(
      Uri.parse('$apiUrl/addReview'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      final List<Review> reviews = jsonResponse.map((data) => Review.fromJson(data)).toList();
      return reviews;
    } else {
      throw Exception('Failed to add review');
    }
  }

  void submitReview() async {

    String reviewText = _reviewController.text;

    Review newReview = Review(
      id: 0,
      userId: GlobalVariables.user,
      clubId: c.id, // Asigna el valor adecuado según tu lógica (puedes obtenerlo de alguna parte)
      mark: 5, // Asigna el valor adecuado según tu lógica (puedes obtenerlo de alguna parte)
      text: reviewText,
    );


    try {
      List<Review> reviews = await addReview(c, newReview);

      print('Review added successfully: $reviews');
    } catch (e) {
      print('Error adding review: $e');
    }
  }

  Widget Photo(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20), // Padding horizontal de 20
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Bordes curvos de radio 20
            child: Image.network(
              photo, // URL de la imagen
              fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 30,
          right: 20,
          child: Text(
            GlobalVariables.club,
            style: TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget review(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación horizontal a la izquierda
        children: [
          Text(
            'Write a Review',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10), // Espacio entre el texto y el campo de entrada
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
            ), // Mover este paréntesis al final del TextFormField
          ),

          SizedBox(height: 10), // Espacio entre el campo de entrada y el botón
          Center(
            child: ElevatedButton(
              onPressed: submitReview,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 20),
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
                  Photo(context),
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

