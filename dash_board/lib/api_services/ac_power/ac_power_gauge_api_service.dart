import 'dart:convert';
import 'package:dash_board/models/ac_power/ac_gauge_power_model.dart';
import 'package:http/http.dart' as http;


class AcPowerGaugeApiService {
  static const String _baseUrl = 'http://192.168.60.60:8000';
  static const String _authToken = '';

  static Future<AcGaugePowerModel> fetchAcPowerGaugeData() async {
    String acPowerEndPoint = '/single-ac-power/';

    final acPowerResponse = await http.get(Uri.parse(_baseUrl + acPowerEndPoint), headers: {'Authorization': _authToken});


    if (acPowerResponse.statusCode == 200) {
      final acPowerJsonData = jsonDecode(acPowerResponse.body);

      return AcGaugePowerModel(
        acPlant: acPowerJsonData['plant'],
      );
    } else {
      throw Exception('Failed to load data');
    }
  }
}
