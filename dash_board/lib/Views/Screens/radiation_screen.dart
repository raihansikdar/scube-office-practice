import 'dart:developer';

import 'package:dash_board/api_services/radiation/radiation_api_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/radiation/radiation_model.dart';

class RadiationScreen extends StatefulWidget {
  const RadiationScreen({super.key});

  @override
  State<RadiationScreen> createState() => _RadiationScreenState();
}

class _RadiationScreenState extends State<RadiationScreen> {

  List<RadiationModel> radiationDataList =[];

  Future<void> fetchData() async {
    try {
      final List<RadiationModel> radiationData = await RadiationApiService.fetchRadiationData();
      setState(() {
        radiationDataList = radiationData;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Syncfusion Flutter DataGrid'),
        automaticallyImplyLeading: false,
      ),
      body:radiationDataList.isEmpty ? const Center(child: CircularProgressIndicator()) : SfDataGrid(
        source: RadiationDataSource(radiationModelData: radiationDataList),
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
            columnName: 'radiation_east',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation East',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_west',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation West',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_north',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation North',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_south',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation South',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridColumn(
            columnName: 'radiation_south_15',
            label: Container(
              color: Colors.cyan.withOpacity(0.2),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Radiation South 15',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class RadiationDataSource extends DataGridSource {
  List<DataGridRow> _radiationData = [];

  @override
  List<DataGridRow> get rows => _radiationData;

  RadiationDataSource({required List<RadiationModel> radiationModelData}) {
    _radiationData = radiationModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'timedate', value: e.timedate),
      DataGridCell(columnName: 'radiation_east', value: e.radiationEast.toStringAsFixed(2)),
      DataGridCell(columnName: 'radiation_west', value: e.radiationWest.toStringAsFixed(2)),
      DataGridCell(columnName: 'radiation_north', value: e.radiationNorth.toStringAsFixed(2)),
      DataGridCell(columnName: 'radiation_south', value: e.radiationSouth.toStringAsFixed(2)),
      DataGridCell(columnName: 'radiation_south_15', value: e.radiationSouth15.toStringAsFixed(2)),
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
