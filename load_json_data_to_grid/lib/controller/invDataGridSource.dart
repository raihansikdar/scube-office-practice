import 'package:flutter/material.dart';
import 'package:load_json_data_to_grid/models/pv_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InvDataGridSource extends DataGridSource {
  InvDataGridSource(List<PVModel> invList) {
    invDataGridRows = invList.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'Pv01Voltage', value: e.pv01Voltage.toString()),
        DataGridCell(
            columnName: 'Pv01Current', value: e.pv01Current.toString()),
        DataGridCell(
            columnName: 'Pv02Voltage', value: e.pv02Voltage.toString()),
        DataGridCell(
            columnName: 'Pv02Current', value: e.pv02Current.toString()),
        DataGridCell(
            columnName: 'Pv03Voltage', value: e.pv03Voltage.toString()),
        DataGridCell(
            columnName: 'Pv03Current', value: e.pv03Current.toString()),
      ]);
    }).toList(growable: false);
    //buildInv2DataGridRow();
  }
  late List<DataGridRow> invDataGridRows;
  late List<PVModel> invList;
  @override
  List<DataGridRow> get rows => invDataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {

    List<Widget>cellWidget =[];
    for(int i=0;i<row.getCells().length;i++){
      cellWidget.add(
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[i].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    return DataGridRowAdapter(cells: cellWidget);

  }




  // void buildInv2DataGridRow() {
  //   invDataGridRows = invList.map<DataGridRow>((e) {
  //     return DataGridRow(cells: [
  //       DataGridCell(columnName: 'Pv01Voltage', value: e.pv01Voltage.toString()),
  //       DataGridCell(
  //           columnName: 'Pv01Current', value: e.pv01Current.toString()),
  //       DataGridCell(
  //           columnName: 'Pv02Voltage', value: e.pv02Voltage.toString()),
  //       DataGridCell(
  //           columnName: 'Pv02Current', value: e.pv02Current.toString()),
  //       DataGridCell(
  //           columnName: 'Pv03Voltage', value: e.pv03Voltage.toString()),
  //       DataGridCell(
  //           columnName: 'Pv03Current', value: e.pv03Current.toString()),
  //     ]);
  //   }).toList(growable: false);
  // }
}
