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
  List<PVModel> inv1List = [];
  List<PVModel> inv2List = [];
  List<PVModel> inv3List = [];

  @override
  void onInit(){
    getInv1Data();
    super.onInit();
  }


/*  Future<void> getInv1Data() async {
    isLoading = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(AppUrls.inv1Url);
    log('====================');
    log("length: ${response.body!.length}");
    log('====================');
    isLoading = false;
    try {
      if (response.isSuccess) {

        if (response.body is Map<String, dynamic>) {
          PVModel pvModel = PVModel.fromJson(response.body ?? {});
          inv1List.add(pvModel);
          log('====================');
          log("map length: ${inv1List.length}");
          log('====================');
        } else if (response.body is List<dynamic>) {
          List<dynamic> decodedInv1Data = response.body as List;
          List<PVModel> newList = decodedInv1Data.map<PVModel>((json) => PVModel.fromJson(json)).toList();
          inv1List.addAll(newList); // Append to the existing list
          log('====================');
          log("dynamic length: ${inv1List.length}");
          log('====================');
        } else {
          log("Unknown response body type");
        }
        update();
      } else {
        log("Error: ${response.statusCode}");
        update();
      }
    } catch (e) {
      log("Exception: $e");
    }
  }*/
  // Future<void> getInv1Data() async {
  //   isLoading = true;
  //   update();
  //   NetworkResponse response = await NetworkCaller.getRequest(AppUrls.inv1Url);
  //   log('====================');
  //   log("length: ${response.body!.length}");
  //   log('====================');
  //   isLoading = false;
  //
  //
  //   /*if (response.isSuccess) {
  //       if (response.body is Map<String, dynamic>) {
  //         // Handle map response
  //         final List<dynamic> logsread = response.body!['data']['logsread'];
  //         List<PVModel> newList = logsread.map<PVModel>((json) => PVModel.fromJson(json)).toList();
  //         inv1List.addAll(newList);
  //         log('====================');
  //         log("map length: ${inv1List.length}");
  //         log('====================');
  //       } else if (response.body is List<dynamic>) {
  //         // Handle list response
  //         List<dynamic> decodedInv1Data = response.body as List;
  //         List<PVModel> newList = decodedInv1Data.map<PVModel>((json) => PVModel.fromJson(json)).toList();
  //         inv1List.addAll(newList);
  //         log('====================');
  //         log("dynamic length: ${inv1List.length}");
  //         log('====================');
  //       } else {
  //         log("Unknown response body type");
  //       }
  //       update();
  //     } else {
  //       log("Error: ${response.statusCode}");
  //       update();
  //     }*/
  //
  //   if (response.isSuccess) {
  //     if (response.body is Map<String, dynamic>?) {
  //       // Handle map response
  //       Map<String, dynamic>? responseBody = response.body;
  //       if (responseBody != null) {
  //         PVModel pvModel = PVModel.fromJson(responseBody);
  //         inv1List.add(pvModel);
  //         log('====================');
  //         log("map length: ${inv1List.length}");
  //         log('====================');
  //       } else {
  //         log('Error: Response body is null.');
  //       }
  //     } else if (response.body is List<dynamic>) {
  //       // Handle list response
  //       List<dynamic> decodedInv1Data = response.body as List;
  //       List<PVModel> newList = decodedInv1Data.map<PVModel>((json) => PVModel.fromJson(json)).toList();
  //       inv1List.addAll(newList); // Append to the existing list
  //       log('====================');
  //       log("dynamic length: ${inv1List.length}");
  //       log('====================');
  //     } else {
  //       // Handle single object response
  //       log("Unknown response body type");
  //     }
  //     update();
  //   } else {
  //     log("Error: ${response.statusCode}");
  //     update();
  //   }
  //
  // }

  Future<void> getInv1Data() async {
    isLoading = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(AppUrls.inv1Url);
    log('====================');
    log("length: ${response.body!.length}");
    log('====================');
    isLoading = false;

    try {
      if (response.isSuccess) {
        if (response.body is Map<String, dynamic>) {
          // Handle map response
          final List<dynamic> logsread = response.body! as List;
          List<PVModel> newList = logsread.map<PVModel>((json) => PVModel.fromJson(json)).toList();
          inv1List.addAll(newList);
          log('====================');
          log("map length: ${inv1List.length}");
          log('====================');
        } else {
          log("Unknown response body type");
        }
        update();
      } else {
        log("Error: ${response.statusCode}");
        update();
      }
    } catch (e) {
      log("Exception: $e");
    }
  }

    }