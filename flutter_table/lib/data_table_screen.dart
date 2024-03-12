import 'package:flutter/material.dart';

class DataTableScreen extends StatelessWidget {
  const DataTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table'),
      ),
      body: DataTable(
        //sortColumnIndex: 0,
      //sortAscending: true,
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Age'),numeric: true),
            DataColumn(label: Text('Designation')),
          ],
          rows: const[
            DataRow(
                selected: true,
                cells: [

              DataCell(Text('Rafsan'),showEditIcon: true),
              DataCell(Text('20')),
              DataCell(Text('student')),
            ]),
            DataRow(cells: [
              DataCell(Text('Momin')),
              DataCell(Text('22')),
              DataCell(Text('student')),
            ]),
            DataRow(cells: [
              DataCell(Text('Akib Mia')),
              DataCell(Text('50')),
              DataCell(Text('Teacher')),
            ]),  DataRow(cells: [
              DataCell(Text('Jibon')),
              DataCell(Text('20')),
              DataCell(Text('student')),
            ]),


          ],
      )

    );
  }
}
