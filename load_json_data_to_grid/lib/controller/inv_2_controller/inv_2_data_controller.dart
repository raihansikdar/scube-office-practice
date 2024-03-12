import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:load_json_data_to_grid/models/pv_model.dart';

import 'package:http/http.dart' as http;
import 'package:load_json_data_to_grid/services/network_caller.dart';
import 'package:load_json_data_to_grid/services/network_response.dart';
import 'package:load_json_data_to_grid/utility/urls.dart';

class Inv2DataController extends GetxController{
   List<PVModel> inv2List = [];

   @override
    void onInit(){
     generateInv2ModelList();
     super.onInit();
   }

/*   Future<List<PVModel>> generateProductList() async {
     var response = await http.get(Uri.parse(
         'https://ej2services.syncfusion.com/production/web-services/api/Orders'));
     var decodedProducts = json.decode(response.body).cast<Map<String, dynamic>>();
     List<PVModel> inv2List = await decodedProducts
         .map<PVModel>((json) => Product.fromJson(json))
         .toList();
     return inv2List;
   }*/

  Future<List<PVModel>> generateInv2ModelList() async {
    NetworkResponse response = await NetworkCaller.getRequest(AppUrls.inv2Url);

    try {
      if (response.isSuccess) {

        if (response.body is Map<String, dynamic>) {
          PVModel pvModel = PVModel.fromJson(response.body);
          return [pvModel];
        } else if (response.body is List<dynamic>) {
          List<dynamic> decodedInv2Data = response.body;
           inv2List = decodedInv2Data.map<PVModel>((json) => PVModel.fromJson(json)).toList();
          return inv2List;
        } else {
          log("Unknown response body type");
        }
      } else {
        log("Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Exception: $e");
    }

    return [];
  }



}