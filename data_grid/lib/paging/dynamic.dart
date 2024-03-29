// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Syncfusion DataGrid Demo',
//       theme: ThemeData(useMaterial3: false),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Future<List<InverterModel>> futureData;
//   List<InverterModel> allData = [];
//   List<InverterModel> paginatedData = [];
//   int rowsPerPage = 15;
//   int currentPageIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     futureData = fetchData();
//   }
//
//   Future<List<InverterModel>> fetchData() async {
//     final response1 = await http.get(
//       Uri.parse('https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter01/'),
//       headers: {"Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"},
//     );
//     final response2 = await http.get(
//       Uri.parse('https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter02/'),
//       headers: {"Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"},
//     );
//     final response3 = await http.get(
//       Uri.parse('https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter03/'),
//       headers: {"Authorization": "Token 264ae90790a4275c27829533c55800f05301e308"},
//     );
//
//     if (response1.statusCode == 200 &&
//         response2.statusCode == 200 &&
//         response3.statusCode == 200) {
//       Map<String, dynamic> json1 = jsonDecode(response1.body);
//       Map<String, dynamic> json2 = jsonDecode(response2.body);
//       Map<String, dynamic> json3 = jsonDecode(response3.body);
//       List<InverterModel> data = [];
//       json1.forEach((key, value) {
//         data.add(InverterModel(key, value, json2[key], json3[key]));
//       });
//       allData = List.from(data);
//       paginateData();
//       return paginatedData;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   void paginateData() {
//     final int startIndex = currentPageIndex * rowsPerPage;
//     final int endIndex = startIndex + rowsPerPage;
//     paginatedData = allData.sublist(startIndex, endIndex);
//   }
//
//   Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
//     currentPageIndex = newPageIndex;
//     paginateData();
//     setState(() {});
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Syncfusion Flutter DataGrid'),
//       ),
//       body: FutureBuilder<List<InverterModel>>(
//         future: futureData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           } else if (snapshot.hasData) {
//             return SfDataGrid(
//               gridLinesVisibility: GridLinesVisibility.both,
//               headerGridLinesVisibility: GridLinesVisibility.both,
//               source: InverterDataSource(inverterModelData: snapshot.data!),
//               onQueryRowHeight: (RowHeightDetails details) {
//                 if (details.rowIndex == 0) {
//                   return 20.0;
//                 }
//                 return details.rowHeight;
//               },
//               columnWidthMode: ColumnWidthMode.fill,
//               columns: <GridColumn>[
//                 GridColumn(
//                   columnName: 'name',
//                   label: Container(
//                     color: Colors.cyan.withOpacity(0.2),
//                     padding: const EdgeInsets.all(8.0),
//                     alignment: Alignment.center,
//                     child: const Text('Name', style: TextStyle(fontWeight: FontWeight.w600)),
//                   ),
//                 ),
//                 GridColumn(
//                   columnName: 'inverter1',
//                   label: Container(
//                     color: Colors.cyan.withOpacity(0.2),
//                     padding: const EdgeInsets.all(8.0),
//                     alignment: Alignment.center,
//                     child: const Text(
//                       'Inverter1',
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//                 GridColumn(
//                   columnName: 'inverter2',
//                   label: Container(
//                     color: Colors.cyan.withOpacity(0.2),
//                     padding: const EdgeInsets.all(8.0),
//                     alignment: Alignment.center,
//                     child: const Text(
//                       'Inverter2',
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//                 GridColumn(
//                   columnName: 'inverter3',
//                   label: Container(
//                     color: Colors.cyan.withOpacity(0.2),
//                     padding: const EdgeInsets.all(8.0),
//                     alignment: Alignment.center,
//                     child: const Text(
//                       'Inverter3',
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ],
//               stackedHeaderRows: <StackedHeaderRow>[
//                 StackedHeaderRow(
//                   cells: [
//                     StackedHeaderCell(
//                       columnNames: ['inverter1', 'inverter2'],
//                       child: Container(
//                         color: const Color(0xFFF1F1F1),
//                         child: const Center(child: Text('Electricity monitoring')),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//               footer: SfDataPager(
//                 delegate: _MyDataPagerDelegate(allData, rowsPerPage),
//                 pageCount: (allData.length / rowsPerPage).toDouble().ceil(),
//               ),
//             );
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
//
// class InverterModel {
//   final String name;
//   final dynamic inverter1;
//   final dynamic inverter2;
//   final dynamic inverter3;
//
//   InverterModel(this.name, this.inverter1, this.inverter2, this.inverter3);
// }
//
// class InverterDataSource extends DataGridSource {
//   final List<InverterModel> inverterModelData;
//
//   InverterDataSource({required this.inverterModelData});
//
//   @override
//   List<DataGridRow> get rows => inverterModelData
//       .map<DataGridRow>((e) => DataGridRow(cells: [
//     DataGridCell<String>(columnName: 'name', value: e.name),
//     DataGridCell(columnName: 'inverter1', value: e.inverter1.toString()),
//     DataGridCell(columnName: 'inverter2', value: e.inverter2.toString()),
//     DataGridCell(columnName: 'inverter3', value: e.inverter3.toString()),
//   ]))
//       .toList();
//
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//       cells: row.getCells().map<Widget>((e) {
//         return Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: Text(e.value.toString()),
//         );
//       }).toList(),
//     );
//   }
// }
//
// class _MyDataPagerDelegate extends DataPagerDelegate {
//   final List<InverterModel> allData;
//   final int rowsPerPage;
//
//   _MyDataPagerDelegate(this.allData, this.rowsPerPage);
//
//   @override
//   int pageCount = 0;
//
//   @override
//   int get rowCount => allData.length;
//
//   @override
//   Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
//     return true;
//   }
//
//   @override
//   Future<bool> moveToPage(int pageIndex) async {
//     return true;
//   }
// }