import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'globals.dart';
import 'mainPageClient.dart';
import 'mainPageOwner.dart';

class Register_ok extends StatefulWidget {
  static String id = 'Register_ok_page';

  @override
  _Register_okPageState createState() => _Register_okPageState();
}

Widget textSuccesfully(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Registered Successfully',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          'Welcome!',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 40,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}


Widget buttonOk(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30.0),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => (GlobalVariables.type == "CLIENT")
                ? mainPage_page()
                : mainPageOwner_page(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenApp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        'Continue',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
  );
}


class _Register_okPageState extends State<Register_ok> {
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
                  SizedBox(height: 200),
                  textSuccesfully(),
                  SizedBox(height: 50),
                  buttonOk(context),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}