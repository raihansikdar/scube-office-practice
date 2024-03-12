/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:load_json_data_to_grid/models/pv_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Inv2DataGridSource extends DataGridSource {
  Inv2DataGridSource(this.inv2List) {
    buildInv2DataGridRow();
  }
  late List<DataGridRow> inv2DataGridRows;
  late List<PVModel> inv2List;

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

  @override
  List<DataGridRow> get rows => inv2DataGridRows;


  void buildInv2DataGridRow() {
    inv2DataGridRows = inv2List.map<DataGridRow>((inv2DataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'Pv01Voltage', value: inv2DataGridRow.pv01Voltage.toString()),
        DataGridCell(
            columnName: 'Pv01Current', value: inv2DataGridRow.pv01Current.toString()),
        DataGridCell(
            columnName: 'Pv02Voltage', value: inv2DataGridRow.pv02Voltage.toString()),
        DataGridCell(
            columnName: 'Pv02Current', value: inv2DataGridRow.pv02Current.toString()),
        DataGridCell(
            columnName: 'Pv03Voltage', value: inv2DataGridRow.pv03Voltage.toString()),
        DataGridCell(
            columnName: 'Pv03Current', value: inv2DataGridRow.pv03Current.toString()),
      ]);
    }).toList(growable: false);
  }
}*/


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:load_json_data_to_grid/models/pv_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Inv2DataGridSource extends DataGridSource {
  Inv2DataGridSource(this.inv2List) {
    buildInv2DataGridRow();
  }

  late List<DataGridRow> inv2DataGridRows;
  late List<PVModel> inv2List;

  @override
  List<DataGridRow> get rows => inv2DataGridRows;


  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    List<Widget> cellWidget = [];
    for (int i = 0; i < row.getCells().length; i++) {
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



/*  void buildInv2DataGridRow() {
    inv2DataGridRows = inv2List.map<DataGridRow>((inv2DataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(
          columnName: 'PVName',
          value: 'Pv01Voltage: ${inv2DataGridRow.pv01Voltage}, Pv01Current: ${inv2DataGridRow.pv01Current}',
        ),
        DataGridCell(
          columnName: 'PVName',
          value: 'Pv02Voltage: ${inv2DataGridRow.pv02Voltage}, Pv02Current: ${inv2DataGridRow.pv02Current}',
        ),
        DataGridCell(
          columnName: 'PVName',
          value: 'Pv03Voltage: ${inv2DataGridRow.pv03Voltage}, Pv03Current: ${inv2DataGridRow.pv03Current}',
        ),
      ]);
    }).toList(growable: false);
  }*/


  void buildInv2DataGridRow() {
    inv2DataGridRows = inv2List.map<DataGridRow>((inv2DataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(
          columnName: 'name',
          value: inv2DataGridRow.name,
        ),

      ]);
    }).toList(growable: false);
  }







/*  void buildInv2DataGridRow() {
    inv2DataGridRows = inv2List.map<DataGridRow>((inv2DataGridRow) {
      return DataGridRow(cells: [
        const DataGridCell(
          columnName: 'PVName',
          value: 'PV01', // You can customize this value based on your requirements
        ),
        DataGridCell(
          columnName: 'Pv01Voltage',
          value: inv2DataGridRow.pv01Voltage.toString(),
        ),
        DataGridCell(
          columnName: 'Pv01Current',
          value: inv2DataGridRow.pv01Current.toString(),
        ),
        const DataGridCell(
          columnName: 'PVName',
          value: 'PV02', // You can customize this value based on your requirements
        ),
        DataGridCell(
          columnName: 'Pv02Voltage',
          value: inv2DataGridRow.pv02Voltage.toString(),
        ),
        DataGridCell(
          columnName: 'Pv02Current',
          value: inv2DataGridRow.pv02Current.toString(),
        ),
        // Add similar sections for PV03 and other columns if needed
      ]);
    }).toList(growable: false);
  }*/
}

