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


  @override
  void onInit(){
    getInv1Data();
    super.onInit();
  }

  List<PVModel> invList =[];
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

     if(response1.isSuccess && response2.isSuccess && response3.isSuccess){
       PVModel pvModelInv1 = PVModel.fromJson(response1.body ?? {});
       PVModel pvModelInv2 = PVModel.fromJson(response2.body ?? {});
       PVModel pvModelInv3 = PVModel.fromJson(response3.body ?? {});

       invList.add(pvModelInv1);
       invList.add(pvModelInv2);
       invList.add(pvModelInv3);
       isLoading = false;
       update();
     }

    } catch (e) {
      log("Exception: $e");
    }
  }


    }