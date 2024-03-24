import 'dart:convert';
import 'package:dash_board/models/gauge_power_model.dart';
import 'package:http/http.dart' as http;


class GaugeApiService {
  static const String _baseUrl = 'http://192.168.60.60:8000';
  static const String _authToken = '';

  static Future<GaugePowerModel> fetchGaugeData() async {
    String acPowerEndPoint = '/single-ac-power/';
    String othersEndPoint = '/single-cumulative-pr/';

      final acPowerResponse = await http.get(Uri.parse(_baseUrl + acPowerEndPoint), headers: {'Authorization': _authToken});

      final otherResponse = await http.get(Uri.parse(_baseUrl + othersEndPoint), headers: {'Authorization': _authToken});

      if (acPowerResponse.statusCode == 200 && otherResponse.statusCode == 200) {

        final acPowerJsonData = jsonDecode(acPowerResponse.body);
        final othersJsonData = jsonDecode(otherResponse.body);

        return GaugePowerModel(
          acPlant: acPowerJsonData['plant'],
          prPlant: othersJsonData['plant'],
          poaAvg: othersJsonData['poa_avg'],
          poaDayAvg: othersJsonData['poa_day_avg'],
        );
      } else {
        throw Exception('Failed to load data');
      }
  }
}
