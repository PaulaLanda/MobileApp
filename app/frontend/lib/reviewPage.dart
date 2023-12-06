import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/colors.dart';

class review_page extends StatefulWidget {
  static String id = 'reviewPage';

  const review_page({super.key});

  @override
  reviewPageState createState() => reviewPageState();
}

Widget photo(BuildContext context) {
  return Stack(
    children: [
      Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20), // Padding horizontal de 20
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Bordes curvos de radio 20
          child: Image.network(
            'https://via.placeholder.com/500x500', // URL de la imagen
            fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
          ),
        ),
      ),
      const Positioned(
        top: 50,
        left: 30,
        right: 20,
        child: Text(
          'QUBEEEEEEEEEEEEEEEEEEE',
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
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alineación horizontal a la izquierda
      children: [
        const Text(
          'Write a Review',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 10), // Espacio entre el texto y el campo de entrada
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 8,
              decoration: const InputDecoration.collapsed(
                hintText: 'Write your review here...',
              ),
            ),
          ),
        ),
        const SizedBox(height: 10), // Espacio entre el campo de entrada y el botón
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Acción a realizar al presionar el botón "Submit"
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greenApp,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Text(
                'SUBMIT',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}




class reviewPageState extends State<review_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  photo(context),
                  const SizedBox(height: 20),
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
