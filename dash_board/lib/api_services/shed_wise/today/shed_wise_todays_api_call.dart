import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../models/shed_wise/shed_wise_model.dart';


class ShedWiseTodaysApiService {
  static Future<List<ShedWiseModel>> fetchShedWiseTodayData() async {
    final response = await http.get(Uri.parse('http://192.168.60.60:8000/shedwise-today/'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> shedWiseData = jsonData;

      return shedWiseData
          .reversed
          .map<ShedWiseModel>((data) => ShedWiseModel(
        formatDate(data['timedate']),
        data['plant'],
        data['huse_building'],
        data['birichina'],
        data['canteen'],
        data['finished_goods_warehouse'],
        data['circular_knitting'],
        data['central_warehouse'],
        data['celsius_building'],
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
