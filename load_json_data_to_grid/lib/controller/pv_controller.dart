import 'dart:developer';

import 'package:get/get.dart';
import 'package:load_json_data_to_grid/models/pv_model.dart';
import 'package:load_json_data_to_grid/services/network_caller.dart';
import 'package:load_json_data_to_grid/services/network_response.dart';
import 'package:load_json_data_to_grid/utility/urls.dart';

class PVController extends GetxController {
  bool isLoading = false;
  List<PVModel> invList = [];


  @override
  void onInit() {
    getInv1Data();
    super.onInit();
  }

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
      if (response1.isSuccess && response2.isSuccess && response3.isSuccess) {


        PVModel pvModelInv1 = PVModel.fromJson(response1.body ?? {});
        PVModel pvModelInv2 = PVModel.fromJson(response2.body ?? {});
        PVModel pvModelInv3 = PVModel.fromJson(response3.body ?? {});

        invList.addAll([pvModelInv1, pvModelInv2, pvModelInv3]);

        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      log("Exception: $e");
    }
  }
}