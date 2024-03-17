import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      home: const Combine3Api(),
    );
  }
}

class Combine3Api extends StatefulWidget {
  const Combine3Api({Key? key}) : super(key: key);

  @override
  _Combine3ApiState createState() => _Combine3ApiState();
}

class _Combine3ApiState extends State<Combine3Api> {
  //late Future<List<InverterModel>> futureData;
  List<InverterModel> inverterData = [];
  late InverterDataSource _inverterDataSource;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    //futureData = fetchData();
    fetchData();
  }

  Future< /*List<InverterModel>*/ void> fetchData() async {
    final response1 = await http.get(
      Uri.parse(
          'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter01/'),
      headers: {
        "Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"
      },
    );
    final response2 = await http.get(
      Uri.parse(
          'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter02/'),
      headers: {
        "Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"
      },
    );
    final response3 = await http.get(
      Uri.parse(
          'https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter03/'),
      headers: {
        "Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"
      },
    );

    if (response1.statusCode == 200 &&
        response2.statusCode == 200 &&
        response3.statusCode == 200) {
      Map<String, dynamic> json1 = jsonDecode(response1.body);
      Map<String, dynamic> json2 = jsonDecode(response2.body);
      Map<String, dynamic> json3 = jsonDecode(response3.body);

      setState(() {
        json1.forEach((key, value) {
          String formattedKey = key
              .replaceAll('_', ' ')
              .split(' ')
              .map((String word) => word[0].toUpperCase() + word.substring(1))
              .join(' ');
          if (key == 'timedate') {
            formattedKey = 'Time & Date';
          }
          inverterData.add(InverterModel(
            name: formattedKey,
            inverter1: value,
            inverter2: json2[key],
            inverter3: json3[key],
          ));

          _inverterDataSource =
              InverterDataSource(inverterModelData: inverterData);
          _isLoading = false;
        });
      });
      //return data;
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
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SfDataGrid(
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                source: _inverterDataSource,
                onQueryRowHeight: (RowHeightDetails details) {
                  if (details.rowIndex == 0) {
                    return 20.0;
                  }
                  return details.rowHeight;
                },
                //allowSorting: true,
                columnWidthMode: ColumnWidthMode.fill,
                columns: <GridColumn>[
                    GridColumn(
                        columnName: 'name',
                        label: Container(
                            color: Colors.cyan.withOpacity(0.2),
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ))),
                    GridColumn(
                        columnName: 'inverter1',
                        label: Container(
                            color: Colors.cyan.withOpacity(0.2),
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Inverter1',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ))),
                    GridColumn(
                        columnName: 'inverter2',
                        label: Container(
                            color: Colors.cyan.withOpacity(0.2),
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Inverter2',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ))),
                    GridColumn(
                        columnName: 'inverter3',
                        label: Container(
                            color: Colors.cyan.withOpacity(0.2),
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Inverter3',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ))),
                  ],
                stackedHeaderRows: <StackedHeaderRow>[
                    StackedHeaderRow(cells: [
                      StackedHeaderCell(
                          columnNames: [
                            'inverter1',
                            'inverter2',
                          ],
                          child: Container(
                              color: const Color(0xFFF1F1F1),
                              child: const Center(
                                  child: Text('Electricity monitoring')))),
                    ]),
                  ]));
  }
}

class InverterModel {
  final String name;
  final dynamic inverter1;
  final dynamic inverter2;
  final dynamic inverter3;

  InverterModel(
      {required this.name,
      required this.inverter1,
      required this.inverter2,
      required this.inverter3});

  String getFormattedData(dynamic data, String key) {
    if (key == 'tamedate' && data is String) {
      try {
        final parsedDate = DateTime.parse(data);
        final formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
        final formattedTime = DateFormat('hh:mm').format(parsedDate);
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
    _inverterData = inverterModelData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell(
                  columnName: 'inverter1',
                  value: e.getFormattedData(e.inverter1, 'tamedate')),
              DataGridCell(
                  columnName: 'inverter2',
                  value: e.getFormattedData(e.inverter2, 'tamedate')),
              DataGridCell(
                  columnName: 'inverter3',
                  value: e.getFormattedData(e.inverter3, 'tamedate')),
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
