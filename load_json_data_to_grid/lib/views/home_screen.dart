/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:load_json_data_to_grid/controller/inv_2_controller/inv_2_data_controller.dart';
import 'package:load_json_data_to_grid/controller/inv_2_controller/inv_2_data_grid_source.dart';
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



  Future<Inv2DataGridSource> getProductDataSource() async {
    var inv2List = await Get.find<Inv2DataController>().generateInv2ModelList();
    return Inv2DataGridSource(inv2List);
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
  }}*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:load_json_data_to_grid/controller/inv_2_controller/inv_2_data_controller.dart';
import 'package:load_json_data_to_grid/controller/inv_2_controller/inv_2_data_grid_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

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
                    /*stackedHeaderRows: <StackedHeaderRow>[
                StackedHeaderRow(cells: [
                  StackedHeaderCell(
                    columnNames: ['PVName'],
                    child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: const Center(child: Text('PV Model')),
                    ),
                  ),
                ]),
                StackedHeaderRow(cells: [
                  StackedHeaderCell(
                    columnNames: ['PVName'],
                    child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: const Center(child: Text('PV01')),
                    ),
                  ),
                  StackedHeaderCell(
                    columnNames: ['PVName'],
                    child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: const Center(child: Text('PV02')),
                    ),
                  ),
                  StackedHeaderCell(
                    columnNames: ['PVName'],
                    child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: const Center(child: Text('PV03')),
                    ),
                  ),
                ])
              ],*/
                    columns: getColumns(),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  );
          },
        ),
      ),
    );
  }

  Future<Inv2DataGridSource> getProductDataSource() async {
    var inv2List = await Get.find<Inv2DataController>().generateInv2ModelList();
    return Inv2DataGridSource(inv2List);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
        columnName: 'name',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: const Text(
            'Name',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
    ];
  }

  /* List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
        columnName: 'PVName',
        //width: 100,
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: const Text(
            'PVName',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'PV01', // Change based on actual data name
        //width: 100,
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: const Text(
            'PV01',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'PV02', // Change based on actual data name
        //width: 100, // Adjust width as needed
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: const Text(
            'PV02',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
    ];
  }*/
}
