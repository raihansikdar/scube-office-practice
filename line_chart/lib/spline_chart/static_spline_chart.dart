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

  final List<ChartDataModel> chartData = [
    ChartDataModel(2010, 35),
    ChartDataModel(2011, 13),
    ChartDataModel(2012, 34),
    ChartDataModel(2013, 27),
    ChartDataModel(2014, 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Spline Chart',style: TextStyle(color:Colors.white),),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
                child: SfCartesianChart(
                  legend: const Legend(isVisible: true,position: LegendPosition.bottom),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    SplineSeries<ChartDataModel, int>(
                      name: 'Sales',
                      dataSource: chartData,
                      pointColorMapper:(ChartDataModel data, _) => Colors.deepPurple,
                      xValueMapper: (ChartDataModel data, _) => data.x,
                      yValueMapper: (ChartDataModel data, _) => data.y,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                    )
                  ],
                  primaryXAxis: const NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift,),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value}M',
                    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 1),),
                )
            )
        )
    );
  }
}
class ChartDataModel {
  final int x;
  final double? y;
  ChartDataModel(this.x, this.y);
}

