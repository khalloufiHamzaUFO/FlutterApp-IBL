import 'package:auth_app/ExternalViews/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import '../ExternalViews/home_screen.dart';
import '../Models/user_model.dart';
import '../Widgets/profile.dart';
import 'ChangePass.dart';



class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: NewGradientAppBar(
          title: Text('Profile'),
          gradient: LinearGradient(colors: [Colors.black12,Colors.white,]),
          leading:Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);
                  },
                  tooltip: MaterialLocalizations
                      .of(context)
                      .openAppDrawerTooltip,);
              })
      ),
      body: Container(padding:EdgeInsets.only(left:30 ,right:30 ,top:30 ),
        child: ListView(
          children: <Widget> [
            Container(
              padding: new EdgeInsets.all(10.0),
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    ProfilePic(),
                    SizedBox(height:35,),
                    Text("General :",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),),
                    SizedBox(height: 10),
                    // Text("NAME :",
                    //   style: TextStyle(
                    //       fontSize: 18, fontWeight: FontWeight.w700),),

                    new Card(
                      margin: const EdgeInsets.fromLTRB(32.0,8.0,32.0,16.0),
                      color: Colors.grey[100],
                      shadowColor: Colors.black12,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon (
                              Icons.person,
                              color: Color.fromRGBO(
                                  255, 183, 5, 1.0),
                              size: 20,
                            ),
                            title: Text(
                              "Name",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                            ),
                            subtitle:  Text('${loggedInUser.firstName} ${loggedInUser.secondName}'),
                          ),
                        ],
                      ),),

                    new Card (
                      margin: const EdgeInsets.fromLTRB(32.0,8.0,32.0,16.0),
                      color: Colors.grey[100],
                      shadowColor: Colors.black12,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon (
                              Icons.email_outlined,
                              color: Color.fromRGBO(
                                  255, 183, 5, 1.0),
                              size: 20,
                            ),
                            title: Text(
                              "Email",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text('${loggedInUser.email}'),
                          ),
                        ],
                      ),
                    ),

                    Text("Settings :",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),),
                    SizedBox(height: 20),
                    Card (
                      margin: const EdgeInsets.fromLTRB(32.0,8.0,32.0,16.0),
                      color: Colors.grey[100],
                      shadowColor: Colors.black12,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              leading: Icon (
                                Icons.password,
                                color: Color.fromRGBO(
                                    255, 183, 5, 1.0),
                                size: 20,
                              ),
                              title: Text(
                                "Change password",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Color.fromRGBO(
                                      255, 183, 5, 1.0),
                                  size: 20),
                              onTap: () {
                                ChangePassword(context);
                              }
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card (
                      margin: const EdgeInsets.fromLTRB(32.0,8.0,32.0,16.0),
                      color: Colors.grey[100],
                      shadowColor: Colors.black12,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon (
                              Icons.logout,
                              color: Color.fromRGBO(
                                  255, 183, 5, 1.0),
                              size: 20,
                            ),
                            title: Text(
                              "Log Out",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),

                            ),
                            onTap: () {
                              logout(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Card (
                      margin: const EdgeInsets.fromLTRB(32.0,8.0,32.0,16.0),
                      color: Colors.grey[100],
                      shadowColor: Colors.black12,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon (
                              Icons.copyright_outlined,
                              color: Color.fromRGBO(
                                  5, 113, 255, 1.0),
                              size: 20,
                            ),
                            title: Text(
                              "Copyright © IBL Electronics",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),

                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),),
    );
  }

  //logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  //logout function
  Future<void> ChangePassword(BuildContext context) async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => ChangePass()));
  }
}
