import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../api_services/tempurature/temperature_api_service.dart';
import '../../models/temperature/temperature_model.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
   List<TemperatureModel> temperatureDataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataAndUpdateDataSource();
  }

  Future<void> fetchDataAndUpdateDataSource() async {
    try {
      final List<TemperatureModel> temperatureData = await TemperatureApiService.fetchTemperatureData();
      setState(() {
        temperatureDataList = temperatureData;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: temperatureDataList.isEmpty ? const Center(child: CircularProgressIndicator()) : SfDataGrid(
        source:TemperatureDataSource(temperatureModelData: temperatureDataList),
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
            columnName: 'ambient_temp',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Ambient Temperature',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'module_temp',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Module Temperature',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class TemperatureDataSource extends DataGridSource {
  List<DataGridRow> _temperatureData = [];

  @override
  List<DataGridRow> get rows => _temperatureData;

  TemperatureDataSource({required List<TemperatureModel> temperatureModelData}) {
    _temperatureData = temperatureModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'timedate', value: e.timedate),
      DataGridCell(columnName: 'ambient_temp', value: '${e.ambientTemp.toStringAsFixed(2)}°C'),
      DataGridCell(columnName: 'module_temp', value: '${e.moduleTemp.toStringAsFixed(2)}°C'),
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
        }).toList());
  }
}