import 'dart:convert';
import 'package:http/http.dart' as http;

class LineChartApiService {
  static const String _baseUrl = 'http://192.168.60.60:8000';
  static const String radiationEndPoint = '/today-radiation/';
  static const String powerEndPoint = '/today-ac-power/';

  static Future<Map<String, dynamic>> fetchLineChartData() async {
    final radiationResponse = await http.get(Uri.parse(_baseUrl + radiationEndPoint));
    final powerResponse = await http.get(Uri.parse(_baseUrl + powerEndPoint));

    if (radiationResponse.statusCode == 200 && powerResponse.statusCode == 200) {
      final Map<String, dynamic> data = {
        'radiation_today': json.decode(radiationResponse.body)['radiation_today'],
        'power_today': json.decode(powerResponse.body)['power_today'],
      };
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
