import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
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

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<ChartDataModel> chartData = [
    ChartDataModel(DateTime(2024, 1, 1), 10),
    ChartDataModel(DateTime(2024, 2, 1), 20),
    ChartDataModel(DateTime(2024, 3, 1), 15),
    ChartDataModel(DateTime(2024, 4, 1), 30),
    ChartDataModel(DateTime(2024, 5, 1), 25),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('First Line chart',style: TextStyle(color:Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          child: SfCartesianChart(
            primaryXAxis: const DateTimeAxis(),
            series: <CartesianSeries>[
              FastLineSeries<ChartDataModel, DateTime>(
                dataSource: chartData,
                xValueMapper: (ChartDataModel data, _)=> data.x,
                yValueMapper:  (ChartDataModel data, _)=>data.y,
              ),

            ],
            //primaryXAxis: const NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift,),
            //primaryYAxis: NumericAxis(numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),),
          ),
        ),
      ),
    );
  }
}
class ChartDataModel {
  final DateTime x;
  final double y;

  ChartDataModel(this.x, this.y);
}



