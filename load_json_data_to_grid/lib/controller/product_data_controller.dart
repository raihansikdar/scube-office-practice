import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:load_json_data_to_grid/models/pv_model.dart';

import 'package:http/http.dart' as http;
import 'package:load_json_data_to_grid/services/network_caller.dart';
import 'package:load_json_data_to_grid/services/network_response.dart';

class ProductDataController extends GetxController{
   List<PVModel> productList = [];

   @override
    void onInit(){
    // getGridData();
     generatePVModelList();
     super.onInit();
   }

/*   Future<List<Product>> generateProductList() async {
     var response = await http.get(Uri.parse(
         'https://ej2services.syncfusion.com/production/web-services/api/Orders'));
     var decodedProducts = json.decode(response.body).cast<Map<String, dynamic>>();
     List<Product> productList = await decodedProducts
         .map<Product>((json) => Product.fromJson(json))
         .toList();
     return productList;
   }*/

  Future<List<PVModel>> generatePVModelList() async {
    NetworkResponse response = await NetworkCaller.getRequest('https://scubetech.xyz/kazi-habibpur/inverter-live/Inverter02/');

    try {
      if (response.isSuccess) {

        if (response.body is Map<String, dynamic>) {
          PVModel pvModel = PVModel.fromJson(response.body);
          return [pvModel];
        } else if (response.body is List<dynamic>) {
          List<dynamic> decodedProducts = response.body;
          List<PVModel> productList = decodedProducts.map<PVModel>((json) => PVModel.fromJson(json)).toList();
          return productList;
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