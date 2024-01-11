import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'mainPageClient.dart';



class recup_pswd extends StatefulWidget {
  static String id = 'recupPswd_page';

  @override
  _recPswdPageState createState() => _recPswdPageState();
}

class _recPswdPageState extends State<recup_pswd> {

  final TextEditingController _psswdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Widget atras(BuildContext context){
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: AppColors.greenApp,
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }

  Widget textoInicial(){
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
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
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
            hintText: 'Nueva contraseña',
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
            hintText: 'Repetir nueva contraseña',
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

          if(password == passwordR){

          }else{
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error cambio de contraseña'),
                content: Text('Por favor, revisa que las contraseñas coinciden e inténtelo de nuevo.'),
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
          'Guardar cambios',
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
                  SizedBox(height: 40),
                  atras(context),
                  SizedBox(height: 50),
                  textoInicial(),
                  SizedBox(height: 50),
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
