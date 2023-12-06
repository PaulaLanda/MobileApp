import 'package:flutter/material.dart';

import 'colors.dart';

class gradiente extends StatelessWidget {
  static String id = 'gradiente_page';

  const gradiente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.greenApp, // Color verde con cierta transparencia
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
                  const Text(
                    'DanceROMA',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color:AppColors.greenApp,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color:AppColors.greenApp,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
