import 'package:flutter/material.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Table"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          border: TableBorder.all(width: 2),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children:  [
          const TableRow(
            decoration: BoxDecoration(
              color: Colors.redAccent
            ),
            children: [
              TableCell(child: Center(child: Text('Header1',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
              TableCell(child: Center(child: Text('Header2',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
              TableCell(child: Center(child: Text('Header3',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
            ]
          ),
          ...List.generate(20, (index) => const TableRow(
            children: [
                    TableCell(child: Center(child: Text('Cell 1'))),
                    TableCell(child: Center(child: Text('Cell 2'))),
                    TableCell(child: Center(child: Text('Cell 2'))),

            ]
          ))
        ],
        ),
      ),
    );
  }
}
