import 'package:data_grid_app/employee_data_source.dart';
import 'package:data_grid_app/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  // List<EmployeeModel> getEmployeeData(){
  //   return [
  //     EmployeeModel(10001, 'James', 'Project Lead', 20000),
  //     EmployeeModel(10002, 'Kathryn', 'Manager', 30000),
  //     EmployeeModel(10003, 'Lara', 'Developer', 15000),
  //     EmployeeModel(10004, 'Michael', 'Designer', 15000),
  //     EmployeeModel(10005, 'Martin', 'Developer', 15000),
  //     EmployeeModel(10006, 'Newberry', 'Developer', 15000),
  //     EmployeeModel(10007, 'Balnc', 'Developer', 15000),
  //     EmployeeModel(10008, 'Perry', 'Developer', 15000),
  //     EmployeeModel(10009, 'Gable', 'Developer', 15000),
  //     EmployeeModel(10010, 'Grimes', 'Developer', 15000)
  //   ];
  // }

  final List<EmployeeModel> _employee = [
      EmployeeModel(10001, 'James', 'Project Lead', 20000),
      EmployeeModel(10002, 'Kathryn', 'Manager', 30000),
      EmployeeModel(10003, 'Lara', 'Developer', 15000),
      EmployeeModel(10004, 'Michael', 'Designer', 15000),
      EmployeeModel(10005, 'Martin', 'Developer', 15000),
      EmployeeModel(10006, 'Newberry', 'Developer', 15000),
      EmployeeModel(10007, 'Balnc', 'Developer', 15000),
      EmployeeModel(10008, 'Perry', 'Developer', 15000),
      EmployeeModel(10009, 'Gable', 'Developer', 15000),
      EmployeeModel(10010, 'Grimes', 'Developer', 15000)
    ];




 // late List<EmployeeModel> _employee;
  late EmployeeDataSource _employeeDataSource;

  @override
  void initState(){
   // _employee = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employeeData: _employee);
    super.initState();
  }
  final DataGridController _dataGridController = DataGridController();
  List<int> selectedIndex =[];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Grid Data'),
      ),
      body: Column(
        children: [
          TextButton(
              child: const Text('Get Selection Information'),
              onPressed: () {
                selectedIndex.add(_dataGridController.selectedIndex);
                DataGridRow selectedRow = _dataGridController.selectedRow!;
                List<DataGridRow> selectedRows = _dataGridController.selectedRows;
                print(selectedIndex);
                print(selectedRow.toString());
                print(selectedRows.toString());
              }),


          Expanded(
            child: SfDataGrid(
              controller: _dataGridController,
                source: _employeeDataSource,
                selectionMode: SelectionMode.multiple,
                allowSorting: true,
                allowFiltering: true,
                showColumnHeaderIconOnHover: true,
                columnWidthMode: ColumnWidthMode.fill, /// give column full screen size

                //showCheckboxColumn: true,
               // checkboxShape: const CircleBorder(),


                columns: _getColumns(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
                onPressed: () {
                  _employeeDataSource.sortedColumns.add(const SortColumnDetails(
                      name: 'name', sortDirection: DataGridSortDirection.ascending));
                  _employeeDataSource.sort();
                },
                child: const Text('Apply sort')),
          )
        ],
      ),
    );
  }

  List<GridColumn> _getColumns() {
    List<GridColumn> columns = [];

    var fields = EmployeeModel.getFieldNames();

    for (var field in fields) {
      columns.add(
        GridColumn(
          columnName: field,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
              field.capitalize(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    return columns;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
