import 'package:flutter_table/controllers/pv_controller.dart';
import 'package:get/get.dart';

class StateHoldersBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(PVController());
  }
}