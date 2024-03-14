import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


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
  late InverterDataSource employeeDataSource;

  List<InverterModel> getInverterData() {
    return [
      InverterModel('timedate',    1123, 1123 , 1123),
      InverterModel('pv01_voltage', 2, 3, 3),
      InverterModel('pv01_current', 0, 4, 6),
      InverterModel('pv02_voltage', 6, 3, 4),
      InverterModel('pv02_current', 9, 8, 0),
      InverterModel('pv03_voltage', 0, 0, 6),
      InverterModel('pv03_current', 0, 0, 0),
      InverterModel('pv04_voltage', 3, 9, 8),
      InverterModel('pv04_current', 3, 8, 0),
      InverterModel('pv05_voltage', 6, 0, 9),
      InverterModel('pv06_current', 0, 0, 5),
      InverterModel('pv07_voltage', 10, 0,6),
      InverterModel('pv07_current', 0, 0, 2),
    ];
  }



  @override
  void initState() {
    super.initState();
    inverterData = getInverterData();
    employeeDataSource = InverterDataSource(inverterModelData: inverterData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: employeeDataSource,
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'name',
              label: Container(
                  color: Colors.cyan.withOpacity(0.2),
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Name', style: TextStyle(fontWeight: FontWeight.w600),))),
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
                  child: const Text('Inverter2', style: TextStyle(fontWeight: FontWeight.w600),),),),
          GridColumn(
              columnName: 'inverter3',
              label: Container(
                color: Colors.cyan.withOpacity(0.2),
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Inverter3', style: TextStyle(fontWeight: FontWeight.w600),),),),
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
      DataGridCell(columnName: 'inverter1', value: e.inverter1.toString()),
      DataGridCell(columnName: 'inverter2', value: e.inverter2.toString()),
      DataGridCell(columnName: 'inverter3', value: e.inverter3.toString()),
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