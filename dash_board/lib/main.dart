import 'package:dash_board/Views/Screens/ac_power_screen.dart';
import 'package:dash_board/Views/Screens/dash_board_screen.dart';
import 'package:dash_board/Views/Screens/dgr_screen.dart';
import 'package:dash_board/Views/Screens/splesh_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home:  const SplashScreen(),
      //home:  const AcPowerScreen(),
    );
  }
}




/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
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
  List<TemperatureModel> inverterData = <TemperatureModel>[];
  late InverterDataSource inverterDataSource;

  @override
  void initState() {
    super.initState();
    fetchDataAndUpdateDataSource();
  }

  Future<void> fetchDataAndUpdateDataSource() async {
    final response = await http.get(Uri.parse('http://192.168.60.60:8000/today-radiation/'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> tempuratureData = jsonData['radiation_today'];

      setState(() {
        inverterData = tempuratureData
            .map<TemperatureModel>((data) => TemperatureModel(
          formatDate(data['timedate']),
          data['ambient_temp'],
          data['module_temp'],
        ))
            .toList();
        inverterDataSource = InverterDataSource(temperatureModelData: inverterData);
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  String formatDate(String datetime) {
    final parsedDate = DateTime.parse(datetime);
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: inverterDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'timedate',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Time',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'ambient_temp',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Ambient Temperature',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'module_temp',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Module Temperature',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureModel {
  final String timedate;
  final double ambientTemp;
  final double moduleTemp;

  TemperatureModel(this.timedate, this.ambientTemp, this.moduleTemp);
}

class InverterDataSource extends DataGridSource {
  List<DataGridRow> _temperatureData = [];

  @override
  List<DataGridRow> get rows => _temperatureData;

  InverterDataSource({required List<TemperatureModel> temperatureModelData}) {
    _temperatureData = temperatureModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'timedate', value: e.timedate),
      DataGridCell(columnName: 'ambient_temp', value: e.ambientTemp.toStringAsFixed(2)),
      DataGridCell(columnName: 'module_temp', value: e.moduleTemp.toStringAsFixed(2)),
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
*/


/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
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
  List<RadiationModel> radiationDataList = <RadiationModel>[];

  @override
  void initState() {
    super.initState();
    fetchDataAndUpdateDataSource();
  }

  Future<void> fetchDataAndUpdateDataSource() async {
    final response = await http.get(Uri.parse('http://192.168.60.60:8000/today-radiation/'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> temperatureData = jsonData['radiation_today'];

      setState(() {
        radiationDataList = temperatureData.reversed
            .map<RadiationModel>((data) => RadiationModel(
          formatDate(data['timedate']),
          data['radiation_east'],
          data['radiation_west'],
          data['radiation_north'],
          data['radiation_south'],
          data['radiation_south_15'],
        ))
            .toList();
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  String formatDate(String datetime) {
    final parsedDate = DateTime.parse(datetime);
    final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body:radiationDataList.isEmpty ? const Center(child: CircularProgressIndicator()) : SfDataGrid(
        source: RadiationDataSource(radiationModelData: radiationDataList),
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'timedate',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Time',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_east',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation East',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_west',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation West',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_north',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation North',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_south',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation South',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_south_15',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation South 15',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadiationModel {
  final String timedate;
  final double radiationEast;
  final double radiationWest;
  final double radiationNorth;
  final double radiationSouth;
  final double radiationSouth15;

  RadiationModel(this.timedate, this.radiationEast, this.radiationWest, this.radiationNorth, this.radiationSouth, this.radiationSouth15);
}

class RadiationDataSource extends DataGridSource {
  List<DataGridRow> _radiationData = [];

  @override
  List<DataGridRow> get rows => _radiationData;

  RadiationDataSource({required List<RadiationModel> radiationModelData}) {
    _radiationData = radiationModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'timedate', value: e.timedate),
      DataGridCell(columnName: 'radiation_east', value: e.radiationEast.toStringAsFixed(2)),
      DataGridCell(columnName: 'radiation_west', value: e.radiationWest.toStringAsFixed(2)),
      DataGridCell(columnName: 'radiation_north', value: e.radiationNorth.toStringAsFixed(2)),
      DataGridCell(columnName: 'radiation_south', value: e.radiationSouth.toStringAsFixed(2)),
      DataGridCell(columnName: 'radiation_south_15', value: e.radiationSouth15.toStringAsFixed(2)),
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
*/
