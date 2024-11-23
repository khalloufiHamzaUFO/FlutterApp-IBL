import 'package:flutter/material.dart';
import '../Widgets/CatigoryW.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(196, 194, 194, 0.30196078431372547),
      body: Column(
        children: [
          Stack(
            children: [
              Transform.rotate(
                origin: Offset(30, -60),
                angle: 2.4,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 75,
                    top: 40,
                  ),
                  height: 440,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: [Color(0xff063449), Color(0xFF239FBC)],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back ...',
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = LinearGradient(
                              colors: <Color>[
                                Color(0xfffb8602),
                                Color(0xffffb705),
                                Color(0xffffb705)
                                //add more color here.
                              ],
                            ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Here s some of the informations about cards we re working on',
                        style: new TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                            // foreground: Paint()..shader = LinearGradient(
                            //   colors:
                              // <Color>[
                              //   Colors.pinkAccent,
                              //   Colors.deepPurpleAccent,
                              //   Colors.indigoAccent
                              //   //add more color here.
                              // ],
                            // ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                image: 'Cartes/Icon1.png',
                                text: 'CALEARO : 1314336',
                                subText: 'Leading time : 10m 5s',
                                subTitle: 'TRS : 99.514%',
                                color: Color(0xFF043248),
                              ),
                              CatigoryW(
                                image: 'Cartes/Icon2.png',
                                text: 'CALEARO : 131418801',
                                subText: 'Leading time : 15m 18s',
                                subTitle: 'TRS : 99.622%',
                                color: Color(0xFF043248),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                image: 'Cartes/Icon3.png',
                                text: 'CALEARO : 131419802',
                                subText: 'Leading time : 16m 06s',
                                subTitle: 'TRS : 99.974%',
                                color: Color(0xFF043248),
                              ),
                              CatigoryW(
                                image: 'Cartes/Icon4.png',
                                text: 'CALEARO : 131420802',
                                subText: 'Leading time : 12m 17s',
                                subTitle: 'TRS : 99.873%',
                                color: Color(0xFF043248),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                image: 'Cartes/Icon5.png',
                                text: 'CALEARO : 131421802',
                                subText: 'Leading time : 19m 57s',
                                subTitle: 'TRS : 99.817%',
                                color: Color(0xFF043248),
                              ),
                              CatigoryW(
                                image: 'Cartes/Lassr.png',
                                text: 'CALEARO : 131423801',
                                subText: 'Leading time : 16m 06s',
                                subTitle: 'TRS : 98.394%',
                                color: Color(0xFF043248),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}