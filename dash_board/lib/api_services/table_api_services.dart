import 'dart:convert';
import 'package:dash_board/models/table_inverter_model.dart';
import 'package:http/http.dart' as http;


class TableApiService {
  static const String _baseUrl = 'http://192.168.60.60:8000';
  static const String authToken = '';

  static Future<List<InverterModel>> fetchTableData(String endPoint) async {
    final response =
    await http.get(Uri.parse(_baseUrl + endPoint), headers: {'Authorization': authToken});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return [
        InverterModel(
          name: endPoint.contains('shed_wise') ? 'Today' : 'Yesterday',
          energy: jsonData['energy'],
          pr: jsonData['pr'],
          acMaxPower: jsonData['ac_max_power'],
          dcMaxPower: jsonData['dc_max_power'],
          specificYield: jsonData['specific_yield'],
        )
      ];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
