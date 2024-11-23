import 'package:auth_app/ExternalViews/home_screen.dart';
import 'package:auth_app/constants/constants.dart';
import 'package:auth_app/Widgets/note_editor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';


  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(NotesPage());
  }

  class NotesPage extends StatefulWidget {
    @override
    _NotesPageState createState() => _NotesPageState();
  }
  class _NotesPageState extends State<NotesPage> {

    _dismissDialog() {
      Navigator.pop(context);
    }

    deleteTodo(QueryDocumentSnapshot doc) {
      var doc_id = doc.id;
      DocumentReference documentReference = FirebaseFirestore.instance.collection("note").doc(doc_id);
      documentReference.delete().whenComplete(() => print("deleted successfully"));
    }

    void _showCupertinoDialog(QueryDocumentSnapshot doc) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Alert'),
              content: Text('Sure you want to delete'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      _dismissDialog();
                    },
                    child: Text('Close')),
                TextButton(
                  onPressed: () {
                    deleteTodo(doc);
                    _dismissDialog();
                  },
                  child: Text('YES'),
                )
              ],
            );
          });
    }

    Widget noteCard( Function()? onTap,QueryDocumentSnapshot doc){

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
                      IconButton(
                        padding: EdgeInsetsDirectional.only(end: 20),
                        icon: const Icon(Icons.delete_outline_rounded,size: 25,),
                        color: Colors.black54,
                        onPressed: () {
                          _showCupertinoDialog(doc);
                        },
                      ),
                    ],
                  ),
                ]
            ),
          )
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: GFAppBar(
          title: Text("Notes"),
          leading:IconButton(
          icon: Icon(Icons.arrow_back_ios),
          hoverColor: Colors.black26,
          onPressed: () {
          // passing this to our root
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);
          },
        ),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("note").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((note) => noteCard(() {}, note))
                          .toList(),
                    );
                  }
                  return Text("there's no note");
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NoteEditorScreen()));
          },
          label: Text("Add note"),
          icon: Icon(Icons.add),
        ),
      );
    }
  }
