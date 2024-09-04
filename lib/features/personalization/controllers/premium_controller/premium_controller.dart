import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PremiumController extends GetxController {
  static PremiumController get instance => Get.find();
  RxBool isPicked1 = true.obs;
  RxBool isPicked2 = false.obs;
  RxBool isPicked3 = false.obs;
  void pick1() {
    isPicked1.value = true;
    isPicked2.value = false;
    isPicked3.value = false;
  }
  void pick2() {
    isPicked1.value = false;
    isPicked2.value = true;
    isPicked3.value = false;
  }
  void pick3() {
    isPicked1.value = false;
    isPicked2.value = false;
    isPicked3.value = true;
  }
}