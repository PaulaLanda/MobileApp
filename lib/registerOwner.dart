import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/colors.dart';

class RegisterOwner_page extends StatefulWidget {
  static String id = 'RegisterOwner_page';

  @override
  _RegisterOwnerPageState createState() => _RegisterOwnerPageState();
}

Widget textoInicial(){
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello Night Club Owner!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 60,
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
      ),
    ),
  );
}

Widget buildData() {
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
          hintText: 'Name and surname',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
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
      ),
    ),
  );
}

Widget buildConfirmContrasegna() {
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
          hintText: 'Verify your password',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}


Widget registerButton(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30.0),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => print("Iniciar sesión pressed"),
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

Widget clientText(BuildContext context) {
  return Container(
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Are you a client?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        TextButton(
          onPressed: () => print("Registrarse preses"),
          //Navigator.pushNamed(context, Registro.id);
          child: Text(
            'Sign up as client',
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
          onPressed: () => print("Registrarse preses"),
          //Navigator.pushNamed(context, Registro.id);
          child: Text(
            'Log in',
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

class _RegisterOwnerPageState extends State<RegisterOwner_page> {
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
                  buildData(),
                  SizedBox(height: 20),
                  buildContrasegna(),
                  SizedBox(height: 20),
                  buildConfirmContrasegna(),
                  SizedBox(height: 40),
                  registerButton(context),
                  clientText(context),
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
