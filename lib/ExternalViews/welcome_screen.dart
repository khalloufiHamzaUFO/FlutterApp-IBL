import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LoginScreen.dart';
import 'RegistrationScreen.dart';

class WelcomeScreen extends StatefulWidget{
  WelcomeScreen({Key? key}) : super(key: key);
  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  Widget _submitButton() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 13),
            alignment: Alignment.center,

            decoration: BoxDecoration(

                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color.fromRGBO(143, 202, 230, 1.0).withAlpha(70),
                      offset: Offset(2, 4),
                      blurRadius: 8,
                      spreadRadius: 2)
                ],
                color: Color.fromRGBO(190, 205, 255, 1.0)),
            child: Text('Login',
                style: TextStyle(fontSize: 20, color: Color(0xff000000)))));
  }

  Widget _signUpButton() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 13),
            alignment: Alignment.center,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Color.fromRGBO(190, 205, 255, 1.0), width: 3),
            ),
            child: Text('Register now',
                style: TextStyle(fontSize: 20, color: Color.fromRGBO(
                    177, 190, 236, 1.0)))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Background.jpg"),
              fit: BoxFit.cover,
            ),),
          // SafeArea(
          child: Container(
            child: Column(
              children:<Widget> [
                SizedBox(height: 120,
                ),
                SizedBox(
                    height: 300,
                  child:
                      Image.asset(
                        'assets/RoundLogo.png',
                        height: 160,
                        width: 160,
                      )
                      ),
                Container(
                  //padding: EdgeInsets.only(top:25 ,left: 50,right: 50,bottom:25 ),
                  //   color: Colors.white,
                  child: Text('Welcome',style: GoogleFonts.secularOne
                    (fontSize: 30, fontWeight:FontWeight.bold,color: Color(
                      0xFFD9F3ED),),),
                  // Container(
                  //   //padding: EdgeInsets.only(top:25 ,left: 50,right: 50,bottom:25 ),
                  //   //   color: Colors.white,
                  //   child: Text('WELCOME.',style: GoogleFonts.abhayaLibre
                  //     (fontSize: 35, fontWeight:FontWeight.bold,color:  Color.fromRGBO(0, 137, 123, 0.2),),),
                  //
                  // ),
                ),
                SizedBox(height: 0),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30),
                          _submitButton(),
                          SizedBox(height: 15),
                          _signUpButton(),
                          SizedBox(
                            height: 20,
                          ),
                        ]
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}