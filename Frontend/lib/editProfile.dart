import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerUsuario();
    });
  }

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  String _usuario = "";
  String _surname = "";
  String _email = "";
  String _password = "";
  String _userType = "";

  Future<void> obtenerUsuario() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1:8082/users/${GlobalVariables.idUsuario}'));
      if (response.statusCode == 200) {
        final dynamic user = jsonDecode(response.body);
        setState(() {
          _usuario = user['body']['name'];
          _surname = user['body']['surname'];
          _email = user['body']['email'];
          _password = user['body']['password'];
          _userType = user['body']['userType'];
        });
        print('object');
      } else {
        throw Exception('Error al obtener el usuario');
      }
    } catch (error) {
      print('Error al obtener el usuario : $error');
    }
  }

  void changeInfo(String name, String surname) async {
    if (name.isEmpty) {
      name = _usuario;
    }
    if (surname.isEmpty) {
      surname = _surname;
    }

    try {
      final response = await http.put(
        Uri.parse(
            'http://192.168.56.1:8082/users/update/${GlobalVariables.idUsuario}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'name': name,
          'email': _email,
          'surname': surname,
          'password': _password,
          'userType': _userType
        }),
      );

      if (response.statusCode == 200) {
        if (GlobalVariables.type == 'OWNER') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => mainPageOwner_page()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => mainPage_page()),
          );
        }
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
            hintText: 'Name: $_usuario',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _nombreController,
        ),
      ),
    );
  }

  Widget cambiarSur() {
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
            hintText: 'Surname: $_surname',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _surnameController,
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => gradiente()),
          );
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
                        builder: (BuildContext context) => recup_pswd()),
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
          String newSurame = _surnameController.text;
          changeInfo(newName, newSurame);

          if (GlobalVariables.type == "CLIENT") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => mainPage_page()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => mainPageOwner_page()),
            );
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
                  cambiarSur(),
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
