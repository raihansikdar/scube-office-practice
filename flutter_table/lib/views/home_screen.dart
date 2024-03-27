import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_table/controllers/pv_controller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PVModel> invList = [];
  bool isLoading = true;

  Future<void> getInvData() async {
    const String _baseUrl = 'https://scubetech.xyz/kazi-habibpur/inverter-live';
    String authToken = "264ae90790a4275c27829533c55800f05301e308";
    const String inv1EndPoint = '/Inverter01/';
    const String inv2EndPoint = '/Inverter02/';
    const String inv3EndPoint = '/Inverter03/';

    try {
      final response1 = await http.get(Uri.parse(_baseUrl + inv1EndPoint),headers: {'Authorization': 'Token $authToken'});
      final response2 = await http.get(Uri.parse(_baseUrl + inv2EndPoint),headers: {'Authorization': 'Token $authToken'});
      final response3 = await http.get(Uri.parse(_baseUrl + inv3EndPoint),headers: {'Authorization': 'Token $authToken'});

      log(response1.body);
      if (response1.statusCode == 200 &&
          response2.statusCode == 200 &&
          response3.statusCode == 200) {
        final pvModelInv1 = PVModel.fromJson(json.decode(response1.body));
        final pvModelInv2 = PVModel.fromJson(json.decode(response2.body));
        final pvModelInv3 = PVModel.fromJson(json.decode(response3.body));

        // invList.addAll([pvModelInv1, pvModelInv2, pvModelInv3]);

        setState(() {
          invList.addAll([pvModelInv1, pvModelInv2, pvModelInv3]);
          isLoading = false;
        });

      } else {
        log('Error: Non-200 status code received.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log('Exception: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getInvData();
  }
  String _getDisplayName(String key) {
    if (key == "timedate") {
      return "Time & Date";
    } else {
      return _capitalizeEachWord(key.split('_').join(' '));
    }
  }



  String _formatValue(String key, String value) {

    if ((key.startsWith("pv") && key.endsWith("_voltage")) || (key.startsWith('phase') && key.endsWith("_voltage"))){
      final formattedValue = double.tryParse(value);
      if (formattedValue != null) {
        return "${formattedValue.toStringAsFixed(2)} V";
      }
    } else if ((key.startsWith("pv") && key.endsWith("_current")) || (key.startsWith("phase") && key.endsWith("_current"))) {
      final formattedValue = double.tryParse(value);
      if (formattedValue != null) {
        return "${formattedValue.toStringAsFixed(2)} A";
      }
    }else if(key.endsWith('_power')){
      final formattedValue = double.tryParse(value);
      if (formattedValue != null) {
        return "${formattedValue.toStringAsFixed(2)} kW";
      }
    }else if(key.endsWith('_frequency')){
      final formattedValue = double.tryParse(value);
      if (formattedValue != null) {
        return "${formattedValue.toStringAsFixed(2)} Hz";
      }
    }else if(key.endsWith('_temperature')){
    final formattedValue = double.tryParse(value);
    if (formattedValue != null) {
    return "${formattedValue.toStringAsFixed(0)} °C";
      }
    }else if(key.endsWith('_yield')){
      final formattedValue = double.tryParse(value);
      if (formattedValue != null) {
        return "${formattedValue.toStringAsFixed(2)} kWh";
      }
    }else if(key.startsWith('efficiency')){
      final formattedValue = double.tryParse(value);
      if (formattedValue != null) {
        return "${(formattedValue * 100).toStringAsFixed(2)} %";
      }
    }
    if (key == "timedate") {
      final dateTime = DateTime.parse(value);
      final formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
      final formattedTime = DateFormat('hh:mm a').format(dateTime);
      return '$formattedDate $formattedTime';
    } else {
      return value;
    }
  }


  String _capitalizeEachWord(String input) {
    return input.toLowerCase().split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '').join(' ');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("data"),
      ),
      body:isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
              children: [
      Container(
                  color: Colors.orange,
                  height: 40,
                  child: const Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Inverter 1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Inverter 2',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Inverter 3',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          transform: Matrix4.translationValues(7.0, -55.0, 0.0),
                          child: DataTable(
                              columns: const [
                                DataColumn(label: Text('',textAlign: TextAlign.center,),numeric: true),
                                DataColumn(label: Text('',textAlign: TextAlign.center,),numeric: true),
                                DataColumn(label: Text('',textAlign: TextAlign.center,),numeric: true),
                                DataColumn(label: Text('',textAlign: TextAlign.center,),numeric: true),
                              ],
                              rows: invList.isNotEmpty ? invList[0].toJson().entries.map((entry) {
                                final attribute = _getDisplayName(entry.key);
                                final inv1Value = entry.value.toString();
                                final inv2Value = invList[1].toJson()[entry.key].toString();
                                final inv3Value = invList[2].toJson()[entry.key].toString();
                                return DataRow(
                                  cells: [
                                    DataCell(Center(child: Text(attribute))),
                                    DataCell(Center(child: Text(_formatValue(entry.key, inv1Value)))),
                                    DataCell(Center(child: Text(_formatValue(entry.key, inv2Value)))),
                                    DataCell(Center(child: Text(_formatValue(entry.key, inv3Value)))),
                                  ],
                                );
                              }).toList()
                                  : [],
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

class PVModel {
  String? timedate;
  double? pv01Voltage;
  double? pv01Current;
  double? pv02Voltage;
  double? pv02Current;
  double? pv03Voltage;
  double? pv03Current;
  double? pv04Voltage;
  double? pv04Current;
  double? pv05Voltage;
  double? pv05Current;
  double? pv06Voltage;
  double? pv06Current;
  double? pv07Voltage;
  double? pv07Current;
  double? pv08Voltage;
  double? pv08Current;
  double? pv09Voltage;
  double? pv09Current;
  double? pv10Voltage;
  double? pv10Current;
  double? pv11Voltage;
  double? pv11Current;
  double? pv12Voltage;
  double? pv12Current;
  double? pv13Voltage;
  double? pv13Current;
  double? pv14Voltage;
  double? pv14Current;
  double? pv15Voltage;
  double? pv15Current;
  double? pv16Voltage;
  double? pv16Current;
  double? pv17Voltage;
  double? pv17Current;
  double? pv18Voltage;
  double? pv18Current;
  double? pv19Voltage;
  double? pv19Current;
  double? pv20Voltage;
  double? pv20Current;
  double? inputPower;
  double? phaseAVoltage;
  double? phaseBVoltage;
  double? phaseCVoltage;
  double? phaseACurrent;
  double? phaseBCurrent;
  double? phaseCCurrent;
  double? activePower;
  double? gridFrequency;
  double? efficiency;
  double? internalTemperature;
  double? totalEnergyYield;
  double? dailyEnergyYield;

  PVModel(
      {this.timedate,
        this.pv01Voltage,
        this.pv01Current,
        this.pv02Voltage,
        this.pv02Current,
        this.pv03Voltage,
        this.pv03Current,
        this.pv04Voltage,
        this.pv04Current,
        this.pv05Voltage,
        this.pv05Current,
        this.pv06Voltage,
        this.pv06Current,
        this.pv07Voltage,
        this.pv07Current,
        this.pv08Voltage,
        this.pv08Current,
        this.pv09Voltage,
        this.pv09Current,
        this.pv10Voltage,
        this.pv10Current,
        this.pv11Voltage,
        this.pv11Current,
        this.pv12Voltage,
        this.pv12Current,
        this.pv13Voltage,
        this.pv13Current,
        this.pv14Voltage,
        this.pv14Current,
        this.pv15Voltage,
        this.pv15Current,
        this.pv16Voltage,
        this.pv16Current,
        this.pv17Voltage,
        this.pv17Current,
        this.pv18Voltage,
        this.pv18Current,
        this.pv19Voltage,
        this.pv19Current,
        this.pv20Voltage,
        this.pv20Current,
        this.inputPower,
        this.phaseAVoltage,
        this.phaseBVoltage,
        this.phaseCVoltage,
        this.phaseACurrent,
        this.phaseBCurrent,
        this.phaseCCurrent,
        this.activePower,
        this.gridFrequency,
        this.efficiency,
        this.internalTemperature,
        this.totalEnergyYield,
        this.dailyEnergyYield});

  PVModel.fromJson(Map<String, dynamic> json) {
    timedate = json['timedate'];
    pv01Voltage = json['pv01_voltage'];
    pv01Current = json['pv01_current'];
    pv02Voltage = json['pv02_voltage'];
    pv02Current = json['pv02_current'];
    pv03Voltage = json['pv03_voltage'];
    pv03Current = json['pv03_current'];
    pv04Voltage = json['pv04_voltage'];
    pv04Current = json['pv04_current'];
    pv05Voltage = json['pv05_voltage'];
    pv05Current = json['pv05_current'];
    pv06Voltage = json['pv06_voltage'];
    pv06Current = json['pv06_current'];
    pv07Voltage = json['pv07_voltage'];
    pv07Current = json['pv07_current'];
    pv08Voltage = json['pv08_voltage'];
    pv08Current = json['pv08_current'];
    pv09Voltage = json['pv09_voltage'];
    pv09Current = json['pv09_current'];
    pv10Voltage = json['pv10_voltage'];
    pv10Current = json['pv10_current'];
    pv11Voltage = json['pv11_voltage'];
    pv11Current = json['pv11_current'];
    pv12Voltage = json['pv12_voltage'];
    pv12Current = json['pv12_current'];
    pv13Voltage = json['pv13_voltage'];
    pv13Current = json['pv13_current'];
    pv14Voltage = json['pv14_voltage'];
    pv14Current = json['pv14_current'];
    pv15Voltage = json['pv15_voltage'];
    pv15Current = json['pv15_current'];
    pv16Voltage = json['pv16_voltage'];
    pv16Current = json['pv16_current'];
    pv17Voltage = json['pv17_voltage'];
    pv17Current = json['pv17_current'];
    pv18Voltage = json['pv18_voltage'];
    pv18Current = json['pv18_current'];
    pv19Voltage = json['pv19_voltage'];
    pv19Current = json['pv19_current'];
    pv20Voltage = json['pv20_voltage'];
    pv20Current = json['pv20_current'];
    inputPower = json['input_power'];
    phaseAVoltage = json['phase_a_voltage'];
    phaseBVoltage = json['phase_b_voltage'];
    phaseCVoltage = json['phase_c_voltage'];
    phaseACurrent = json['phase_a_current'];
    phaseBCurrent = json['phase_b_current'];
    phaseCCurrent = json['phase_c_current'];
    activePower = json['active_power'];
    gridFrequency = json['grid_frequency'];
    efficiency = json['efficiency'];
    internalTemperature = json['internal_temperature'];
    totalEnergyYield = json['total_energy_yield'];
    dailyEnergyYield = json['daily_energy_yield'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timedate'] = timedate;
    data['pv01_voltage'] = pv01Voltage;
    data['pv01_current'] = pv01Current;
    data['pv02_voltage'] = pv02Voltage;
    data['pv02_current'] = pv02Current;
    data['pv03_voltage'] = pv03Voltage;
    data['pv03_current'] = pv03Current;
    data['pv04_voltage'] = pv04Voltage;
    data['pv04_current'] = pv04Current;
    data['pv05_voltage'] = pv05Voltage;
    data['pv05_current'] = pv05Current;
    data['pv06_voltage'] = pv06Voltage;
    data['pv06_current'] = pv06Current;
    data['pv07_voltage'] = pv07Voltage;
    data['pv07_current'] = pv07Current;
    data['pv08_voltage'] = pv08Voltage;
    data['pv08_current'] = pv08Current;
    data['pv09_voltage'] = pv09Voltage;
    data['pv09_current'] = pv09Current;
    data['pv10_voltage'] = pv10Voltage;
    data['pv10_current'] = pv10Current;
    data['pv11_voltage'] = pv11Voltage;
    data['pv11_current'] = pv11Current;
    data['pv12_voltage'] = pv12Voltage;
    data['pv12_current'] = pv12Current;
    data['pv13_voltage'] = pv13Voltage;
    data['pv13_current'] = pv13Current;
    data['pv14_voltage'] = pv14Voltage;
    data['pv14_current'] = pv14Current;
    data['pv15_voltage'] = pv15Voltage;
    data['pv15_current'] = pv15Current;
    data['pv16_voltage'] = pv16Voltage;
    data['pv16_current'] = pv16Current;
    data['pv17_voltage'] = pv17Voltage;
    data['pv17_current'] = pv17Current;
    data['pv18_voltage'] = pv18Voltage;
    data['pv18_current'] = pv18Current;
    data['pv19_voltage'] = pv19Voltage;
    data['pv19_current'] = pv19Current;
    data['pv20_voltage'] = pv20Voltage;
    data['pv20_current'] = pv20Current;
    data['input_power'] = inputPower;
    data['phase_a_voltage'] = phaseAVoltage;
    data['phase_b_voltage'] = phaseBVoltage;
    data['phase_c_voltage'] = phaseCVoltage;
    data['phase_a_current'] = phaseACurrent;
    data['phase_b_current'] = phaseBCurrent;
    data['phase_c_current'] = phaseCCurrent;
    data['active_power'] = activePower;
    data['grid_frequency'] = gridFrequency;
    data['efficiency'] = efficiency;
    data['internal_temperature'] = internalTemperature;
    data['total_energy_yield'] = totalEnergyYield;
    data['daily_energy_yield'] = dailyEnergyYield;
    return data;
  }

}
/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InverterData {
  final String inverterName;
  final double pv01Voltage;
  final double pv01Current;
  final double pv02Voltage;
  final double pv02Current;
  final double pv03Voltage;
  final double pv03Current;
  final double inputPower;
  final double phaseAVoltage;
  final double phaseBVoltage;
  final double phaseCVoltage;
  final double phaseACurrent;
  final double phaseBCurrent;
  final double phaseCCurrent;
  final double activePower;
  final double gridFrequency;
  final double efficiency;
  final double internalTemperature;
  final double totalEnergyYield;
  final double dailyEnergyYield;

  InverterData({
    required this.inverterName,
    required this.pv01Voltage,
    required this.pv01Current,
    required this.pv02Voltage,
    required this.pv02Current,
    required this.pv03Voltage,
    required this.pv03Current,
    required this.inputPower,
    required this.phaseAVoltage,
    required this.phaseBVoltage,
    required this.phaseCVoltage,
    required this.phaseACurrent,
    required this.phaseBCurrent,
    required this.phaseCCurrent,
    required this.activePower,
    required this.gridFrequency,
    required this.efficiency,
    required this.internalTemperature,
    required this.totalEnergyYield,
    required this.dailyEnergyYield,
  });

  factory InverterData.fromJson(Map<String, dynamic> json) {
    return InverterData(
      inverterName: json['inverter_name'],
      pv01Voltage: json['pv01_voltage'],
      pv01Current: json['pv01_current'],
      pv02Voltage: json['pv02_voltage'],
      pv02Current: json['pv02_current'],
      pv03Voltage: json['pv03_voltage'],
      pv03Current: json['pv03_current'],
      inputPower: json['input_power'],
      phaseAVoltage: json['phase_a_voltage'],
      phaseBVoltage: json['phase_b_voltage'],
      phaseCVoltage: json['phase_c_voltage'],
      phaseACurrent: json['phase_a_current'],
      phaseBCurrent: json['phase_b_current'],
      phaseCCurrent: json['phase_c_current'],
      activePower: json['active_power'],
      gridFrequency: json['grid_frequency'],
      efficiency: json['efficiency'],
      internalTemperature: json['internal_temperature'],
      totalEnergyYield: json['total_energy_yield'],
      dailyEnergyYield: json['daily_energy_yield'],
    );
  }
}

class InverterDataTable extends StatelessWidget {
  final String token;

  const InverterDataTable({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          'Energy Monitoring System',
        ),
      ),
      body: FutureBuilder<List<InverterData>>(
        future: ApiService.fetchInverterData(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _FixedColumnDataTable(
                leftColumns: _buildLeftColumns(data),
                rightColumns: _buildRightColumns(data),
                rows: _buildRows(data),
              ),
            );
          }
        },
      ),
    );
  }

  List<DataColumn> _buildLeftColumns(List<InverterData> data) {
    return [
      const DataColumn(label: Text('Inverter Name')),
    ];
  }

  List<DataColumn> _buildRightColumns(List<InverterData> data) {
    return List.generate(data.length, (index) {
      return DataColumn(label: Text('Inverter ${index + 1}'));
    });
  }

  List<DataRow> _buildRows(List<InverterData> data) {
    List<DataRow> rows = [];
    final attributes = [
      'PV01 Voltage',
      'PV01 Current',
      'PV02 Voltage',
      'PV02 Current',
      'PV03 Voltage',
      'PV03 Current',
      'Input Power',
      'Phase A Voltage',
      'Phase B Voltage',
      'Phase C Voltage',
      'Phase A Current',
      'Phase B Current',
      'Phase C Current',
      'Active Power',
      'Grid Frequency',
      'Efficiency',
      'Internal Temperature',
      'Total Energy Yield',
      'Daily Energy Yield',
      // Add other attributes here if needed
    ];

    for (String attribute in attributes) {
      List<DataCell> cells = [DataCell(
        Text(
          attribute,
          textAlign: TextAlign.center, // Align center for attribute name
        ),
      )
      ];
      cells.addAll(data.map((inverter) =>
          DataCell(
            Text(
              _getAttributeValue(inverter, attribute),
              textAlign: TextAlign.center, // Align center for attribute value
            ),
          )));
      rows.add(DataRow(cells: cells));
    }

    return rows;
  }

  String _getAttributeValue(InverterData inverter, String attribute) {
    switch (attribute) {
      case 'PV01 Voltage':
      case 'PV02 Voltage':
      case 'PV03 Voltage':
      case 'Phase A Voltage':
      case 'Phase B Voltage':
      case 'Phase C Voltage':
        return '${inverter.phaseAVoltage.toStringAsFixed(
            2)} V'; // Example: 123.45 V
      case 'PV01 Current':
      case 'PV02 Current':
      case 'PV03 Current':
      case 'Phase A Current':
      case 'Phase B Current':
      case 'Phase C Current':
        return '${inverter.phaseACurrent.toStringAsFixed(
            2)} A'; // Example: 12.34 A
      case 'Input Power':
      case 'Active Power':
        return '${inverter.activePower.toStringAsFixed(
            2)} kW'; // Example: 123.45 kW
      case 'Grid Frequency':
        return '${inverter.gridFrequency.toStringAsFixed(
            2)} Hz'; // Example: 50.00 Hz
      case 'Efficiency':
        return '${(inverter.efficiency * 100).toStringAsFixed(
            2)} %'; // Example: 95.00 %
      case 'Internal Temperature':
        return '${inverter.internalTemperature.toStringAsFixed(
            2)} °C'; // Example: 30.00 °C
      case 'Total Energy Yield':
      case 'Daily Energy Yield':
        return '${inverter.totalEnergyYield.toStringAsFixed(
            2)} kWh'; // Example: 123.45 kWh
      default:
        return '';
    }
  }
}

class ApiService {
  static const baseUrl = 'https://scubetech.xyz/kazi-habibpur';
  static Future<List<InverterData>> fetchInverterData(String token) async {
    final Map<String, String> headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };
    final List<http.Response> responses = await Future.wait([
      http.get(Uri.parse('$baseUrl/inverter-live/Inverter01/'), headers: headers),
      http.get(Uri.parse('$baseUrl/inverter-live/Inverter02/'), headers: headers),
      http.get(Uri.parse('$baseUrl/inverter-live/Inverter03/'), headers: headers),
    ]);
    List<InverterData> combinedData = [];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);

        if (jsonData is Map<String, dynamic>) {
          String inverterName = 'Inverter ${combinedData.length + 1}';
          combinedData.add(InverterData.fromJson(jsonData.copyWith({'inverter_name': inverterName})));
        } else if (jsonData is List) {
          // Handle lists of data if needed
          combinedData.addAll(jsonData.map((e) {
            String inverterName = 'Inverter ${combinedData.length + 1}';
            return InverterData.fromJson(e.copyWith({'inverter_name': inverterName}));
          }).toList());
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load inverter data: ${response.statusCode}');
      }
    }

    return combinedData;
  }
}

extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> copyWith(Map<String, dynamic> newEntries) {
    return Map<String, dynamic>.from(this)..addAll(newEntries);
  }
}

class _FixedColumnDataTable extends StatelessWidget {
  final List<DataColumn> leftColumns;
  final List<DataColumn> rightColumns;
  final List<DataRow> rows;

  const _FixedColumnDataTable({
    Key? key,
    required this.leftColumns,
    required this.rightColumns,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
          child: DataTable(
            columnSpacing: 20.0, // Adjust the spacing between columns
            columns: [
              ...leftColumns,
              ...rightColumns,
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }
}*/
