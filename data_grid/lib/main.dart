import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  late Future<List<InverterModel>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List<InverterModel>> fetchData() async {
    final response1 = await http.get(
      Uri.parse('https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter01/'),
      headers: {"Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"},
    );
    final response2 = await http.get(
      Uri.parse('https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter02/'),
      headers: {"Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"},
    );
    final response3 = await http.get(
      Uri.parse('https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter03/'),
      headers: {"Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"},
    );

    if (response1.statusCode == 200 && response2.statusCode == 200 && response3.statusCode == 200) {
      Map<String, dynamic> json1 = jsonDecode(response1.body);
      Map<String, dynamic> json2 = jsonDecode(response2.body);
      Map<String, dynamic> json3 = jsonDecode(response3.body);

      List<InverterModel> data = [];

      json1.forEach((key, value) {
        String formattedKey = key.replaceAll('_', ' ').split(' ').map((String word) => word[0].toUpperCase() + word.substring(1)).join(' ');
        if (key == 'timedate') {
          formattedKey = 'Time & Date';
        }
        data.add(InverterModel(
          name: formattedKey,
          inverter1: value,
          inverter2: json2[key],
          inverter3: json3[key],
        ));
      });
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: FutureBuilder<List<InverterModel>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SfDataGridTheme(
              data: SfDataGridThemeData(
                headerColor: const Color(0xff9ea8bf).withOpacity(0.95),
                sortIconColor: const Color(0xfff7f8fa),
              ),
              child: SfDataGrid(
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                source: InverterDataSource(inverterModelData: snapshot.data!),
                allowSorting: true,
                columnWidthMode: ColumnWidthMode.fill,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'name',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Name', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                  GridColumn(
                    columnName: 'inverter1',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Inverter1', overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                  GridColumn(
                    columnName: 'inverter2',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Inverter2', overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                  GridColumn(
                    columnName: 'inverter3',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Inverter3', overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class InverterModel {
  final String name;
  final dynamic inverter1;
  final dynamic inverter2;
  final dynamic inverter3;

  InverterModel({required this.name, required this.inverter1, required this.inverter2, required this.inverter3});

  String getFormattedData(dynamic data, String key) {
    if (key == 'tamedate' && data is String) {
      try {
        final parsedDate = DateTime.parse(data);
        final formattedDate = DateFormat('dd/MMM/yyyy').format(parsedDate);
        final formattedTime = DateFormat('hh:mm a').format(parsedDate);
        return '$formattedDate $formattedTime';
      } catch (e) {
        return 'Invalid Date';
      }
    } else if (data is num) {
      return data.toStringAsFixed(2);
    }
    return data.toString();
  }
}

class InverterDataSource extends DataGridSource {
  List<DataGridRow> _inverterData = [];

  @override
  List<DataGridRow> get rows => _inverterData;

  InverterDataSource({required List<InverterModel> inverterModelData}) {
    _inverterData = inverterModelData.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'name', value: e.name),
        DataGridCell(columnName: 'inverter1', value: e.getFormattedData(e.inverter1, 'tamedate')),
        DataGridCell(columnName: 'inverter2', value: e.getFormattedData(e.inverter2, 'tamedate')),
        DataGridCell(columnName: 'inverter3', value: e.getFormattedData(e.inverter3, 'tamedate')),
      ]);
    }).toList();
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
      }).toList(),
    );
  }
}

