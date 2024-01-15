import 'package:flutter/material.dart';
import 'package:frontend/login.dart';
import 'package:frontend/register.dart';

import 'colors.dart';

class gradiente extends StatelessWidget {
  static String id = 'gradiente_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF), // Color verde con cierta transparencia
              Color(0xFFFFFFFF), // Color blanco sólido
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Añade esta línea
          children: [
            Expanded( // Usa Expanded para que el contenedor ocupe todo el espacio disponible
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'DanceROMA',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Register_page()),);

                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenApp,
                      padding:
                      EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login_page()),);

                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenApp,
                      padding:
                      EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
