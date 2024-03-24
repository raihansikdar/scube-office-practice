import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double acPlantValue = 0.0;
  double prPlantValue = 0.0;
  double poaAvgValue = 0.0;
  double poaDayAvgValue = 0.0;

  Future<void> fetchData() async {
    const String _baseUrl = 'http://192.168.68.185:8000';
    const String authToken = '';

    String acPowerEndPoint = '/single-ac-power/';
    String othersEndPoint = '/single-cumulative-pr/';

    try {
      final acPowerResponse = await http.get(
          Uri.parse(_baseUrl + acPowerEndPoint),
          headers: {'Authorization': authToken});

      final otherResponse = await http.get(Uri.parse(_baseUrl + othersEndPoint),
          headers: {'Authorization': authToken});

      if (acPowerResponse.statusCode == 200 &&
          otherResponse.statusCode == 200) {
        final acPowerJsonData = jsonDecode(acPowerResponse.body);
        final othersJsonData = jsonDecode(otherResponse.body);

        setState(() {
          acPlantValue = acPowerJsonData['plant'];
          prPlantValue = othersJsonData['plant'];
          poaAvgValue = othersJsonData['poa_avg'];
          poaDayAvgValue = othersJsonData['poa_day_avg'];

          log(acPlantValue.toString());
          log(prPlantValue.toString());
          log(poaAvgValue.toString());
          log(poaDayAvgValue.toString());
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Radial Gauges',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          backgroundColor: Colors.cyan,
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 300,
                      child: _buildRadialGauge(
                        title: 'Active AC Power',
                        value: acPlantValue,
                        startValue: 0,
                        endValue: 1600,
                        interval: 400,
                        minimum: 0,
                        maximum: 1600,
                        text: '${acPlantValue.toStringAsFixed(2)} kW',
                        labelFormat: '{value} kW',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 300,
                      child: _buildRadialGauge(
                        title: 'Live PR',
                        value: prPlantValue,
                        startValue: 0,
                        endValue: 2,
                        interval: 1,
                        minimum: 0,
                        maximum: 2,
                        text: prPlantValue.toStringAsFixed(2),
                        labelFormat: '{value}',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 300,
                      child: _buildRadialGauge(
                        title: 'Irr Average',
                        value: poaAvgValue,
                        startValue: 0,
                        endValue: 1200,
                        interval: 300,
                        minimum: 0,
                        maximum: 1200,
                        text:
                            '${poaAvgValue.toStringAsFixed(2)} w/m${String.fromCharCode(0x00B2)}',
                        labelFormat: '{value} w/m²',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 300,
                      child: _buildRadialGauge(
                        title: 'Daily Cumulative Average',
                        value: poaDayAvgValue,
                        startValue: 0,
                        endValue: 10,
                        interval: 3,
                        minimum: 0,
                        maximum: 10,
                        text:
                            '${poaDayAvgValue.toStringAsFixed(2)} wh/m${String.fromCharCode(0x00B2)}',
                        labelFormat: '{value} wh/m²',
                      ),
                    ),
                  ),
                  // Add another Expanded for the fourth gauge here
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadialGauge(
      {required String title,
      required double value,
      required double startValue,
      required double endValue,
      required double interval,
      required double minimum,
      required double maximum,
      required String text,
      required String labelFormat}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2.0,
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: SfRadialGauge(
                      //enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                          startAngle: 180,
                          endAngle: 0,
                          interval: interval,
                          radiusFactor: 1.1,
                          minimum: minimum,
                          maximum: maximum,
                          showLabels: true,
                          labelFormat: labelFormat,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: startValue,
                              endValue: endValue,
                              color: Colors.grey,
                              startWidth: 10,
                              endWidth: 10,
                            ),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: value,
                              lengthUnit: GaugeSizeUnit.factor,
                              needleLength: 0.6,
                              needleEndWidth: 6,
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Colors.deepPurple,
                                  Colors.deepPurple,
                                  Colors.grey,
                                  Colors.grey,
                                ],
                                stops: <double>[0, 0.5, 0.5, 1],
                              ),
                              needleColor: const Color(0xFFF67280),
                              knobStyle: const KnobStyle(
                                knobRadius: 0.05,
                                borderWidth: 0.02,
                                sizeUnit: GaugeSizeUnit.factor,
                                borderColor: Colors.deepPurple,
                                color: Colors.white,
                              ),
                            ),
                            RangePointer(
                              value: value,
                              width: 10,
                              enableAnimation: true,
                              color: Colors.deepPurple,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.25,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GaugePowerModel {
  final double? plant;
  final double? poaAvg;
  final double? poaDayAvg;

  GaugePowerModel({this.plant, this.poaAvg, this.poaDayAvg});

  factory GaugePowerModel.fromJson(Map<String, dynamic> json) {
    return GaugePowerModel(
      plant: json['plant'],
      poaAvg: json['poa_avg'],
      poaDayAvg: json['poa_day_avg'],
    );
  }
}
