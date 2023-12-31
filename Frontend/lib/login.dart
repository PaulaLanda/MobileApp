import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    String url = 'http://192.168.1.33:8082/users/login';

    try {

      final response = await http.get(
        Uri.parse(url),
        /*body: {
         /* 'username': username,
          'password': password,*/
        },*/
      );
      if (response.statusCode == 200) {
        String responseBody = response.body;

        // Puedes imprimir los datos o hacer cualquier otra operación con ellos
        print('Datos recibidos: $responseBody');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => mainPage_page()),
        );
        /*int userExistsResult = int.parse(response.body);
        
        // Hacer algo con el resultado de userExists según sea necesario
        if (userExistsResult == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => mainPage_page()),
          );
        } else if (userExistsResult == 1){
          // Usuario no existe, mostrar un mensaje de error, por ejemplo
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Mail not registered'),
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
        }else if (userExistsResult == 2){
          // Usuario no existe, mostrar un mensaje de error, por ejemplo
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Incorrect password'),
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
        }*/
      } else {
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

  Widget olvidarContrasegna(BuildContext context){
    return Container(
      padding: EdgeInsets.only(left: 30),
      alignment: Alignment.centerLeft,
      child: TextButton(
          onPressed: () => print("Forgot Password pressed"),
          child: Text(
            'Forgot your password?',
            style: TextStyle(
              color:AppColors.greenApp,
            ),
          )
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
            onPressed: () => print("Registrarse preses"),
            //Navigator.pushNamed(context, Registro.id);
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
                  olvidarContrasegna(context),
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
