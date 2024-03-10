import 'package:data_grid_app/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeDataSource extends DataGridSource{
List<DataGridRow> _employeeData = [];
@override
List<DataGridRow> get rows => _employeeData;

EmployeeDataSource({required List<EmployeeModel> employeeData}){
  _employeeData =  employeeData.map<DataGridRow>((e) => DataGridRow(cells: [
    DataGridCell<int>(columnName: 'id', value: e.id),
    DataGridCell<String>(columnName: 'name', value: e.name),
    DataGridCell<String>(columnName: 'designation', value: e.designation),
    DataGridCell<int>(columnName: 'salary', value: e.salary),

  ])).toList();
}



  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
   return DataGridRowAdapter(cells: row.getCells().map<Widget>((dataGridCell) {
     return Container(
       width: double.infinity,
       alignment: Alignment.center,
       padding: const EdgeInsets.all(8.0),
       child: Text(
         dataGridCell.value.toString(),
         overflow: TextOverflow.ellipsis,
       ),
     );
   }).toList()
   );
  }

}