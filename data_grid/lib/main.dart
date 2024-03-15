/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DataGrid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<InverterModel> inverterData = [];
  late InverterDataSource inverterDataSource;

  @override
  void initState() {
    super.initState();
    inverterDataSource = InverterDataSource(inverterModelData: inverterData);
    fetchData();
  }

  Future<void> fetchData() async {
    final token = 'Token 264ae90790a4275c27829533c55800f05301e308';
    final headers = {'Authorization': token};
    // URLs for the API calls
    final urls = [
      'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter01/',
      'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter02/',
      'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter03/',
    ];

    try {
      final responses = await Future.wait(urls.map((url) => http.get(Uri.parse(url), headers: headers)));
      final data = responses.map((response) => json.decode(response.body)).toList();

      // Update the inverterData list with the new data
      setState(() {
        inverterData = data.map((inverter) => InverterModel(
          'Inverter Data', // This is a placeholder name for all rows
          inverter['pv01_voltage'],
          inverter['pv02_voltage'],
          inverter['pv03_voltage'],
        )).toList();

        inverterDataSource = InverterDataSource(inverterModelData: inverterData);
      });
    } catch (e) {
      // Handle errors appropriately
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: inverterDataSource,
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'name',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Name', style: TextStyle(fontWeight: FontWeight.w600),))),
          // ... other GridColumn definitions ...
        ],
      ),
    );
  }
}

class InverterModel {
  final String name;
  final double inverter1;
  final double inverter2;
  final double inverter3;

  InverterModel(this.name, this.inverter1, this.inverter2, this.inverter3);
}

class InverterDataSource extends DataGridSource {
  List<DataGridRow> _inverterData = [];

  @override
  List<DataGridRow> get rows => _inverterData;

  InverterDataSource({required List<InverterModel> inverterModelData}) {
    _inverterData = inverterModelData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<double>(columnName: 'inverter1', value: e.inverter1),
      DataGridCell<double>(columnName: 'inverter2', value: e.inverter2),
      DataGridCell<double>(columnName: 'inverter3', value: e.inverter3),
    ]))
        .toList();
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
*/
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DataGrid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<InverterModel> inverterData = [];
  late InverterDataSource inverterDataSource;
  List<String> columnNames = ['name', 'inverter1', 'inverter2', 'inverter3'];

  @override
  void initState() {
    super.initState();
    inverterDataSource = InverterDataSource(inverterModelData: inverterData);
    fetchData();
  }

  Future<void> fetchData() async {
    const token = 'Token 264ae90790a4275c27829533c55800f05301e308';
    final headers = {'Authorization': token};
    // URLs for the API calls
    final urls = [
      'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter01/',
      'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter02/',
      'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter03/',
    ];

    try {
      final responses = await Future.wait(urls.map((url) => http.get(Uri.parse(url), headers: headers)));
      final data = responses.map((response) => json.decode(response.body)).toList();

      // Update the inverterData list with the new data
      setState(() {
        inverterData = data.map((inverter) => InverterModel(
          'Inverter Data', // This is a placeholder name for all rows
          inverter['pv01_voltage'],
          inverter['pv02_voltage'],
          inverter['pv03_voltage'],
        )).toList();

        inverterDataSource = InverterDataSource(inverterModelData: inverterData);
      });
    } catch (e) {
      // Handle errors appropriately
      print('Error fetching data: $e');
    }
  }

  List<GridColumn> generateColumns(List<String> columnNames) {
    return columnNames.map((name) {
      return GridColumn(
        columnName: name,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: inverterDataSource,
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        columns: generateColumns(columnNames),
      ),
    );
  }
}

class InverterModel {
  final String name;
  final double inverter1;
  final double inverter2;
  final double inverter3;

  InverterModel(this.name, this.inverter1, this.inverter2, this.inverter3);
}

class InverterDataSource extends DataGridSource {
  List<DataGridRow> _inverterData = [];

  @override
  List<DataGridRow> get rows => _inverterData;

  InverterDataSource({required List<InverterModel> inverterModelData}) {
    _inverterData = inverterModelData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<double>(columnName: 'inverter1', value: e.inverter1),
      DataGridCell<double>(columnName: 'inverter2', value: e.inverter2),
      DataGridCell<double>(columnName: 'inverter3', value: e.inverter3),
    ]))
        .toList();
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
