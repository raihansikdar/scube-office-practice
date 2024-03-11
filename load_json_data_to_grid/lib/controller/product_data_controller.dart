import 'dart:convert';
import 'package:get/get.dart';
import 'package:load_json_data_to_grid/models/product_model.dart';

import 'package:http/http.dart' as http;
import 'package:load_json_data_to_grid/services/network_caller.dart';
import 'package:load_json_data_to_grid/services/network_response.dart';

class ProductDataController extends GetxController{
   bool isLoading = false;
   String errorMessage = '';
   List<Product> productList = [];



   @override
    void onInit(){
    // getGridData();
     generateProductList();
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



   Future<List<Product>>generateProductList() async{

     NetworkResponse response = await NetworkCaller.getRequest('https://ej2services.syncfusion.com/production/web-services/api/Orders');

       var decodedProducts = response.body.cast<Map<String, dynamic>>();
       List<Product> productList = await decodedProducts.map<Product>((json) => Product.fromJson(json)).toList();

       return productList;

   }

}