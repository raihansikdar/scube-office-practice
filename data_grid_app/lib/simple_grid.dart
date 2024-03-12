import 'package:data_grid_app/employee_data_source.dart';
import 'package:data_grid_app/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SimpleGrid extends StatefulWidget {
  const SimpleGrid({super.key});

  @override
  State<SimpleGrid> createState() => _SimpleGridState();
}

class _SimpleGridState extends State<SimpleGrid> {


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




  late EmployeeDataSource _employeeDataSource;

  @override
  void initState(){
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

                showCheckboxColumn: true,
                checkboxShape: const CircleBorder(),


                columns: [
                  GridColumn(
                    columnName: 'id',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('ID', overflow: TextOverflow.ellipsis,),
                    ),
                  ),

                  GridColumn(
                      columnName: 'name',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Name', overflow: TextOverflow.ellipsis,))),
                  GridColumn(
                      columnName: 'designation',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Designation',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'salary',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Salary', overflow: TextOverflow.ellipsis,))),


                ]),
          ),
        ],
      ),
    );
  }
}
