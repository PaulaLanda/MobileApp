import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/mainPageOwner.dart';
import 'colors.dart';
import 'globals.dart';
import 'mainPageClient.dart';
import 'package:http/http.dart' as http;

class recup_pswd extends StatefulWidget {
  static String id = 'recupPswd_page';

  @override
  _recPswdPageState createState() => _recPswdPageState();
}

class _recPswdPageState extends State<recup_pswd> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      obtenerUsuario();
    });
  }

  final TextEditingController _psswdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _currentController = TextEditingController();

  String _usuario = "";
  String _surname = "";
  String _email = "";
  String _password = "";
  String _userType = "";
  Future<void> obtenerUsuario() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.2:8082/users/${GlobalVariables.idUsuario}'));
      if (response.statusCode == 200) {
        final dynamic user = jsonDecode(response.body);
        setState(() {
          _usuario = user['body']['name'];
          _surname = user['body']['surname'];
          _email = user['body']['email'];
          _password = user['body']['password'];
          _userType = user['body']['userType'];
        });
      } else {
        throw Exception('Error al obtener el usuario');
      }
    } catch (error) {
      print('Error al obtener el usuario : $error');
    }
  }

  void changePass(String psswd) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://192.168.1.2:8082/users/update/${GlobalVariables.idUsuario}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'name': _usuario,
          'email': _email,
          'surname': _surname,
          'password': psswd,
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
        throw Exception('Error al actualizar la contraseña');
      }
    } catch (error) {
      print('Error al actualizar la contraseña: $error');
    }
  }

  Widget textoInicial() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Change password',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActContrasegna() {
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
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Current password',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _currentController,
        ),
      ),
    );
  }

  Widget buildContrasegna() {
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
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'New password',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _passwordController,
        ),
      ),
    );
  }

  Widget buildRContrasegna() {
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
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Repeat new password',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _psswdController,
        ),
      ),
    );
  }

  Widget CambioButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String passwordR = _psswdController.text;
          String password = _passwordController.text;
          String current = _currentController.text;
          if (_password == current) {
            if (password == passwordR) {
              changePass(password);
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Fail in password change'),
                  content: Text(
                      'Please try again, passwords do not match'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Fail in password change'),
                content: Text('Please try again, passwords do not match'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
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
                  SizedBox(height: 50),
                  textoInicial(),
                  SizedBox(height: 50),
                  buildActContrasegna(),
                  SizedBox(height: 20),
                  buildContrasegna(),
                  SizedBox(height: 20),
                  buildRContrasegna(),
                  SizedBox(height: 45),
                  CambioButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
