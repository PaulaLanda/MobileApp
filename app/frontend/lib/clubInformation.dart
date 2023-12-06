import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/colors.dart';

class club_page extends StatefulWidget {
  static String id = 'clubPage';

  const club_page({super.key});

  @override
  clubPageState createState() => clubPageState();
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
      Positioned(
        top: 0,
        left: 0,
        child: IconButton(
          icon: const Icon(Icons.close, size: 30, color: Colors.redAccent),
          onPressed: () {
            // Lógica para cerrar la pantalla o realizar alguna acción al presionar el botón de cierre
          },
        ),
      ),
    ],
  );
}

Widget mainText() {
  return const SingleChildScrollView(
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
}

Widget map(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(
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
        const SizedBox(height: 10), // Espacio entre la imagen y el texto
        Container(
          child: const Row(
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
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.greenApp,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Row(
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
          )

        ],
      ),
    ),
  );
}

Widget tickets(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      padding: const EdgeInsets.all(15.0),
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
              const Text(
                "Tickets",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 20),
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
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
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
                          SizedBox(
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
                  const SizedBox(height: 10), // Espacio entre los bloques
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
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
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
                              SizedBox(
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
                  const SizedBox(height: 10), // Espacio entre los bloques
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
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
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
                              SizedBox(
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


            ],
          ),
        ],
      ),
    ),
  );
}

Widget addAReview(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextButton(
          onPressed: () => print("Review preses"),
          //Navigator.pushNamed(context, Registro.id);
          child: const Text(
            'Add a review!',
            style: TextStyle(
              color:Colors.black,
              fontSize: 18.0
            ),
          ),
        ),
      ],
    ),
  );
}

class clubPageState extends State<club_page> {
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
                  photo(context),
                  const SizedBox(height: 5),
                  mainText(),
                  const SizedBox(height: 5),
                  map(context),
                  const SizedBox(height: 5),
                  timetable(context),
                  const SizedBox(height: 8),
                  tickets(context),
                  const SizedBox(height: 8),
                  addAReview(context),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
