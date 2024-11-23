import 'package:auth_app/ExternalViews/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:getwidget/types/gf_button_type.dart';


class HistoryData extends StatefulWidget {
  @override
  _HistoryDataState createState() => _HistoryDataState();
}

class _HistoryDataState extends State<HistoryData> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(196, 194, 194, 0.30196078431372547),
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('LineChartData').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                final data = doc.data()! as Map<String, dynamic>;
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  GFListTile(
                        title: Text('PCB_ID : '+data["id"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Color.fromRGBO(4, 48, 69, 1.0),
                            letterSpacing: 0.5
                          ),
                        ),
                  description: Text('Date : '+data["date"],
                          style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          height: 1.5 ,
                          letterSpacing: 0.5
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GFButton(
                            onPressed: (){
                              GFToast.showToast(
                                  'Taux du rendement synthetique (TRS):'+data['trs'],
                                  context,
                                  toastDuration:10,
                                  toastPosition: GFToastPosition.BOTTOM,
                                  textStyle: TextStyle(fontSize: 18, color: GFColors.PRIMARY),
                                  backgroundColor: GFColors.DARK,
                                  trailing: Icon(
                                    Icons.notifications,
                                    color: Colors.limeAccent
                                  ));
                              // DataModel dataModel = new DataModel(data["date"], data["trs"],data["id"]);
                              // getItemAndNavigate(dataModel,context);
                            },
                            elevation: 2,
                            text: "Details",textColor: Colors.black,
                            icon: Icon(Icons.info_rounded),
                            type: GFButtonType.solid,
                            color: Color.fromRGBO(
                                250, 179, 5, 1.0),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
              );
        },
      ),
    );
  }
}
