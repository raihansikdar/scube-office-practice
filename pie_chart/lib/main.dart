/*
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25, Colors.blue),
      ChartData('Steve', 38, Colors.green),
      ChartData('Jack', 34, Colors.orange),
      ChartData('Others', 52, Colors.grey)
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pie Chart Example'),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: SfCircularChart(
            legend: const Legend(isVisible: true),
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color = Colors.blue]);
  final String x;
  final double y;
  final Color color;
}*/


import 'dart:convert';
import 'dart:developer';
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
 late PieChartModel pieChartModel;
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
       // chartData = jsonData.map((x) => PieChartModel.fromJson(x).toMap()).toList();
        pieChartModel = PieChartModel.fromJson(jsonData);
        chartData.add(pieChartModel);

        log('========');
        log(jsonData.toString());
        log('========');
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
        child: Container(
          height: 300,
          width: 300,
          child: SfCircularChart(
            legend: const Legend(isVisible: true),
            series: <CircularSeries>[

              PieSeries<PieChartModel, String>(
                dataSource: chartData,
                pointColorMapper: (PieChartModel data, _) => Colors.blue, // Use a color here
                xValueMapper: (PieChartModel data, _) => 'Percentage REB',
                yValueMapper: (PieChartModel data, _) => data.percentageReb ?? 0,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartModel {
  double? percentageReb;
  int? percentageGenerator1;
  int? percentageGenerator2;
  double? percentageSolar1;
  double? percentageSolar2;

  PieChartModel({
    this.percentageReb,
    this.percentageGenerator1,
    this.percentageGenerator2,
    this.percentageSolar1,
    this.percentageSolar2,
  });

  factory PieChartModel.fromJson(Map<String, dynamic> json) {
    return PieChartModel(
      percentageReb: json['percentage_reb']?.toDouble(),
      percentageGenerator1: json['percentage_generator_1']?.toInt(),
      percentageGenerator2: json['percentage_generator_2']?.toInt(),
      percentageSolar1: json['percentage_solar1']?.toDouble(),
      percentageSolar2: json['percentage_solar2']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'percentage_reb': percentageReb,
      'percentage_generator_1': percentageGenerator1,
      'percentage_generator_2': percentageGenerator2,
      'percentage_solar1': percentageSolar1,
      'percentage_solar2': percentageSolar2,
    };
  }
}
