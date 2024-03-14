// import 'package:flutter/material.dart';
// import 'package:flutter_table/controllers/pv_controller.dart';
// import 'package:flutter_table/pv_model/pv_model.dart';
// import 'package:get/get.dart';
//
// class HomeScreen extends StatelessWidget {
//   HomeScreen({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GetBuilder<PVController>(
//                   builder: (_pvController) {
//                     print(_pvController.invList.length);
//                     if (_pvController.isLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     return DataTable(
//                       columns: const [
//                         DataColumn(label: Text('Attribute')),
//                         DataColumn(label: Text('Value (Inverter 1)')),
//                         DataColumn(label: Text('Value (Inverter 2)')),
//                         DataColumn(label: Text('Value (Inverter 3)')),
//                       ],
//                       rows: [
//                         ..._pvController.invList[0].toJson().entries.map((entry) {
//                           final attribute = entry.key;
//                           final inv1Value = entry.value.toString();
//                           final inv2Value = _pvController.invList[1].toJson()[entry.key].toString();
//                           final inv3Value = _pvController.invList[2].toJson()[entry.key].toString();
//                           return DataRow(
//                             cells: [
//                               DataCell(Text(attribute)),
//                               DataCell(Text(inv1Value)),
//                               DataCell(Text(inv2Value)),
//                               DataCell(Text(inv3Value)),
//                             ],
//                           );
//                         }),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//            ),
//         );
//     }
// }
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
        body: GetBuilder<PVController>(
          builder: (_pvController) {
            if (_pvController.isLoading && _pvController.invList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child:ListView.builder(
                    itemCount: _pvController.invList.length,
                    itemBuilder: (context, index) {
                      if (index % 10 == 0 && index != 0) {
                        _pvController.currentPage++;
                        if (!_pvController.isLoading && _pvController.currentPage <= 3) {
                          _pvController.getInv1Data();
                        }
                      }

                      final pvModel = _pvController.invList[index];
                      return DataTable(
                        columns: const [
                          DataColumn(label: Text('Attribute')),
                          DataColumn(label: Text('Value (Inverter 1)')),
                          DataColumn(label: Text('Value (Inverter 2)')),
                          DataColumn(label: Text('Value (Inverter 3)')),
                        ],
                        rows: pvModel.toJson().entries.map((entry) {
                          final attribute = entry.key;
                          final inv1Value = entry.value.toString();
                          final inv2Value =
                          index + 1 < _pvController.invList.length
                              ? _pvController.invList[index + 1]
                              .toJson()[entry.key]
                              .toString()
                              : '';
                          final inv3Value =
                          index + 2 < _pvController.invList.length
                              ? _pvController.invList[index + 2]
                              .toJson()[entry.key]
                              .toString()
                              : '';
                          return DataRow(
                            cells: [
                              DataCell(Text(attribute)),
                              DataCell(Text(inv1Value)),
                              DataCell(Text(inv2Value)),
                              DataCell(Text(inv3Value)),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  )

                ),
                if (_pvController.isLoading && _pvController.invList.isNotEmpty)
                  const CircularProgressIndicator(),
                if (!_pvController.isLoading &&
                    _pvController.currentPage == 3)
                  const Text('No more data'),
              ],
            );
          },
        ),
      ),
    );
  }
}
