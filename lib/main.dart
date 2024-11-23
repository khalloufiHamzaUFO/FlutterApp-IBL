import 'package:auth_app/ExternalViews/home_screen.dart';
import 'package:auth_app/InteriorViews/Chart.dart';
import 'package:auth_app/InteriorViews/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ExternalViews/welcome_screen.dart';
import 'InteriorViews/ListPage.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDS1JfSCMbzSh7TvWwwP9jD_3swwWUtZ9A",
      appId: "977901247120",
      messagingSenderId: "AAAA46902pA:APA91bF5YTGMXfE-t6UDDM38z1GlmcMF26JwfVKUkQ9Mu7AL5G9gVRPlEnVhirm5EipM1W5OvAgLeImjA2EBnlf8_MrBGeqLmMEEUsBUICh33uHXX-uOBlpKURbXbAJ5OBzG8CPpqfIw",
      projectId: "project-61f81",
    ),
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  MaterialColor mycolor = MaterialColor(Color.fromRGBO(4, 50, 72, 1.0).value, <int, Color>{
    50: Color.fromRGBO(0, 137, 123, 0.1),
    100: Color.fromRGBO(0, 137, 123, 0.2),
    200: Color.fromRGBO(0, 137, 123, 0.3),
    300: Color.fromRGBO(0, 137, 123, 0.4),
    400: Color.fromRGBO(0, 137, 123, 0.5),
    500: Color.fromRGBO(0, 137, 123, 0.6),
    600: Color.fromRGBO(0, 137, 123, 0.7),
    700: Color.fromRGBO(0, 137, 123, 0.8),
    800: Color.fromRGBO(0, 137, 123, 0.9),
    900: Color.fromRGBO(0, 137, 123, 1),
  },);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "IBL APP !",
      theme: ThemeData(
        buttonColor: Colors.white,
          primarySwatch: mycolor,
        textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),),
      home: WelcomeScreen()
    );
  }
}
