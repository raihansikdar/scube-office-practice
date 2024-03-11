import 'package:get/get.dart';
import 'package:load_json_data_to_grid/controller/product_data_controller.dart';

class StateHoldersBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(ProductDataController());

  }

}