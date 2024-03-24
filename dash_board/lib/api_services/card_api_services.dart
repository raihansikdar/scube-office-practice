import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dash_board/models/card_power_model.dart';

class CardApiServices{

  static Future<CardPowerModel>fetchCardData()async{
    const String _baseUrl = 'http://192.168.60.60:8000/';
    const String authToken = '';

    String todayGenerationEndPoint = '/single-today-generation/';
    String yesterdayGenerationEndPoint = '/single-yesterday-generation/';
    String tempAndRadiationEndPoint = '/single-radiation/';
    String grossProfitEndPoint = '/single-gross-profit/';


    final todayGenerationResponse = await http.get(Uri.parse(_baseUrl + todayGenerationEndPoint), headers: {'Authorization': authToken});
    final yesterdayGenerationResponse = await http.get(Uri.parse(_baseUrl + yesterdayGenerationEndPoint), headers: {'Authorization': authToken});
    final tempAndRadiationResponse = await http.get(Uri.parse(_baseUrl + tempAndRadiationEndPoint), headers: {'Authorization': authToken});
    final grossProfitResponse = await http.get(Uri.parse(_baseUrl + grossProfitEndPoint), headers: {'Authorization': authToken});



    if(todayGenerationResponse.statusCode == 200 && yesterdayGenerationResponse.statusCode == 200 && tempAndRadiationResponse.statusCode ==200 && grossProfitResponse.statusCode==200){
      final todayGenerationJsonData = jsonDecode(todayGenerationResponse.body);
      final yesterdayGenerationJsonData = jsonDecode(yesterdayGenerationResponse.body);
      final tempAndRadiationJsonData = jsonDecode(tempAndRadiationResponse.body);
      final grossProfitJsonData = jsonDecode(grossProfitResponse.body);


      return CardPowerModel(
        todayGeneration: todayGenerationJsonData['plant'],
        yesterdayGeneration: yesterdayGenerationJsonData['plant'],
        moduleTemp: tempAndRadiationJsonData['module_temp'],
        ambientTemp: tempAndRadiationJsonData['ambient_temp'],
        radiationEast: tempAndRadiationJsonData['radiation_east'],
        radiationWest: tempAndRadiationJsonData['radiation_west'],
        radiationNorth: tempAndRadiationJsonData['radiation_north'],
        radiationSouth: tempAndRadiationJsonData['radiation_south'],
        radiationSouth15: tempAndRadiationJsonData['radiation_south_15'],
        energyCost: grossProfitJsonData['energy_cost'],
      );

    }else {
      throw Exception('Failed to load data');
    }
  }
}