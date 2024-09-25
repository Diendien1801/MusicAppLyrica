import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/data/services/firebase_api.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart';

class UpLoadMusicController extends GetxController {
  static UpLoadMusicController get instance => Get.find();

  /// variables
  final songName = TextEditingController();
  final artist = TextEditingController();
  final genre = TextEditingController();
  GlobalKey<FormState> upLoadFormKey = GlobalKey<FormState>();
  Rx<File> image = Rx<File>(File(''));

  /// -- UPLOAD

  // pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
    );
    if (result == null) return;
    final path = result.files.single.path;
    final file = File(path!);
    image.value = file;
    update();
  }

  Future<void> upLoad() async {
    try {
      // //Form validation
      // if (!upLoadFormKey.currentState!.validate()) {
      //   return;
      // }
       FullScreenLoader.openLoadingDialog(
          'Loading...', 'assets/animations/141594-animation-of-docer.json');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'mp3',
          'wav',
          
        ], // Chỉ định các định dạng file âm thanh
      );
      
      if (result == null) return;
     
      final path = result.files.single.path;
      final file = File(path!);
      //up load file to firebase storage
      final fileName = file.path;
      final destination = 'files/$fileName';
      
      final task = FirebaseApi.uploadFile(destination, file);
      final snapshot = await task?.whenComplete(() {});
      final urlDownload = await snapshot?.ref.getDownloadURL();

      final imageUrl = await uploadImage();
      // Update URL in Firestore
      await FirebaseFirestore.instance.collection('uploads').add({
        'user': AuthenticationRepository.instance.AuthUser?.email,
        'fileName': fileName,
        'url': urlDownload,
        'songName': songName.text.trim(),
        'artist': artist.text.trim(),
        'genre': genre.text.trim(),
        'id': AuthenticationRepository.instance.AuthUser?.uid,
        'time': Timestamp.now(),
        'isChecked': false,
        'coverImage': imageUrl
      });

      FullScreenLoader.stopLoading();
      Get.snackbar('Success', 'Upload success');
      songName.text = '';
      artist.text = '';
      genre.text = '';
    } catch (e) {
      //FullScreenLoader.stopLoading();
      Get.snackbar('Error', e.toString());
    }
  }

  // upload image and get url
  Future<String> uploadImage() async {
    if (image.value.path.isEmpty) return '';
    final file = image.value;
    final fileName = file.path.split('/').last;
    final destination = 'images/$fileName';
    final task = FirebaseApi.uploadFile(destination, file);
    final snapshot = await task?.whenComplete(() {});
    final urlDownload = await snapshot?.ref.getDownloadURL();
    return urlDownload ?? '';
  }
}
