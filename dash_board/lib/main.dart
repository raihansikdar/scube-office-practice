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
  List<ShedWiseTodaysModel> shedWisetodaysDataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataAndUpdateDataSource();
  }

  Future<void> fetchDataAndUpdateDataSource() async {
    final response = await http.get(Uri.parse('http://192.168.60.60:8000/shedwise-shed_wise/'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> shedWiseTodaysData = jsonData;

      setState(() {
        shedWisetodaysDataList = shedWiseTodaysData.reversed.map<ShedWiseTodaysModel>((data) => ShedWiseTodaysModel(
          formatDate(data['timedate']),
          data['plant'],
          data['huse_building'],
          data['birichina'],
          data['canteen'],
          data['finished_goods_warehouse'],
          data['circular_knitting'],
          data['central_warehouse'],
          data['celsius_building'],
        )).toList();
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
      body: shedWisetodaysDataList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SfDataGrid(
        source: ShedWiseDataSource(shedWisetodaysModelData: shedWisetodaysDataList),
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
            columnName: 'huse_building',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Huse Building',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'birichina',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Birichina',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'canteen',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Canteen',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'finished_goods_warehouse',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Finished Goods Warehouse',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'circular_knitting',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Circular Knitting',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'central_warehouse',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Central Warehouse',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'celsius_building',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Celsius Building',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'plant',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Today\'s Generation',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShedWiseTodaysModel {
  final String timedate;
  final double plant;
  final double huseBuilding;
  final double birichina;
  final double canteen;
  final double finishedGoodsWarehouse;
  final double circularKnitting;
  final double centralWarehouse;
  final double celsiusBuilding;

  ShedWiseTodaysModel(
      this.timedate,
      this.plant,
      this.huseBuilding,
      this.birichina,
      this.canteen,
      this.finishedGoodsWarehouse,
      this.circularKnitting,
      this.centralWarehouse,
      this.celsiusBuilding);
}

class ShedWiseDataSource extends DataGridSource {
  List<DataGridRow> _shedWisetodaysData = [];

  @override
  List<DataGridRow> get rows => _shedWisetodaysData;

  ShedWiseDataSource({required List<ShedWiseTodaysModel> shedWisetodaysModelData}) {
    _shedWisetodaysData = shedWisetodaysModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'timedate', value: e.timedate),
      DataGridCell(columnName: 'huse_building', value: e.huseBuilding.toStringAsFixed(2)),
      DataGridCell(columnName: 'birichina', value: e.birichina.toStringAsFixed(2)),
      DataGridCell(columnName: 'canteen', value: e.canteen.toStringAsFixed(2)),
      DataGridCell(columnName: 'finished_goods_warehouse', value: e.finishedGoodsWarehouse.toStringAsFixed(2)),
      DataGridCell(columnName: 'circular_knitting', value: e.circularKnitting.toStringAsFixed(2)),
      DataGridCell(columnName: 'central_warehouse', value: e.centralWarehouse.toStringAsFixed(2)),
      DataGridCell(columnName: 'celsius_building', value: e.celsiusBuilding.toStringAsFixed(2)),
      DataGridCell(columnName: 'plant', value: e.plant.toStringAsFixed(2)),
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
      }).toList(),
    );
  }
}
*/
