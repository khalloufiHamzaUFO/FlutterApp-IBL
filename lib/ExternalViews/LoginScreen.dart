import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'RegistrationScreen.dart';
import 'ResetPassword.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  // editingCOntroller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _color1 =
  Color(0xFDFDFDFF); // Second `const` is optional in assignments.

  //firebaSe
  final _auth = FirebaseAuth.instance;
  bool passenable = false; //boolean value to track password view enable disable.

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        cursorColor: Color(0xFFB8DFD8),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter Your Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style:
        TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
        decoration: InputDecoration(
          //hintText: "Enter your email",
          labelText: 'Email',
          labelStyle: TextStyle(
              fontSize: 18,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFB705))),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFFFFF)),
          ),
        ));


    //Password Field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: passenable,
      controller: passwordController,

      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
      cursorColor: Color(0xFFB8DFD8),
      decoration: InputDecoration(
        suffix: IconButton(
          onPressed: (){ //add Icon button at end of TextField
          setState(() { //refresh UI
            if(passenable){ //if passenable == true, make it false
              passenable = false;
            }else{
              passenable = true; //if passenable == false, make it true
            }
          });
        }, icon: Icon(passenable == true?Icons.remove_red_eye:Icons.password)),
        //hintText: "Enter your password",
        labelText: 'Password',
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFB705))),
        labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFFFFFF)),
        ),
      ),
    );

    Widget _submitButton() {
      return InkWell(
          onTap: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.symmetric(vertical: 13),

              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[

                  ],
                  color: Color(0xFFB8DFD8)),
              child: Text('Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: Color(
                      0xFF000000)))));
    }

    //Buttom
    final loginButtom = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromRGBO(2, 74, 173, 1.0),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: 250.0,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Color(0xFFB8DFD8), fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 16,
                  color: Colors.black.withOpacity(0.2),
                )
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 20.0,
                    sigmaY: 20.0,
                  ),
                  child: Container(
                    height: 550,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.2),
                        )),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 36.0, right: 36, bottom: 36),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 80),
                                  emailField,
                                  SizedBox(height: 25),
                                  passwordField,
                                  SizedBox(height: 50),
                                  _submitButton(),
                                  SizedBox(height: 120),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Forget password ? ",
                                        style: TextStyle(
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPassword()),
                                          );
                                        },
                                        child: Text(
                                          "Reset",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 183, 5, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Don't have an account ? ",
                                        style: TextStyle(
                                            color:  Color.fromRGBO(255, 255, 255, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationScreen()),
                                          );
                                        },
                                        child: Text(
                                          " Sign up ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 183, 5, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
