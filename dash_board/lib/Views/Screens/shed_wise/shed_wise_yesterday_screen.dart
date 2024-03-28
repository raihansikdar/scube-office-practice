import 'dart:developer';

import 'package:dash_board/api_services/shed_wise/yesterday/shed_wise_yesterday_api_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../models/shed_wise/shed_wise_model.dart';

class ShedWiseYesterdayScreen extends StatefulWidget {
  const ShedWiseYesterdayScreen({super.key});

  @override
  State<ShedWiseYesterdayScreen> createState() => _ShedWiseYesterdayScreenState();
}

class _ShedWiseYesterdayScreenState extends State<ShedWiseYesterdayScreen> {


  List<ShedWiseModel> shedWiseYesterdayDataList = [];


  Future<void> fetchData() async {
    try {
      final yesterdayData = await ShedWiseYesterdaysApiService.fetchShedWiseYesterdayData();
      setState(() {
        shedWiseYesterdayDataList = yesterdayData;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shed wise Yesterday data'),
        automaticallyImplyLeading: false,
      ),
      body: shedWiseYesterdayDataList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SfDataGrid(
        source: ShedWiseDataSource(shedWiseTodaysModelData: shedWiseYesterdayDataList),
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'timedate',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Time',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'huse_building',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Huse Building',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'birichina',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Birichina',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'canteen',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Canteen',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'finished_goods_warehouse',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Finished Goods Warehouse',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'circular_knitting',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Circular Knitting',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'central_warehouse',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Central Warehouse',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'celsius_building',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Celsius Building',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'plant',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Yesterday Generation',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ShedWiseDataSource extends DataGridSource {
  List<DataGridRow> _shedWiseTodaysData = [];

  @override
  List<DataGridRow> get rows => _shedWiseTodaysData;

  ShedWiseDataSource({required List<ShedWiseModel> shedWiseTodaysModelData}) {
    _shedWiseTodaysData = shedWiseTodaysModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'timedate', value: e.timedate),
      DataGridCell(columnName: 'huse_building', value: e.huseBuilding.toStringAsFixed(2)),
      DataGridCell(columnName: 'birichina', value: e.birichina.toStringAsFixed(2)),
      DataGridCell(columnName: 'canteen', value: e.canteen.toStringAsFixed(2)),
      DataGridCell(columnName: 'finished_goods_warehouse', value: e.finishedGoodsWarehouse.toStringAsFixed(2)),
      DataGridCell(columnName: 'circular_knitting', value: e.circularKnitting.toStringAsFixed(2)),
      DataGridCell(columnName: 'central_warehouse', value: e.centralWarehouse.toStringAsFixed(2)),
      DataGridCell(columnName: 'celsius_building', value: e.celsiusBuilding.toStringAsFixed(2)),
      DataGridCell(columnName: 'plant', value: e.plant.toStringAsFixed(2)),
    ])).toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(e.value.toString()),
        );
      }).toList(),
    );
  }
}