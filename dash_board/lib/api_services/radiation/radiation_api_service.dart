import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/radiation/radiation_model.dart';

class RadiationApiService {
  static Future<List<RadiationModel>> fetchRadiationData() async {
    final response = await http.get(Uri.parse('http://192.168.60.60:8000/today-radiation/'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> temperatureData = jsonData['radiation_today'];

      return temperatureData.reversed.map<RadiationModel>((data) => RadiationModel(
        formatDate(data['timedate']),
        data['radiation_east'],
        data['radiation_west'],
        data['radiation_north'],
        data['radiation_south'],
        data['radiation_south_15'],
      )).toList();
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
