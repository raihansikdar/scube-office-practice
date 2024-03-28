import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../models/temperature/temperature_model.dart';


class TemperatureApiService {
  static const String _baseUrl = 'http://192.168.60.60:8000';
  static const String _authToken = '';

  static Future<List<TemperatureModel>> fetchTemperatureData() async {
    final response = await http.get(Uri.parse('$_baseUrl/today-radiation/'), headers: {'Authorization': _authToken});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> temperatureData = jsonData['radiation_today'];
      return temperatureData.reversed
          .map<TemperatureModel>((data) => TemperatureModel(
        formatDate(data['timedate']),
        data['ambient_temp'],
        data['module_temp'],
      ))
          .toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  static String formatDate(String datetime) {
    final parsedDate = DateTime.parse(datetime);
    final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(parsedDate);
  }
}
