import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/artist_model.dart';

class ArtistRepository extends GetxController{
  static ArtistRepository get to => Get.find<ArtistRepository>();
  

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ArtistModel>> fetchArtists() async {
    try {
      final querySnapshot = await _db.collection('Users').get();
      final allDocuments = querySnapshot.docs;
      List<ArtistModel> artists = allDocuments.map((doc) {
        return ArtistModel.fromSnapshot(doc);
      }).toList();
      return artists;
    } catch (e) {
      rethrow;
    }
  }
}