import 'package:dash_board/models/table_inverter_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class TableWidget extends StatelessWidget {
  const TableWidget({
    super.key,
    required this.inverterDataSource,
  });

  final InverterDataSource inverterDataSource;

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: Colors.deepPurple,
        ),
        child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: inverterDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            rowHeight: 38.0,
            headerRowHeight: 40.0,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Name',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)))),
              GridColumn(
                  columnName: 'energy',
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Energy',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                      ))),
              GridColumn(
                columnName: 'pr',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'PR',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'acMaxPower',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Max (AC)',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'dcMaxPower',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Max (DC)',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'specificYield',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Specific Yield',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),


    );
  }
}
class InverterDataSource extends DataGridSource {

  List<DataGridRow> _inverterData = [];
  @override
  List<DataGridRow> get rows => _inverterData;


  InverterDataSource({required List<InverterModel> inverterModelData}) {
    _inverterData = inverterModelData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell(columnName: 'energy',value:  _formatValue('energy', e.energy)),
      DataGridCell(columnName: 'pr', value: _formatValue('pr', e.energy)),
      DataGridCell(columnName: 'acMaxPower', value: _formatValue('acMaxPower', e.energy)),
      DataGridCell(columnName: 'dcMaxPower', value: _formatValue('dcMaxPower', e.energy)),
      DataGridCell(columnName: 'specificYield', value: _formatValue('specificYield', e.energy)),
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

  String _formatValue(String columnName, dynamic value) {
    if (value == null) return '';

    switch (columnName) {
      case 'energy':
        return '${(value as double).toStringAsFixed(2)} kWh';
      case 'pr':
        return (value as double).toStringAsFixed(2);
      case 'acMaxPower':
        return '${(value as double).toStringAsFixed(2)} kW';
      case 'dcMaxPower':
        return '${(value as double).toStringAsFixed(2)} kW';
      case 'specificYield':
        return '${(value as double).toStringAsFixed(2)} kWh/kWp';
      default:
        return value.toString();
    }
  }

}