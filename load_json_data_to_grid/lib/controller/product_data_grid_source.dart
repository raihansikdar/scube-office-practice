/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:load_json_data_to_grid/models/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Product> productList;
  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          DateFormat('MM/dd/yyyy').format(row.getCells()[3].value).toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[4].value.toStringAsFixed(1),
            overflow: TextOverflow.ellipsis,
          ))
    ]);
  }



  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'orderID', value: dataGridRow.orderID),
        DataGridCell<String>(
            columnName: 'customerID', value: dataGridRow.customerID),
        DataGridCell<int>(
            columnName: 'employeeID', value: dataGridRow.employeeID),
        DataGridCell<DateTime>(
            columnName: 'orderDate', value: dataGridRow.orderDate),
        DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight)
      ]);
    }).toList(growable: false);
  }
}
*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:load_json_data_to_grid/models/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Product> productList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          DateFormat('MM/dd/yyyy').format(row.getCells()[3].value).toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[4].value.toStringAsFixed(1),
            overflow: TextOverflow.ellipsis,
          ))
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'orderID', value: dataGridRow.orderID),
        DataGridCell<String>(
            columnName: 'customerID', value: dataGridRow.customerID),
        DataGridCell<int>(
            columnName: 'employeeID', value: dataGridRow.employeeID),
        DataGridCell<DateTime>(
            columnName: 'orderDate', value: dataGridRow.orderDate),
        DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight)
      ]);
    }).toList(growable: false);
  }
}