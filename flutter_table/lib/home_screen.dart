/*
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: DataTable(
             columns: const[
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Inv1')),
              DataColumn(label: Text('Inv2')),
              DataColumn(label: Text('Inv3')),
         ], rows: const [
           DataRow(cells: [
             DataCell(Text('PV01Voltage')),
             DataCell(Text('1.0')),
             DataCell(Text('2.0')),
             DataCell(Text('3.0')),
           ]),
           DataRow(cells: [
             DataCell(Text('PV01Current')),
             DataCell(Text('1.0')),
             DataCell(Text('2.0')),
             DataCell(Text('3.0')),
           ]),
           DataRow(cells: [
             DataCell(Text('PV02Voltage')),
             DataCell(Text('1.0')),
             DataCell(Text('2.0')),
             DataCell(Text('3.0')),
           ]),
           DataRow(cells: [
             DataCell(Text('PV02Current')),
             DataCell(Text('1.0')),
             DataCell(Text('2.0')),
             DataCell(Text('3.0')),
           ]),
         ]),
       ),
    ));
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_table/controllers/pv_controller.dart';
import 'package:get/get.dart';

/*class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key});



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<PVController>(
            builder: (_pvController) {
             print(  _pvController.myList.length);
              if(_pvController.isLoading){
                return const Center(child: CircularProgressIndicator());
              }
              return FittedBox(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Inv1')),
                    DataColumn(label: Text('Inv2')),
                    DataColumn(label: Text('Inv3')),
                  ],
                  rows: List<DataRow>.generate(
                    _pvController.myList.length,
                        (index) {
                      final inv1ListData = _pvController.myList[index];
                      return DataRow(
                        cells: [
                          DataCell(Text('pv01Voltage')),
                          DataCell(Text(inv1ListData.pv01Voltage.toString())),
                          DataCell(Text(inv1ListData.pv02Voltage.toString())),
                          DataCell(Text(inv1ListData.pv03Voltage.toString())),
                        ],
                      );
                    },
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_table/controllers/pv_controller.dart';
import 'package:flutter_table/pv_model/pv_model.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<PVController>(
                builder: (_pvController) {
                  print(_pvController.invList.length);
                  if (_pvController.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DataTable(
                    columns: const [
                      DataColumn(label: Text('Attribute')),
                      DataColumn(label: Text('Value (Inverter 1)')),
                      DataColumn(label: Text('Value (Inverter 2)')),
                      DataColumn(label: Text('Value (Inverter 3)')),
                    ],
                    rows: [
                      ..._pvController.invList[0].toJson().entries.map((entry) {
                        final attribute = entry.key;
                        final inv1Value = entry.value.toString();
                        final inv2Value = _pvController.invList[1].toJson()[entry.key].toString();
                        final inv3Value = _pvController.invList[2].toJson()[entry.key].toString();
                        return DataRow(
                          cells: [
                            DataCell(Text(attribute)),
                            DataCell(Text(inv1Value)),
                            DataCell(Text(inv2Value)),
                            DataCell(Text(inv3Value)),
                          ],
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
        ),
        );
  }
}