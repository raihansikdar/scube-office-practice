import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PieChartModel> chartData = [];
  final List<Color> colorList = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.purple];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://scubetech.xyz/kazi-habibpur/power-usage-in-percentage/'),
        headers: {'Authorization': 'Token 264ae90790a4275c27829533c55800f05301e308'});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        chartData = PieChartModel.fromJson(jsonData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pie Chart Example'),
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          width: 500,
          child: SfCircularChart(
            legend:  const Legend(isVisible: true),
            series: <CircularSeries>[
              PieSeries<PieChartModel, String>(
                dataSource: chartData,
                pointColorMapper: (PieChartModel data, _) => colorList[chartData.indexOf(data) % colorList.length],
                xValueMapper: (PieChartModel data, _) => data.name,
                yValueMapper: (PieChartModel data, _) => data.percentage ?? 0,
                dataLabelMapper: (PieChartModel data, _) => '${((data.percentage ?? 0) ).toStringAsFixed(2)}%',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartModel {
  final String name;
  final double? percentage;

  PieChartModel(this.name, this.percentage);

  static List<PieChartModel> fromJson(Map<String, dynamic> json) {
    return [
      PieChartModel('REB', json['percentage_reb']),
      PieChartModel('Generator 1', json['percentage_generator_1']),
      PieChartModel('Generator 2', json['percentage_generator_2']),
      PieChartModel('Solar 1', json['percentage_solar1']),
      PieChartModel('Solar 2', json['percentage_solar2']),
    ];
  }
}