import 'dart:convert';
import 'dart:developer';

import 'package:flutter_table/pv_model/pv_model.dart';
import 'package:flutter_table/services/network_caller.dart';
import 'package:flutter_table/services/network_response.dart';
import 'package:flutter_table/utility/app_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class PVController extends GetxController{
  bool isLoading = false;
  List<PVModel> invList = [];
  

  @override
  void onInit(){
    getInv1Data();
    super.onInit();
  }

  List<PVModel> myList =[];
  Future<void> getInv1Data() async {
    isLoading = true;
    update();
    NetworkResponse response1 = await NetworkCaller.getRequest(AppUrls.inv1Url);
    NetworkResponse response2 = await NetworkCaller.getRequest(AppUrls.inv2Url);
    NetworkResponse response3 = await NetworkCaller.getRequest(AppUrls.inv3Url);
    log('====================');
    log("length: ${response1.body!.length}");
    log(response1.body.toString());
    log('====================');

    try {

      // Map<String, dynamic> jsonData =response1.body;
      // return jsonData.map((json) => SolarModel.fromJson(json)).toList();


    PVModel pvModelInv1 = PVModel.fromJson(response1.body ?? {});
    PVModel pvModelInv2 = PVModel.fromJson(response2.body ?? {});
    PVModel pvModelInv3 = PVModel.fromJson(response3.body ?? {});

    myList.add(pvModelInv1);
    myList.add(pvModelInv2);
    myList.add(pvModelInv3);

      // List<PVModel> combineList (){
        // List<PVModel> myList =[];


      // return myList;
      //}
      isLoading = false;
      update();

      // if (response1.isSuccess) {
      //
      //   if (response.body is Map<String, dynamic>) {
      //     PVModel pvModelInv1 = PVModel.fromJson(response.body ?? {});
      //     // inv1List.add(pvModel);
      //    /// log("map length: ${inv1List.length}");
      //
      //   } else if (response.body is List<dynamic>) {
      //     List<dynamic> decodedInv1Data = response.body as List;
      //     List<PVModel> newList = decodedInv1Data.map<PVModel>((json) => PVModel.fromJson(json)).toList();
      //     inv1List.addAll(newList); // Append to the existing list
      //     log("dynamic length: ${inv1List.length}");
      //
      //   } else {
      //     log("Unknown response body type");
      //   }
      //   update();
      // } else {
      //   log("Error: ${response.statusCode}");
      //   update();
      // }
    } catch (e) {
      log("Exception: $e");
    }
  }


    }