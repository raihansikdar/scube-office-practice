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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<PVController>(
              builder: (_pvController) {
                if(_pvController.isLoading){
                  return Center(child: CircularProgressIndicator());
                }
                const int itemsPerPage = 10;
                final int currentPage = _pvController.currentPage;
                final List<PVModel> invList = _pvController.invList;

                final int startIndex = currentPage * itemsPerPage;
                final int endIndex = (currentPage + 1) * itemsPerPage;

                final List<PVModel> currentPageData = invList.sublist(
                  startIndex,
                  endIndex < invList.length ? endIndex : invList.length,
                );

                return Column(
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Attribute')),
                        DataColumn(label: Text('Value (Inverter 1)')),
                        DataColumn(label: Text('Value (Inverter 2)')),
                        DataColumn(label: Text('Value (Inverter 3)')),
                      ],
                      rows: [
                        for (final pvModel in currentPageData)
                          ...pvModel.toJson().entries.map((entry) {
                            final attribute = entry.key;
                            final inv1Value = entry.value.toString();
                            final inv2Value = pvModel.toJson()[entry.key].toString();
                            final inv3Value = pvModel.toJson()[entry.key].toString();
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
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: _pvController.previousPage,
                        ),
                        Text('Page ${currentPage + 1}'),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: _pvController.nextPage,
                        ),
                      ],
                    ),
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


