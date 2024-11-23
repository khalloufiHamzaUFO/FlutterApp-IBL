import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Models/user_model.dart';
import 'LoginScreen.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  // our form key
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool passenable = false;
  bool _passenable = false;

  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        //hintText: "Enter your password",
        labelText: 'First name',
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFB705))),
        labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFFFFFF)),
        ),
      ),
    );

    //second name field
    final secondNameField = TextFormField(
      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Second Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        //hintText: "Enter your password",
        labelText: 'Second name',
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFB705))),
        labelStyle: TextStyle(
            fontSize: 20,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFFFFFFF)),
        ),
      ),
    );

    //email field
    final emailField = TextFormField(
      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        //prefixIcon: Icon(Icons.email_outlined),
        //hintText: "Enter your password",
        labelText: 'Email address',
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFB705))),
        labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFFFFFFF)),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
      autofocus: false,
      controller: passwordEditingController,
      obscureText: _passenable,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for sign up");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffix: IconButton(
            onPressed: (){ //add Icon button at end of TextField
              setState(() { //refresh UI
                if(_passenable){ //if passenable == true, make it false
                  _passenable = false;
                }else{
                  _passenable = true; //if passenable == false, make it true
                }
              });
            }, icon: Icon(_passenable == true?Icons.remove_red_eye:Icons.password)),
        //hintText: "Enter your password",
        labelText: 'Password',
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFB705))),
        labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFFFFFFF)),
        ),
      ),
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: passenable,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
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
        labelText: 'Confirme Password',
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFB705))),
        labelStyle: TextStyle(
            fontSize: 18,
            color:Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFFFFFF)),
        ),
      ),
    );

    Widget _signUpButton() {
      return InkWell(
          onTap: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Color(0xFFFFFFFF), width: 2),
              ),
              child: Text('Register now',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Color(
                      0xFFB8DFD8)))));
    }

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFFB8DFD8),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: 250,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: Text(
            "SIGN Up",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    Widget _submitButton() {
      return Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Sign up',
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  height: 1.6),
            ),
            SizedBox.fromSize(
              size: Size.square(70.0), // button width and height
              child: ClipOval(
                child: Material(
                  color:  Color(0xFFB8DFD8),
                  child: Icon(Icons.arrow_forward,
                      color: Colors.white), // button color
                ),
              ),
            ),
          ]),
        ),
      );
    }

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
                    height: 600,
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
                            padding: const EdgeInsets.all(36.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  firstNameField,
                                  SizedBox(height: 15),
                                  secondNameField,
                                  SizedBox(height: 15),
                                  emailField,
                                  SizedBox(height: 15),
                                  passwordField,
                                  SizedBox(height: 15),
                                  confirmPasswordField,
                                  SizedBox(height: 30),
                                  _signUpButton(),
                                  SizedBox(height: 70),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "You already have an account ?",
                                        style: TextStyle (fontSize: 16,
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()),
                                          );
                                        },
                                        child: Text(
                                          " Sign in.",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                              255, 183, 5, 1.0),
                                              //color: Color.fromRGBO(
                                              // 255, 183, 5, 1.0),
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
  }
}
