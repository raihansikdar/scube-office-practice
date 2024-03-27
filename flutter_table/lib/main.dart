import 'package:flutter/material.dart';
import 'package:flutter_table/bindings/state_holders_binder.dart';
import 'package:flutter_table/data_table_screen.dart';
import 'package:flutter_table/views/home_screen.dart';
import 'package:flutter_table/table_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     // initialBinding: StateHoldersBinders(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   HomeScreen(),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TableScreen(),
  ));
}

class Ambient {
  final String time;
  final double ambientTemperature;

  Ambient({required this.time, required this.ambientTemperature});
}

class Module {
  final String time;
  final double moduleTemperature;

  Module({required this.time, required this.moduleTemperature});
}

class TableScreen extends StatelessWidget {
  final List<Ambient> _ambientTemperatures = List.generate(50, (index) {
    final time = DateTime(2024, 3, 25, 9, 0, 0).add(Duration(minutes: 15 * index));
    final ambientTemperature = 25.0 + index * 0.1;
    return Ambient(time: time.toString(), ambientTemperature: ambientTemperature);
  });

  final List<Module> _moduleTemperatures = List.generate(50, (index) {
    final time = DateTime(2024, 3, 25, 9, 0, 0).add(Duration(minutes: 15 * index));
    final moduleTemperature = 30.0 + index * 0.1;
    return Module(time: time.toString(), moduleTemperature: moduleTemperature);
  });


  DateTime? getDateTimeFromString(String dateTimeString) {
    return dateTimeString != null ? DateTime.parse(dateTimeString) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Table'),
      ),
      body: Column(
        children: [
  Container(
            color: Colors.orange,
            height: 40,
            child: const Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Ambient',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Module',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Scrollbar(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    transform: Matrix4.translationValues(7.0, -55.0, 0.0),
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: SizedBox(
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          numeric: true,
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          numeric: true,
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          numeric: true,
                        ),
                      ],
                      rows: _ambientTemperatures.isEmpty ||
                          _moduleTemperatures.isEmpty
                          ? []
                          : _ambientTemperatures.map<DataRow>((ambient) {
                        final moduleTemperature = _moduleTemperatures
                            .firstWhere(
                                (t) => t.time == ambient.time,
                            orElse: () => Module(
                                time: '', moduleTemperature: 0.0));
                        final time = getDateTimeFromString(ambient.time);
                        if (time == null) {
                          return const DataRow(cells: []);
                        }
                        final formattedTime =
                        DateFormat('hh:mm:ss ').format(time);
                        return DataRow(cells: [
                          DataCell(
                            Center(
                              child: SizedBox(
                                width: 55,
                                child: Text(
                                  formattedTime,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: SizedBox(
                                width: 55,
                                child: Text(
                                  ambient.ambientTemperature.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: SizedBox(
                                width: 70,
                                child: Text(
                                  moduleTemperature.moduleTemperature
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
