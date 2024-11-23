import 'package:flutter/material.dart';

class CatigoryW extends StatelessWidget {
  String image;
  String text;
  String subText;
  String subTitle;
  Color color;

  CatigoryW({required this.image, required this.text ,required this.subText,required this.subTitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 148,
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0x9FA29595),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 100,
              height: 75,
            ),

            Text(
              text,
              style: TextStyle(color: color, fontSize: 18,fontWeight:FontWeight.bold),
            ),
            Text(
              subText,
              style: TextStyle(color: color, fontSize: 18 ),
            ),
            Text(
              subTitle,
              style: TextStyle(color: color, fontSize: 18),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}