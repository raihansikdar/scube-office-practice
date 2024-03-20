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


  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35, 23),
      ChartData(2011, 38, 49),
      ChartData(2012, 34, 12),
      ChartData(2013, 52, 33),
      ChartData(2014, 40, 30)
    ];

    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                  // Columns will be rendered back to back
                    enableSideBySideSeriesPlacement: false,
                    series: <CartesianSeries<ChartData, int>>[
                      ColumnSeries<ChartData, int>(
                          width: 0.5,
                          spacing: 0.8,
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y
                      ),
                      ColumnSeries<ChartData, int>(
                          opacity: 0.9,
                          width: 0.3,
                          spacing: 0.8,
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y1
                      )
                    ]
                )
            )
        )
    );
  }
}
  class ChartData {
  ChartData(this.x, this.y, this.y1);
  final int x;
  final double y;
  final double y1;
  }
