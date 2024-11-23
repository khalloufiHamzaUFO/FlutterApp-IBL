import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
//output: 2021-10-17
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime.now();
    var Fdate = date.toString();
    Fdate = Fdate.substring(0,16);

    //output: 2021-10-17 20:04:17.118089

    String datetime1 = DateFormat.Hms().format(date);
    print(datetime1);

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: AppStyle.mainTitle,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 120,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note........',
              ),
              style: AppStyle.mainContent,
            )
          ],
        ),
        ////////////////////
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () async {
          FirebaseFirestore.instance.collection("note").add({
            "note_title": _titleController.text,
            "creation_date": Fdate,
            "note_content": _mainController.text,
            "color_id": color_id
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error) => print("Failed $error"));
        },
        child: Icon(Icons.save,color: Colors.white,),
      ),
    );
  }
  }

