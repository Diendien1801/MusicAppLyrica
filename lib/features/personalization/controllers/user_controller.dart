import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/models/user_model.dart';
import 'package:lyrica_ver2/data/repositories/user/user_repository.dart';

class UserController extends GetxController {
  static UserController get to => Get.find<UserController>();
  final UserRepository _userRepository = Get.put(UserRepository());

  final Rx<UserModel> user = UserModel.empty().obs;

  RxBool isPremium = false.obs;
  RxList<SongModel> favoriteSongs = <SongModel>[].obs;

  @override
  void onInit() async {
    fetchUserDetails();
    super.onInit();
  }

  // update 1 field of user
  Future<void> updateUserField(
      String userId, String fieldName, dynamic newValue) async {
    try {
      await _userRepository.updateUserField(userId, fieldName, newValue);
      isPremium.value = newValue;
      // Optionally, fetch the updated user details
      await fetchUserDetails();
    } catch (e) {
      //Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      user.value = await _userRepository.fetchUserDetails();
      isPremium.value = user.value.isPremium;
      favoriteSongs.value = user.value.playlist.songs;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _userRepository.saveUserRecord(user);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
