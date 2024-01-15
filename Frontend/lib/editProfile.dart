import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/gradiente.dart';
import 'changePassword.dart';
import 'colors.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'mainPageClient.dart';
import 'mainPageOwner.dart';



class editarPerfil_page extends StatefulWidget {
  static String id = 'editarPerfil_page';

  @override
  _editarPerfil createState() => _editarPerfil();
}

class _editarPerfil extends State<editarPerfil_page> {
  final TextEditingController _nombreController = TextEditingController();

  void changeName(String name) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://192.168.1.33:8082/users/update/${GlobalVariables.user}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'name': name,
        }),
      );
      if (response.statusCode == 200) {
        print('Nombre de usuario actualizado correctamente');
      } else {
        throw Exception('Error al actualizar el nombre de usuario');
      }
    } catch (error) {
      print('Error al actualizar el nombre de usuario: $error');
    }
  }


  Widget cambiarNom() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: AppColors.greenApp),
          ),
        ),
        height: 40,
        child: TextField(
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _nombreController,
        ),
      ),
    );
  }

  Widget cerrarSesion(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => gradiente()),);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenApp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'Log out',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
  Widget cambiarContrasena(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            recup_pswd()),
                  );
                },
                child: Text(
                  'Change password',
                  style: TextStyle(
                    color: AppColors.greenApp,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget guardarButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          String newName = _nombreController.text;
          if (newName.isNotEmpty) {
            changeName(newName);
          }

          if (GlobalVariables.type == "CLIENT"){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => mainPage_page()),);

          }else{
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => mainPageOwner_page()),);

          }

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
            color: Colors.white,
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
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  //SizedBox(height: 10),
                  //atras(context),
                  SizedBox(height: 40),
                  cambiarNom(),
                  SizedBox(height: 10),
                  cambiarContrasena(context),
                  SizedBox(height: 40),
                  guardarButton(context),
                  SizedBox(height: 10),
                  cerrarSesion(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
