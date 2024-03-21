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
      title: 'Flutter Column chart',
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

  final List<GDPData> chartData = [
    GDPData('Oceania', 1600),
    GDPData('Africa', 2490),
    GDPData('S America', 2900),
    GDPData('Europe', 23050),
    GDPData('N America', 24880),
    GDPData('Asia', 34390),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Column Chart',style: TextStyle(color:Colors.white),),),
      body: SfCartesianChart(
        title: const ChartTitle(text: 'Continent wise GDP - 2021'),
        legend: const Legend(isVisible: true,position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          ColumnSeries<GDPData, String>(
            name: 'GDP',
            dataSource: chartData,
            xValueMapper: (GDPData gdp, _) => gdp.continent,
            yValueMapper: (GDPData gdp, _) => gdp.gdp,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            width: 0.6,
            spacing: 0.3,
          ),
        ],
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}M',
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
            title: const AxisTitle(text: 'GDP in billions of U.S. Dollars')),
      ),
    );
  }
}

class GDPData {
  final String continent;
  final double gdp;
  GDPData(this.continent, this.gdp);
}
