import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Calereo.",
      subtitle: "ID : 123456 ",
      time: "Temps menant : 5min",
      trs: "TRS : 50%",
      img: "");

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1];

    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color:Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    data.img,
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Color(0xFF112B3C),
                            fontSize: 18,
                            //  fontWeight: FontWeight.w600,
                            fontWeight: FontWeight. bold )),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            //fontWeight: FontWeight.w600
                            fontWeight: FontWeight. bold )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.time,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.trs,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color:  Color(0xFF112B3C),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String time;
  String trs;
  String img;
  Items({required this.title, required this.subtitle,  required this.time, required this.trs ,required this.img});
}