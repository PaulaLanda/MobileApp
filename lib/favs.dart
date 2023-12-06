import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class fav_page extends StatefulWidget {
  static String id = 'favPage';

  @override
  favPageState createState() => favPageState();
}

Widget mainText(){
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: EdgeInsets.only(left: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.keyboard_return, size: 20, color: Colors.black), // Icono de mensajes
          SizedBox(height: 10),
          Text(
            'Favorites',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    ),
  );
}



Widget club(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.greenApp,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    'https://via.placeholder.com/50/CCCCCC/000000?text=Placeholder',
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 150, // Ajusta el ancho máximo de la dirección
                      child:Text(
                        "Qubeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 150, // Ajusta el ancho máximo de la dirección
                      child: Text(
                        "direccionnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Distance: ",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "15 km",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Icon(Icons.favorite, size: 50, color: Colors.redAccent),
            ],
          ),
        ],
      ),
    ),
  );
}

class favPageState extends State<fav_page> {
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
                  SizedBox(height: 30),
                  mainText(),
                  SizedBox(height: 20),
                  club(context),
                  SizedBox(height: 20),
                  club(context),
                  SizedBox(height: 20),
                  club(context),
                  SizedBox(height: 20),
                  club(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
