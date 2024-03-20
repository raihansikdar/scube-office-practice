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

  final List<ChartDataModel> chartData =[
    ChartDataModel(year: 2010, sales: 12),
    ChartDataModel(year: 2011, sales: 28),
    ChartDataModel(year: 2012, sales: 5),
    ChartDataModel(year: 2013, sales: 32),
    ChartDataModel(year: 2014, sales: 20),
    ChartDataModel(year: 2015, sales: 15),
    ChartDataModel(year: 2016, sales: 32),
    ChartDataModel(year: 2017, sales: 0),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Line chart',style: TextStyle(color:Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          child: SfCartesianChart(
            legend: const Legend(isVisible: true,position: LegendPosition.bottom),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              LineSeries<ChartDataModel, int>(
                name: 'Sales',
                dataSource: chartData,
                // dashArray: const <double>[5, 5],
                pointColorMapper:(ChartDataModel data, _) => Colors.red,
                xValueMapper: (ChartDataModel data, _)=> data.year,
                yValueMapper:  (ChartDataModel data, _)=>data.sales,
                dataLabelSettings: const DataLabelSettings(isVisible: true,),
              )
            ],
            primaryXAxis: const NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift,),
            primaryYAxis: NumericAxis(
              labelFormat: '{value}M',
              numberFormat: NumberFormat.simpleCurrency(decimalDigits: 1),),
          ),
        ),
      ),
    );
  }
}
class ChartDataModel{
  final int year;
  final double sales;

  ChartDataModel({required this.year, required this.sales});
}


