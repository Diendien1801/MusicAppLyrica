import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AvatarController extends GetxController {
  static AvatarController get instance => Get.find();

  RxString avatar = 'assets/images/avatars/avt1.png'.obs;

  void setAvatar(String value) {
    avatar.value = value;
  }
}
