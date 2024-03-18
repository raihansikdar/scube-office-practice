import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(useMaterial3: false),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // List<InverterModel> rebData = <InverterModel>[];
  // List<InverterModel> generator1Data = <InverterModel>[];
  // List<InverterModel> generator2Data = <InverterModel>[];
  //late InverterDataSource inverterDataSource;
  late InverterDataSource inverterDataSource = InverterDataSource(inverterModelData: []);
  bool _isLoading = false;


  Future<List<InverterModel>> fetchData(String endPoint) async {
    const String _baseUrl = 'https://scubetech.xyz/kazi-habibpur';
    const String authToken = 'Token 264ae90790a4275c27829533c55800f05301e308';

    final response = await http.get(Uri.parse(_baseUrl + endPoint), headers: {'Authorization': authToken});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return [
        InverterModel(
          name: endPoint.contains('reb') ? 'Reb' : endPoint.contains('generator1') ? 'Generator 1' : endPoint.contains('generator2') ? 'Generator 2' : endPoint.contains('solar1') ?'Solar 1':'Solar 2',
          livePower: jsonData['live_power'],
          liveFrequency: jsonData['live_frequency'],
          liveVoltageL1: jsonData['live_voltage_l1'],
          liveVoltageL2: jsonData['live_voltage_l2'],
          liveVoltageL3: jsonData['live_voltage_l3'],
          liveCurrentL1: jsonData['live_current_l1'],
          liveCurrentL2: jsonData['live_current_l2'],
          liveCurrentL3: jsonData['live_current_l3'],
          averageCurrentHarmonics: jsonData['average_current_harmonics'],
          averageVoltageHarmonics: jsonData['average_voltage_harmonics'],
          todaysEnergy: jsonData['todays_energy'],
        )
      ];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchDataAndSetState() async {
    _isLoading = true;
    setState(() {});

    try {
      final rebData = await fetchData('/monitor-load-reb/');
      final generator1Data = await fetchData('/monitor-load-generator1/');
      final generator2Data = await fetchData('/monitor-load-generator2/');
      final solar1Data = await fetchData('/monitor-load-solar1/');
      final solar2Data = await fetchData('/monitor-load-solar2/');

      final allData = [...rebData, ...generator1Data, ...generator2Data, ...solar1Data, ...solar2Data];
      inverterDataSource = InverterDataSource(inverterModelData: allData);
    } catch (e) {
      log('Error fetching data: $e');
    }

    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
   // fetchData();
    fetchDataAndSetState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: const Color(0xff9ea8bf).withOpacity(0.95),
          sortIconColor: const Color(0xfff7f8fa),
        ),
        child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: inverterDataSource,
            allowSorting: true,
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Name', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),))),
              GridColumn(
                  columnName: 'livePower',
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Live Power',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),
                      ))),
              GridColumn(
                columnName: 'liveFrequency',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Live Frequency', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),
              GridColumn(
                columnName: 'liveVoltageL1',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Line 1', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),

              GridColumn(
                columnName: 'liveVoltageL2',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Line 2', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),
              GridColumn(
                columnName: 'liveVoltageL3',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Line 3', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),

              GridColumn(
                columnName: 'liveCurrentL1',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Line 1', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),
              GridColumn(
                columnName: 'liveCurrentL2',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Line 2', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),
              GridColumn(
                columnName: 'liveCurrentL3',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Line 3', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),
              GridColumn(
                columnName: 'averageCurrentHarmonics',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Current', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),
              GridColumn(
                columnName: 'averageVoltageHarmonics',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Voltage', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),
              GridColumn(
                columnName: 'todaysEnergy',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Today\'s Energy', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),),),

            ],


            stackedHeaderRows: <StackedHeaderRow>[
              StackedHeaderRow(cells: [
                StackedHeaderCell(
                    columnNames: ['liveVoltageL1', 'liveVoltageL2','liveVoltageL3'],
                    child: Container(
                      // color: const Color(0xFFF1F1F1),
                        child: const Center(child: Text('Live Voltage',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),)))),
                StackedHeaderCell(
                    columnNames: ['liveCurrentL1', 'liveCurrentL2','liveCurrentL3'],
                    child: Container(
                      // color: const Color(0xFFF1F1F1),
                        child: const Center(child: Text('Live Current',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),)))),
                StackedHeaderCell(
                    columnNames: ['averageCurrentHarmonics', 'averageVoltageHarmonics'],
                    child: Container(
                      // color: const Color(0xFFF1F1F1),
                        child: const Center(child: Text('Harmonics',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),))))
              ])
            ]
        ),
      ),
    );
  }
}
class InverterModel {
  final String name;
  final dynamic livePower;
  final dynamic liveFrequency;
  final dynamic liveVoltageL1;
  final dynamic liveVoltageL2;
  final dynamic liveVoltageL3;
  final dynamic liveCurrentL1;
  final dynamic liveCurrentL2;
  final dynamic liveCurrentL3;
  final dynamic averageCurrentHarmonics;
  final dynamic averageVoltageHarmonics;
  final dynamic todaysEnergy;

  InverterModel({required this.name, required this.livePower, required this.liveFrequency, required this.liveVoltageL1, required this.liveVoltageL2, required this.liveVoltageL3, required this.liveCurrentL1, required this.liveCurrentL2, required this.liveCurrentL3, required this.averageCurrentHarmonics, required this.averageVoltageHarmonics, required this.todaysEnergy});

}
/*
class InverterDataSource extends DataGridSource {

  List<DataGridRow> _inverterData = [];
  @override
  List<DataGridRow> get rows => _inverterData;


  InverterDataSource({required List<InverterModel> inverterModelData}) {
    _inverterData = inverterModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell(columnName: 'livePower', value: e.livePower.toString()),
      DataGridCell(columnName: 'liveFrequency', value: e.liveFrequency.toString()),
      DataGridCell(columnName: 'liveVoltageL1', value: e.liveVoltageL1.toString()),
      DataGridCell(columnName: 'liveVoltageL2', value: e.liveVoltageL2.toString()),
      DataGridCell(columnName: 'liveVoltageL3', value: e.liveVoltageL3.toString()),
      DataGridCell(columnName: 'liveCurrentL1', value: e.liveCurrentL1.toString()),
      DataGridCell(columnName: 'liveCurrentL2', value: e.liveCurrentL2.toString()),
      DataGridCell(columnName: 'liveCurrentL3', value: e.liveCurrentL3.toString()),
      DataGridCell(columnName: 'averageCurrentHarmonics', value: e.averageCurrentHarmonics.toString()),
      DataGridCell(columnName: 'averageVoltageHarmonics', value: e.averageVoltageHarmonics.toString()),
      DataGridCell(columnName: 'todaysEnergy', value: e.todaysEnergy.toString()),
    ])).toList();
  }
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}*/
class InverterDataSource extends DataGridSource {
  List<DataGridRow> _inverterData = [];

  @override
  List<DataGridRow> get rows => _inverterData;

  InverterDataSource({required List<InverterModel> inverterModelData}) {
    _inverterData = inverterModelData.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'name', value: e.name),
        DataGridCell(
            columnName: 'livePower', value: _formatValue('livePower', e.livePower)),
        DataGridCell(
            columnName: 'liveFrequency', value: _formatValue('liveFrequency', e.liveFrequency)),
        DataGridCell(
            columnName: 'liveVoltageL1', value: _formatValue('liveVoltage', e.liveVoltageL1)),
        DataGridCell(
            columnName: 'liveVoltageL2', value: _formatValue('liveVoltage', e.liveVoltageL2)),
        DataGridCell(
            columnName: 'liveVoltageL3', value: _formatValue('liveVoltage', e.liveVoltageL3)),
        DataGridCell(
            columnName: 'liveCurrentL1', value: _formatValue('liveCurrent', e.liveCurrentL1)),
        DataGridCell(
            columnName: 'liveCurrentL2', value: _formatValue('liveCurrent', e.liveCurrentL2)),
        DataGridCell(
            columnName: 'liveCurrentL3', value: _formatValue('liveCurrent', e.liveCurrentL3)),
        DataGridCell(
            columnName: 'averageCurrentHarmonics',
            value: _formatValue('current', e.averageCurrentHarmonics)),
        DataGridCell(
            columnName: 'averageVoltageHarmonics',
            value: _formatValue('voltage', e.averageVoltageHarmonics)),
        DataGridCell(
            columnName: 'todaysEnergy',
            value: _formatValue('energy', e.todaysEnergy)),
      ]);
    }).toList();
  }

  String _formatValue(String columnName, dynamic value) {
    if (value == null) return '';

    switch (columnName) {
      case 'livePower':
        return '${(value as double).toStringAsFixed(2)} kW';
      case 'liveFrequency':
        return '${(value as double).toStringAsFixed(2)} Hz';
      case 'liveVoltage':
        return '${(value as double).toStringAsFixed(2)} V';
      case 'liveCurrent':
        return '${(value as double).toStringAsFixed(2)} A';
      case 'voltage':
        return '${(value as double).toStringAsFixed(2)} THD';
      case 'current':
        return '${(value as double).toStringAsFixed(2)} THD';
      case 'energy':
        return '${(value as double).toStringAsFixed(2)} kWh';
      default:
        return value.toString();
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}