import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
       body: DataTable(
           columns: const[
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Inv1')),
            DataColumn(label: Text('Inv2')),
            DataColumn(label: Text('Inv3')),
       ], rows: const [
         DataRow(cells: [
           DataCell(Text('PV01Voltage')),
           DataCell(Text('PV01Current')),
           DataCell(Text('PV02Voltage')),
           DataCell(Text('PV02Current')),
         ])
       ]),
    ));
  }
}
