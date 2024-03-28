import 'dart:convert';
import 'dart:developer';

import 'package:dash_board/Views/Widgets/ac_power_widget/ac_power_gause_widget.dart';
import 'package:dash_board/api_services/ac_power/ac_power_gauge_api_service.dart';
import 'package:dash_board/api_services/ac_power/today_ac_power_api_sevice.dart';
import 'package:dash_board/models/ac_power/ac_gauge_power_model.dart';
import 'package:dash_board/models/ac_power/today_ac_power_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
class AcPowerScreen extends StatefulWidget {
  const AcPowerScreen({super.key});

  @override
  State<AcPowerScreen> createState() => _AcPowerScreenState();
}

class _AcPowerScreenState extends State<AcPowerScreen> {

  AcGaugePowerModel? acGaugePowerModel;
  List<TodayAcPowerModel> todayAcPowerList = [];

  Future<void> fetchData() async {
    try {
      final acGaugeData = await AcPowerGaugeApiService.fetchAcPowerGaugeData();
      final todayAcPowerData = await TodayAcPowerApiService.fetchTodayAcPowerData();

      setState(() {
        acGaugePowerModel = acGaugeData;
        todayAcPowerList = todayAcPowerData;
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
        title: const Text('SQ Solar Plant'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            AcPowerGaugeWidget(acGaugePowerModel: acGaugePowerModel),
        
            todayAcPowerList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Container(
              height: 600,
                  child: SfDataGrid(
                              source: InverterDataSource(todayAcPowerModelData: todayAcPowerList),
                              columnWidthMode: ColumnWidthMode.fill,
                              columns: <GridColumn>[
                  GridColumn(
                    columnName: 'timedate',
                    label: Container(
                      color: Colors.cyan.withOpacity(0.2),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Date & Time',
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
                        'Ac Power',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                              ],
                            ),
                ),
        
          ],
        ),
      ),
    );
  }}

class InverterDataSource extends DataGridSource {
  final List<TodayAcPowerModel> todayAcPowerModelData;

  InverterDataSource({required this.todayAcPowerModelData});

  @override
  List<DataGridRow> get rows => todayAcPowerModelData.map<DataGridRow>((e) {
    return DataGridRow(cells: [
      DataGridCell<String>(columnName: 'timedate', value: e.timedate),
      DataGridCell<String>(columnName: 'plant', value: e.formattedPlantWithUnit()),

    ]);
  }).toList();

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


