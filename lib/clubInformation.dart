import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/colors.dart';

class club_page extends StatefulWidget {
  static String id = 'clubPage';

  @override
  clubPageState createState() => clubPageState();
}

Widget photo(BuildContext context) {
  return Stack(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width, // Ancho igual al de la pantalla
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
          icon: Icon(Icons.close, size: 30, color: Colors.redAccent),
          onPressed: () {
            // Lógica para cerrar la pantalla o realizar alguna acción al presionar el botón de cierre
          },
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
                'Qubeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 80,
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
        SizedBox(height: 20),
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


class clubPageState extends State<club_page> {
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
                  SizedBox(height: 30),
                  mainText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
