import 'package:auth_app/ExternalViews/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'LoginScreen.dart';


class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final auth = FirebaseAuth.instance;
  final _emailcontroller = TextEditingController();
  bool isvalid = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        leading:IconButton(
          icon: Icon(Icons.arrow_back_ios),
          hoverColor: Colors.black26,
          onPressed: () {
            // passing this to our root
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()),);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100,),
              Text(
                "Type your email address",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(
                        6, 52, 73, 1.0),
                ),
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Color.fromRGBO(
                        6, 52, 73, 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(
                            4, 50, 72, 1.0)),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(
                            255, 183, 5, 1.0)),
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {
                  isvalid = EmailValidator.validate(_emailcontroller.text);
                  if (isvalid) {
                    auth.sendPasswordResetEmail(email: _emailcontroller.text);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please Enter a valid Email",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Container(
                  width: width * 0.75,
                  height: 35,
                  child: Center(
                    child: Text(
                      "Send email",
                      style: TextStyle(color: Color.fromRGBO(
                          4, 50, 72, 1.0),fontSize: 20),
                    ),
                  ),
                ),
                color: Color.fromRGBO(
                    255, 183, 5, 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}