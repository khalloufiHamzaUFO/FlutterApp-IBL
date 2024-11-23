import 'package:auth_app/InteriorViews/Setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ExternalViews/LoginScreen.dart';

class ChangePass extends StatefulWidget{
  @override
  _ChangePassState createState() => _ChangePassState();

}

class _ChangePassState extends State<ChangePass>{
  final _formkey = GlobalKey<FormState>();
  var newPassword = "";
  final newPasswordController = TextEditingController();
  bool passenable = false;

  @override
  void dispose(){
    newPasswordController.dispose();
    super.dispose();
  }
  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async {
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()),);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black12,
        content: Text('New password has been changed...Login again'),
      ));
    } catch (e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(6, 52, 73, 1.0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          hoverColor: Colors.black26,
          onPressed: () {
            // passing this to our root
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SettingsScreen()),);
          },
        ),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25 ),
          child: ListView(
            children: [
              SizedBox(height: 100 ),
              Padding(padding: const EdgeInsets.all(10)),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: true,
                  obscureText: passenable,
                  decoration: InputDecoration(
                    labelText: 'New Password ',
                    hintText: 'Enter new password ',
                    labelStyle: TextStyle(fontSize: 20),
                    border:OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red,fontSize: 15),
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
                  ),
                  controller: newPasswordController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter password';
                    }else if( value.length<6){
                      return'Enter a valid password (Min 6 charachters)';
                    }
                    return null ;
                  },
                ),
              ),
              ElevatedButton(onPressed:(){
                if(_formkey.currentState!.validate()){
                  setState(() {
                    newPassword = newPasswordController.text;
                  });
                  changePassword();
                }
              }, child: Text('Change Password',
                style: TextStyle(fontSize:18 )
              )
              )

            ],
          ),
        ),
      ),

    );
  }
}