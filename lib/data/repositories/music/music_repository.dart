import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';

class MusicRepository extends GetxController {
  static MusicRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<SongModel>> fetchSongDetails() async {
    try {
      final querySnapshot = await _db.collection('uploads').get();
      final allDocuments = querySnapshot.docs;
      List<SongModel> songs = allDocuments.map((doc) {
        return SongModel.fromSnapshot(doc);
      }).toList();

      return songs;
    } catch (e) {
      rethrow; 
    }
  }
}
