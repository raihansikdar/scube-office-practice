import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Line chart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<SpChartDataModel>spChartData = [];
  List<PowerChartDataModel>powerChartData = [];



  Future<void>fetchData()async{
    const String _baseUrl = 'http://192.168.60.60:8000';
    const String radiationEndPoint ='/today-radiation/';
    const String powerEndPoint ='/today-ac-power/';

    final radiationResponse = await http.get(Uri.parse(_baseUrl+radiationEndPoint));
    final powerResponse = await http.get(Uri.parse(_baseUrl+powerEndPoint));

    log(radiationResponse.body);
    log(powerResponse.body);

    if(radiationResponse.statusCode ==200 && powerResponse.statusCode == 200){
      final List<dynamic> radiationResponseData = json.decode(radiationResponse.body)['radiation_today'];
      final List<dynamic> powerResponseData = json.decode(powerResponse.body)['power_today'];
      setState(() {
        spChartData = radiationResponseData.map((e) => SpChartDataModel.fromJson(e)).toList();
        powerChartData = powerResponseData.map((e) => PowerChartDataModel.fromJson(e)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Spline Chart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: spChartData.isEmpty
            ? const CircularProgressIndicator() : Container(
          child: SfCartesianChart(
            legend: const Legend(isVisible: true, position: LegendPosition.bottom),
            trackballBehavior: TrackballBehavior(
                enable: true,
                tooltipAlignment: ChartAlignment.near,
                tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                activationMode: ActivationMode.singleTap,
               ),
            series: <CartesianSeries>[
              SplineSeries<SpChartDataModel, DateTime>(
                name: 'Radiation East',
                dataSource: spChartData,
                pointColorMapper:(SpChartDataModel data, _) => Colors.blueGrey,
                xValueMapper: (SpChartDataModel data, _) => data.timedate,
                yValueMapper: (SpChartDataModel data, _) => double.parse(data.radiationEast.toStringAsFixed(2)),
              ),
              SplineSeries<SpChartDataModel, DateTime>(
                name: 'Radiation West',
                dataSource: spChartData,
                pointColorMapper:(SpChartDataModel data, _) => Colors.deepPurple,
                xValueMapper: (SpChartDataModel data, _) => data.timedate,
                yValueMapper: (SpChartDataModel data, _) => double.parse(data.radiationWest.toStringAsFixed(2)),
              ),
              SplineSeries<SpChartDataModel, DateTime>(
                name: 'Radiation North',
                dataSource: spChartData,
                pointColorMapper:(SpChartDataModel data, _) => Colors.amber,
                xValueMapper: (SpChartDataModel data, _) => data.timedate,
                yValueMapper: (SpChartDataModel data, _) => double.parse(data.radiationNorth.toStringAsFixed(2)),
              ),
              SplineSeries<SpChartDataModel, DateTime>(
                name: 'Radiation South',
                dataSource: spChartData,
                pointColorMapper:(SpChartDataModel data, _) => Colors.white10,
                xValueMapper: (SpChartDataModel data, _) => data.timedate,
                yValueMapper: (SpChartDataModel data, _) => double.parse(data.radiationSouth.toStringAsFixed(2)),
              ),

              //---------power-------------
              SplineSeries<PowerChartDataModel, DateTime>(
                name: 'Power',
                dataSource: powerChartData,
                pointColorMapper:(PowerChartDataModel data, _) => Colors.red,
                xValueMapper: (PowerChartDataModel data, _) => data.timedate,
                yValueMapper: (PowerChartDataModel data, _) => double.parse(data.plant.toStringAsFixed(2)),
              ),


            ],
   // primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hm(),),
   //          primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hm(),
   //            minimum:  DateTime(DateTime.now().year,
   //                DateTime.now().month, DateTime.now().day, 0, 0, 0),
   //            maximum: DateTime(DateTime.now().year,
   //                DateTime.now().month, DateTime.now().day, 23, 59, 59),interval: 1,),
             primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat.Hm(),
              minimum: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 0),
              maximum: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 24),
              interval: 1,
              //edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: const NumericAxis(
              labelFormat: '{value}',
            ),
          ),
        )

      ),
    );
  }
}
class SpChartDataModel {
  final DateTime timedate;
  final double radiationEast;
  final double radiationWest;
  final double radiationNorth;
  final double radiationSouth;

  SpChartDataModel({required this.timedate, required this.radiationEast, required this.radiationWest, required this.radiationNorth, required this.radiationSouth});


  factory SpChartDataModel.fromJson(Map<String,dynamic>json){
    return SpChartDataModel(
      timedate: DateTime.parse(json['timedate']),
      radiationEast: json['radiation_east'],
      radiationWest: json['radiation_west'],
      radiationNorth: json['radiation_north'],
      radiationSouth: json['radiation_south'],
    );
  }
}


class PowerChartDataModel{
  final DateTime timedate;
  final double plant;

  PowerChartDataModel({required this.timedate, required this.plant});

  factory PowerChartDataModel.fromJson(Map<String,dynamic>json){
    return PowerChartDataModel( timedate: DateTime.parse(json['timedate']), plant: json['plant']);
  }
}

