import 'package:get/get.dart';
import 'package:load_json_data_to_grid/controller/inv_2_controller/inv_2_data_controller.dart';

class StateHoldersBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(Inv2DataController());

  }

}