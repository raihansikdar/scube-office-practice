import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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

  List<InverterModel> inverterData = <InverterModel>[];
  late InverterDataSource inverterDataSource;

  List<InverterModel> getInverterData() {
    return [
      InverterModel(
        name: 'Data 1',
        livePower: 0.3591359853744507,
        liveFrequency: 50.72381591796875,
        liveVoltageL1: 237.47216796875,
        liveVoltageL2: 237.67471313476562,
        liveVoltageL3: 236.54852294921875,
        liveCurrentL1: 2.002931833267212,
        liveCurrentL2: 0.07126521319150925,
        liveCurrentL3: 0.2548253536224365,
        averageCurrentHarmonics: 2.84,
        averageVoltageHarmonics: 16.85,
        todaysEnergy: 0.039706528186798096,
      ),

      InverterModel(
        name: 'Data 2',
        livePower: 10.3591359853744507,
        liveFrequency: 150.72381591796875,
        liveVoltageL1: 1237.47216796875,
        liveVoltageL2: 1237.67471313476562,
        liveVoltageL3: 1236.54852294921875,
        liveCurrentL1: 12.002931833267212,
        liveCurrentL2: 10.07126521319150925,
        liveCurrentL3: 10.2548253536224365,
        averageCurrentHarmonics: 0,
        averageVoltageHarmonics: 0,
        todaysEnergy: 10.039706528186798096,
      ),
    ];
  }
  @override
  void initState() {
    super.initState();
    inverterData = getInverterData();
    inverterDataSource = InverterDataSource(inverterModelData: inverterData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGridTheme(
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