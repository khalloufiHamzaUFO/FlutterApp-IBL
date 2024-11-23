import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../ExternalViews/home_screen.dart';
import '../Models/ProductionModel.dart';
import '../Models/Rendement.dart';
import '../Models/TRG_Model.dart';
import '../Models/data_model.dart';


class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final db = FirebaseFirestore.instance;

  final dataRef = FirebaseFirestore.instance.collection('LineChartData');
  final ProductionRef = FirebaseFirestore.instance.collection('Production');
  final RendementRef = FirebaseFirestore.instance.collection('Rendement');
  final TRGRef = FirebaseFirestore.instance.collection('TauxRendementGlobal');

  List<DataModel> Fulldata = [];
  List<DataModel> data = [];

  getDataLineTrs() {
    dataRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        var newDataModel =
        new DataModel(doc['id'], (doc['trs']), doc['date']);
        Fulldata.add(newDataModel);
      });
      // int i = Fulldata.length;
      // //print(i);
      // var j = 0;
      // for (j = i - 1; j >= i - 7; j--) {
      //   data.add(Fulldata[j]);
      // }
    });
  }

  List<Rondement> RendementList = [];
  List<Rondement> RendementUtilList = [];

  getDataLineRendement() {
    RendementRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        var newRendement =
        new Rondement(doc['date'],doc['value']);
        RendementList.add(newRendement);
      });
      // int i = Fulldata.length;
      // //print(i);
      // var j = 0;
      // for (j = i - 1; j >= i - 7; j--) {
      //   data.add(Fulldata[j]);
      // }
    });
  }


  List<TRGModel> TRGList = [];
  List<TRGModel> TRGUtilList = [];

  getDataLineTRG() {
    TRGRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        var newTRGClass =
        new TRGModel(doc['date'],doc['value']);
        TRGList.add(newTRGClass);
      });
      // int i = Fulldata.length;
      // //print(i);
      // var j = 0;
      // for (j = i - 1; j >= i - 7; j--) {
      //   data.add(Fulldata[j]);
      // }
    });
  }


  @override
  void initState() {
    getDataLineRendement();
    getDataLineTRG();
    getDataLineProduction();
    super.initState();
  }



  List<Production_Model> CadenceData = [];
  getDataLineProduction() {
    ProductionRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        var newCad = new Production_Model(doc['date'],doc['value']);
        CadenceData.add(newCad);
      });
    });
  }

  static const appbarColor = Color(0xFF043248);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(196, 194, 194, 0.30196078431372547),
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: Text('Statistics'),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(
                        'Efficiency = Output Rate÷Standard Output Rate×100 \n'
                        'OEE = (Useful time / Opening time) * 100 \n'
                        'Production is the number of PCBs (Printed circuit board) produced each day'
                    )));
              },
            ),
          ],
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: Card(
                child: Container(
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      title: AxisTitle(text: 'Date'),
                      isInversed: false,
                    ),
                    primaryYAxis: NumericAxis(
                        title: AxisTitle(text: 'Percentage % '),
                        edgeLabelPlacement: EdgeLabelPlacement.shift),
                    title: ChartTitle(text: 'Efficiency (Rendement)'
                      ,textStyle:TextStyle(
                          fontSize: 15,
                          fontWeight:FontWeight.bold,
                          color: Color(0xFF043248)
                      ),
                    ),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<Object, String>>[
                      LineSeries<Rondement, String>(
                        dataSource: RendementList,
                        xValueMapper: (Rondement data, _) => data.date,
                        yValueMapper: (Rondement data, _) => double.parse(data.value),
                        name: 'Rendement',
                        color: Color(0xFF203052),
                        width: 2,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
                elevation: 4,
                shadowColor: Colors.black54,
                margin: EdgeInsets.only(top: 10, bottom: 0, right: 20, left: 20),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)),
              )
          ),
          Expanded(
              child: Card(
            child: Container(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'Date '),
                  isInversed: false,
                ),
                primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Percentage % '),
                    edgeLabelPlacement: EdgeLabelPlacement.shift),
                title: ChartTitle(text: 'Overall Equipment Effectiveness(TRG)'
                  ,textStyle:TextStyle(
                    fontSize: 15,
                    fontWeight:FontWeight.bold,
                    color: Color(0xFF163D5E)
                ),
                ),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<Object, String>>[
                  LineSeries<TRGModel, String>(
                    dataSource: TRGList,
                    xValueMapper: (TRGModel data, _) => data.date,
                    yValueMapper: (TRGModel data, _) => double.parse(data.value),
                    name: 'Taux',
                    color: Color(0xFF043248),
                    width: 2,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            elevation: 4,
            shadowColor: Colors.black54,
            margin: EdgeInsets.only(top: 10, bottom: 0, right: 20, left: 20),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white)),
          )
          ),
          Expanded(
            child: Card(
              child: Center(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(text: 'Date '),
                  ),
                  primaryYAxis: NumericAxis(title: AxisTitle(text: 'Number')),
                  title: ChartTitle(text: 'Daily production',
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight:FontWeight.bold,
                      color: Color(0xFF216175)
                  ),),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<Object, String>>[
                    LineSeries<Production_Model, String>(
                      dataSource: CadenceData,
                      xValueMapper: (Production_Model data, _) => data.date,
                      yValueMapper: (Production_Model data, _) => double.parse(data.value),
                      name: 'Production',
                      color:Color(0xFF043248),
                      width: 2,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
              elevation: 4,
              shadowColor: Colors.black54,
              margin: EdgeInsets.only(top: 10, bottom: 0, right: 20, left: 20),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
        ]));
  }
}


