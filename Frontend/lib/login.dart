import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/mainPageOwner.dart';
import 'package:frontend/register.dart';
import 'colors.dart';
import 'package:http/http.dart' as http;

import 'mainPageClient.dart';

class Login_page extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<Login_page> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String username = _emailController.text;
    String password = _passwordController.text;
    final url = Uri.parse('http://192.168.56.1:8082/users/login');
    print("Llegó aquí");

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    print("e");
    final Map<String, dynamic> data = {
      'user': username,
      'password': password,
    };
    print(data);
    try {
      print(username);
      final response =
      await http.post(url, headers: headers, body: json.encode(data));
      print("hola");
      print(response.statusCode);

      if (response.statusCode == 200) {

        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String userId = jsonResponse['id'].toString();

        // Almacena el id en la variable global
        GlobalVariables.idUsuario = userId;

        GlobalVariables.user = username;
        GlobalVariables.type = jsonResponse['userType'];

        if (GlobalVariables.type == "CLIENT"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => mainPage_page()),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => mainPageOwner_page()),
          );
        }

      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Something was wrong'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      // Manejar errores de conexión, etc.
    }
  }

  Widget textoInicial(){
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome again',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 30,
              ),
            ),
            Text(
              'Log in!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color:AppColors.greenApp,),
          ),
        ),
        height: 40,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'User',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _emailController,
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
            bottom: BorderSide(width: 1.0, color: AppColors.greenApp,),
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
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _passwordController,
        ),
      ),
    );
  }


  Widget iniciarSesionButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _login, // Llamar a la función _login al presionar el botón
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenApp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'LOG IN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget registerText(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Not account?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register_page()),
              );
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                color:AppColors.greenApp,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
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
                  SizedBox(height: 100),
                  textoInicial(),
                  SizedBox(height: 50),
                  buildEmail(),
                  SizedBox(height: 20),
                  buildContrasegna(),
                  SizedBox(height: 40),
                  iniciarSesionButton(context),
                  registerText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
