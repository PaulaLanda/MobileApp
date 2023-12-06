import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'mainPageClient.dart';



class editarPerfil_page extends StatefulWidget {
  static String id = 'editarPerfil_page';

  @override
  _editarPerfil createState() => _editarPerfil();
}

class _editarPerfil extends State<editarPerfil_page> {
  final TextEditingController _nombreController = TextEditingController();


  Widget atras(BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          mainPage_page()),
                );
              },
            ),
          ],
        ),
      ),
    );
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

  int selectedIndex = 3;
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
                  SizedBox(height: 10),
                  atras(context),
                  SizedBox(height: 40),
                  cambiarNom(),
                  SizedBox(height: 10),
                  cambiarContrasena(context),
                  SizedBox(height: 40),
                  guardarButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
