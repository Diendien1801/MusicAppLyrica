import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lyrica_ver2/data/models/user_model.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';

class UserRepository extends GetxController {
  // every things related to collection 'User' FireStore
  static UserRepository get to => Get.find<UserRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Fetch USer details base on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.AuthUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        print(UserModel.fromSnapshot(documentSnapshot).username);
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        print('User not found');
        return UserModel.empty();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserField(
      String userId, String fieldName, dynamic newValue) async {
    try {
      await _db.collection('Users').doc(userId).update({fieldName: newValue});
    } catch (e) {
      throw Exception('Error updating user field: $e');
    }
  }
}
