import 'dart:convert';

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

  List<InverterModel> rebData = <InverterModel>[];
  List<InverterModel> generator1Data = <InverterModel>[];
  List<InverterModel> generator2Data = <InverterModel>[];
  //late InverterDataSource inverterDataSource;
  late InverterDataSource inverterDataSource = InverterDataSource(inverterModelData: []);
  bool _isLoading = false;


  Future<void> fetchData() async {

    _isLoading = true;
    setState(() {});
    const String _baseUrl = 'https://scubetech.xyz/kazi-habibpur';
    const String authToken = 'Token 264ae90790a4275c27829533c55800f05301e308';

    const String renEndPoint = '/monitor-load-reb/';
    const String generator1EndPoint = '/monitor-load-generator1/';
    const String generator1nEndPoint = '/monitor-load-generator2/';


    try {
      final rebResponse = await http.get(Uri.parse(_baseUrl+ renEndPoint), headers: {'Authorization': authToken});
      final generator1Response = await http.get(Uri.parse(_baseUrl+ generator1EndPoint), headers: {'Authorization': authToken});
      final generator2Response = await http.get(Uri.parse(_baseUrl+ generator1nEndPoint), headers: {'Authorization': authToken});

      if (rebResponse.statusCode == 200 && generator1Response.statusCode == 200 && generator2Response.statusCode == 200) {
        final rebJsonData = jsonDecode(rebResponse.body);
        final generator1JsonData = jsonDecode(generator1Response.body);
        final generator2JsonData = jsonDecode(generator2Response.body);

        setState(() {
          rebData = [
            InverterModel(
                name: 'Reb',
                livePower: rebJsonData['live_power'],
                liveFrequency: rebJsonData['live_frequency'],
                liveVoltageL1: rebJsonData['live_voltage_l1'],
                liveVoltageL2: rebJsonData['live_voltage_l2'],
                liveVoltageL3: rebJsonData['live_voltage_l3'],
                liveCurrentL1: rebJsonData['live_current_l1'],
                liveCurrentL2: rebJsonData['live_current_l2'],
                liveCurrentL3: rebJsonData['live_current_l3'],
                averageCurrentHarmonics: rebJsonData['average_current_harmonics'],
                averageVoltageHarmonics: rebJsonData['average_voltage_harmonics'],
                todaysEnergy: rebJsonData['todays_energy'])
          ];
          generator1Data = [
            InverterModel(
                name: 'Generator 1',
                livePower: generator1JsonData['live_power'],
                liveFrequency: generator1JsonData['live_frequency'],
                liveVoltageL1: generator1JsonData['live_voltage_l1'],
                liveVoltageL2: generator1JsonData['live_voltage_l2'],
                liveVoltageL3: generator1JsonData['live_voltage_l3'],
                liveCurrentL1: generator1JsonData['live_current_l1'],
                liveCurrentL2: generator1JsonData['live_current_l2'],
                liveCurrentL3: generator1JsonData['live_current_l3'],
                averageCurrentHarmonics: generator1JsonData['average_current_harmonics'],
                averageVoltageHarmonics: generator1JsonData['average_voltage_harmonics'],
                todaysEnergy: generator1JsonData['todays_energy'])
          ];
          generator2Data = [
            InverterModel(
                name: 'Generator 2',
                livePower: generator2JsonData['live_power'],
                liveFrequency: generator2JsonData['live_frequency'],
                liveVoltageL1: generator2JsonData['live_voltage_l1'],
                liveVoltageL2: generator2JsonData['live_voltage_l2'],
                liveVoltageL3: generator2JsonData['live_voltage_l3'],
                liveCurrentL1: generator2JsonData['live_current_l1'],
                liveCurrentL2: generator2JsonData['live_current_l2'],
                liveCurrentL3: generator2JsonData['live_current_l3'],
                averageCurrentHarmonics: generator2JsonData['average_current_harmonics'],
                averageVoltageHarmonics: generator2JsonData['average_voltage_harmonics'],
                todaysEnergy: generator2JsonData['todays_energy'])
          ];

          // Concatenate all three lists
          final List<InverterModel> allData = [...rebData, ...generator1Data, ...generator2Data];

          // Pass concatenated data to the data source
          inverterDataSource = InverterDataSource(inverterModelData: allData);

          //inverterDataSource = InverterDataSource(inverterModelData: rebData);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
}