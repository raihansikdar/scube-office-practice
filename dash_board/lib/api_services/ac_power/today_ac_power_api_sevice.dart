import 'dart:convert';
import 'package:dash_board/models/ac_power/today_ac_power_model.dart';
import 'package:http/http.dart' as http;
import '../../Views/Screens/ac_power_screen.dart';


class TodayAcPowerApiService {
  static const String _baseUrl = 'http://192.168.60.60:8000';
  static const String _authToken = '';

  static Future<List<TodayAcPowerModel>> fetchTodayAcPowerData() async {
    final response = await http.get(Uri.parse('$_baseUrl/today-ac-power/'), headers: {'Authorization': _authToken});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['power_today'];
      final List<TodayAcPowerModel> data = jsonData.map<TodayAcPowerModel>((json) => TodayAcPowerModel.fromJson(json)).toList();
      return data.reversed.toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
