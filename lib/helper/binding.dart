import 'package:get/get.dart';

import '../view_model/control_view_model.dart';
import '../view_model/product_view_model.dart';
import '../view_model/qr_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    //getx controller ل  extends  بحط الحاجات ال
    // Get.lazyPut(() => HomeViewModel());

    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => QrViewModel());
    Get.lazyPut(() => ProductViewModel());
  }
}
