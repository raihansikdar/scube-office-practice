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

  late InverterDataSource inverterDataSource = InverterDataSource(inverterModelData: []);
  bool _isLoading = false;


  Future<List<InverterModel>> fetchData(String endPoint) async {
    const String _baseUrl = 'http://192.168.68.185:8000';
    const String authToken = '';

    final response = await http.get(Uri.parse(_baseUrl + endPoint), headers: {'Authorization': authToken});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return [
        InverterModel(
          name: endPoint.contains('today') ? 'Today' : 'Yesterday',
          energy: jsonData['energy'],
          pr: jsonData['pr'],
          acMaxPower: jsonData['ac_max_power'],
          dcMaxPower: jsonData['dc_max_power'],
          specificYield: jsonData['specific_yield'],

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
      final todayData = await fetchData('/single-today-data/');
      final yesterdayData = await fetchData('/single-yesterday-data/');


      final allData = [...todayData, ...yesterdayData];
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
          headerColor: const Color(0xffffffff).withOpacity(0.5),
        ),
        child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: inverterDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            rowHeight: 38.0,
            headerRowHeight: 40.0,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Name', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),))),
              GridColumn(
                  columnName: 'energy',
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Energy',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),
                      ))),
              GridColumn(
                columnName: 'pr',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('PR', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),),),
              GridColumn(
                columnName: 'acMaxPower',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Max (AC)', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),),),

              GridColumn(
                columnName: 'dcMaxPower',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Max (DC)', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),),),
              GridColumn(
                columnName: 'specificYield',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Specific Yield', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),),),
            ],

        ),
      ),
    );
  }
}
class InverterModel {
  final String name;
  final dynamic timeDate;
  final dynamic energy;
  final dynamic pr;
  final dynamic acMaxPower;
  final dynamic dcMaxPower;
  final dynamic specificYield;

  InverterModel({required this.name, this.timeDate, required this.energy, required this.pr, required this.acMaxPower, required this.dcMaxPower, required this.specificYield});

}

class InverterDataSource extends DataGridSource {

  List<DataGridRow> _inverterData = [];
  @override
  List<DataGridRow> get rows => _inverterData;


  InverterDataSource({required List<InverterModel> inverterModelData}) {
    _inverterData = inverterModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell(columnName: 'energy',value:  _formatValue('energy', e.energy)),
      DataGridCell(columnName: 'pr', value: _formatValue('pr', e.energy)),
      DataGridCell(columnName: 'acMaxPower', value: _formatValue('acMaxPower', e.energy)),
      DataGridCell(columnName: 'dcMaxPower', value: _formatValue('dcMaxPower', e.energy)),
      DataGridCell(columnName: 'specificYield', value: _formatValue('specificYield', e.energy)),
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

  String _formatValue(String columnName, dynamic value) {
    if (value == null) return '';

    switch (columnName) {
      case 'energy':
        return '${(value as double).toStringAsFixed(2)} kWh';
      case 'pr':
        return (value as double).toStringAsFixed(2);
      case 'acMaxPower':
        return '${(value as double).toStringAsFixed(2)} kW';
      case 'dcMaxPower':
        return '${(value as double).toStringAsFixed(2)} kW';
      case 'specificYield':
        return '${(value as double).toStringAsFixed(2)} kWh/kWp';
      default:
        return value.toString();
    }
  }

}