import 'package:flutter/material.dart';
import 'package:flutter_table/controllers/pv_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
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
                      final inv2Value = _pvController.invList[1]
                          .toJson()[entry.key]
                          .toString();
                      final inv3Value = _pvController.invList[2]
                          .toJson()[entry.key]
                          .toString();
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
      ),
    );
  }
}
