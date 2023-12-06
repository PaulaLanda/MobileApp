import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/colors.dart';

class Register_page extends StatefulWidget {
  static String id = 'Register_page';

  const Register_page({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

Widget textoInicial(){
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: const EdgeInsets.only(left: 20.0),
      child: const Column(
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
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color:AppColors.greenApp,),
        ),
      ),
      height: 40,
      child: const TextField(
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
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color:AppColors.greenApp,),
        ),
      ),
      height: 40,
      child: const TextField(
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
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColors.greenApp,),
        ),
      ),
      height: 40,
      child: const TextField(
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
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColors.greenApp,),
        ),
      ),
      height: 40,
      child: const TextField(
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
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => print("Iniciar sesión pressed"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenApp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Text(
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
        const Text(
          'Are you an owner?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        TextButton(
          onPressed: () => print("Registrarse preses"),
          //Navigator.pushNamed(context, Registro.id);
          child: const Text(
            'Sign up as owner',
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
        const Text(
          'Do you have account?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        TextButton(
          onPressed: () => print("Registrarse preses"),
          //Navigator.pushNamed(context, Registro.id);
          child: const Text(
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

class _RegisterPageState extends State<Register_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  const SizedBox(height: 100),
                  textoInicial(),
                  const SizedBox(height: 50),
                  buildEmail(),
                  const SizedBox(height: 20),
                  buildData(),
                  const SizedBox(height: 20),
                  buildContrasegna(),
                  const SizedBox(height: 20),
                  buildConfirmContrasegna(),
                  const SizedBox(height: 40),
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
