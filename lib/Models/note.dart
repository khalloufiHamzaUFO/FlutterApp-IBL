
import 'package:auth_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

Widget noteCard(Function()? onTap,QueryDocumentSnapshot doc){
  return InkWell(
    onTap:(){
    },
    child: Container(
    padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["note_title"],style: AppStyle.mainTitle,),
          SizedBox(height: 4.0,),
          Text(doc["creation_date"],style: AppStyle.mainContent,),
          SizedBox(height: 8.0,),
          Text(doc["note_content"],maxLines: 4,softWrap: true,style:AppStyle.mainContent,overflow: TextOverflow.ellipsis,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            ],
          ),
        ]
      ),
  )
  );
}


