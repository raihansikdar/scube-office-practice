/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:load_json_data_to_grid/controller/product_data_controller.dart';
import 'package:load_json_data_to_grid/controller/product_data_grid_source.dart';
import 'package:load_json_data_to_grid/models/pv_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> getProductDataSource() async {
    final controller = Get.put(ProductDataController());
    await controller.getGridData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProductDataController>(
          builder: (controller) {
            return controller.isLoading
                ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            )
                : SfDataGrid(
              source: ProductDataGridSource(controller.productList),
              columns: getColumns(),
            );
          },
        ),
      ),
    );
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
        columnName: 'orderID',
        width: 70,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Order ID',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'customerID',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            'Customer ID',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'employeeID',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Employee ID',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'orderDate',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            'Order Date',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'freight',
        width: 65,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text('Freight'),
        ),
      ),
    ];
  }




*/
/*List<GridColumn> _getColumns() {
    List<GridColumn> columns = [];

    var fields = Product.getFieldNames();

    for (var field in fields) {
      columns.add(
        GridColumn(
          columnName: field,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
              field,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    print("Column Count: ${columns.length}");
    return columns;
  }*//*

}
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${substring(1)}";
//   }
// }*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:load_json_data_to_grid/controller/product_data_controller.dart';
import 'package:load_json_data_to_grid/controller/product_data_grid_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key,}) : super(key: key);



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: getProductDataSource(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.hasData
                  ? SfDataGrid(
                  source: snapshot.data,
                  columnWidthMode: ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  stackedHeaderRows: <StackedHeaderRow>[
                    StackedHeaderRow(cells: [
                      StackedHeaderCell(
                          columnNames: ['pv01Voltage', 'pv01Current', 'pv02Voltage', 'pv02Current','pv03Voltage','pv03Current'],
                          child: Container(
                              color: const Color(0xFFF1F1F1),
                              child: const Center(child: Text('PV Model')))),
                    ]),
                    StackedHeaderRow(cells: [
                      StackedHeaderCell(
                          columnNames: ['pv01Voltage', 'pv01Current'],
                          child: Container(
                              color: const Color(0xFFF1F1F1),
                              child: const Center(child: Text('PV01')))),
                      StackedHeaderCell(
                          columnNames: ['pv02Voltage', 'pv02Current'],
                          child: Container(
                              color: const Color(0xFFF1F1F1),
                              child: const Center(child: Text('PV02')))),
                      StackedHeaderCell(
                          columnNames: ['pv03Voltage', 'pv03Current'],
                          child: Container(
                              color: const Color(0xFFF1F1F1),
                              child: const Center(child: Text('PV03'))))
                    ])
                  ],
                  columns: getColumns())
                  : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              );
            },
          ),
        ));
  }



  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await Get.find<ProductDataController>().generatePVModelList();
    return ProductDataGridSource(productList);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'pv01Voltage',
           width: 100,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Pv01Voltage',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'pv01Current',
          width: 100,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Pv01Current',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'pv02Voltage',
          width: 100,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Pv02Voltage',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'pv02Current',
          width: 100,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Pv02Current',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'pv03Voltage',
          width: 100,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('pv03Voltage',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'pv03Current',
          width: 100,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Pv03Current',

                  overflow: TextOverflow.clip, softWrap: true))),

    ];
  }}