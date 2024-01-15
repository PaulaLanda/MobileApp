import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/login.dart';
import 'package:frontend/registerOk.dart';
import 'package:frontend/registerOwner.dart';
import 'colors.dart';
import 'globals.dart';

import 'package:http/http.dart' as http;

import 'mainPageClient.dart';
import 'mainPageOwner.dart';

class Register_page extends StatefulWidget {
  static String id = 'Register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register_page> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> register() async {
    String username = _emailController.text;
    String password = _passwordController.text;
    String name = _emailController.text;
    String surname = _passwordController.text;
    final url = Uri.parse('http://192.168.56.1:8082/users/register');
    print("Llegó aquí");

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> data = {
      'name': name,
      'email': username,
      'surname': surname,
      'password': password,
      'userType': "CLIENT",
    };

    try {
      final response =
          await http.post(url, headers: headers, body: json.encode(data));

      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String userId = jsonResponse['id'].toString();

        // Almacena el id en la variable global
        GlobalVariables.idUsuario = userId;

        GlobalVariables.user = username;
        GlobalVariables.type = "CLIENT";

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Register_ok()),
        );
      } else if (response.statusCode == 500) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('A user with this email already exist'),
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

  Widget textoInicial() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello,',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 30,
              ),
            ),
            Text(
              'Sign up!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
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
            bottom: BorderSide(
              width: 1.0,
              color: AppColors.greenApp,
            ),
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

  Widget buildName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: AppColors.greenApp,
            ),
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
            hintText: 'Name',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _nameController,
        ),
      ),
    );
  }

  Widget buildSurname() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: AppColors.greenApp,
            ),
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
            hintText: 'Surname',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _surnameController,
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
            bottom: BorderSide(
              width: 1.0,
              color: AppColors.greenApp,
            ),
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

  Widget registerButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: register,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenApp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'REGISTER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget ownerText(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Are you an owner?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterOwner_page()),
              );
            },
            child: Text(
              'Sign up as owner',
              style: TextStyle(
                color: AppColors.greenApp,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginText(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Do you have account?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login_page()),
              );
            },
            child: Text(
              'Log in',
              style: TextStyle(
                color: AppColors.greenApp,
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
                  buildName(),
                  SizedBox(height: 20),
                  buildSurname(),
                  SizedBox(height: 20),
                  buildContrasegna(),
                  SizedBox(height: 20),
                  registerButton(context),
                  ownerText(context),
                  loginText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
