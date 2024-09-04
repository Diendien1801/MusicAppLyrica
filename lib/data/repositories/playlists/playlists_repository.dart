import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/playlist_model.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';

class PlaylistsRepository extends GetxController {
  static PlaylistsRepository get to => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // fetch playlists with name
  Future<PlaylistModel> fetchPlaylistWithID(String id) async {
    try {
      final querySnapshot = await _db.collection('playlists').doc(id).get();
      final document = querySnapshot.data();
      PlaylistModel playlist = PlaylistModel(
        name: document!['name'],
        songs: List<SongModel>.from(
            document['songs'].map((e) => SongModel.fromJson(e)).toList()),
        stt: document['stt'],
        id: document['id'],
      );
      return playlist;
    } catch (e) {
      rethrow;
    }
  }

  // fetch playlists
  Future<List<PlaylistModel>> fetchPlaylists() async {
    try {
      final querySnapshot = await _db.collection('playlists').get();
      final allDocuments = querySnapshot.docs;
      List<PlaylistModel> playlists = allDocuments.map((doc) {
        return PlaylistModel.fromSnapshot(doc);
      }).toList();

      return playlists;
    } catch (e) {
      rethrow;
    }
  }

  // add playlist
  Future<void> addPlaylist(PlaylistModel playlist) async {
    try {
      // Generate a unique ID for the document
      String docId = playlist.stt;

      // Set the document with the specified ID
      await _db.collection('playlists').doc(docId).set(playlist.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // update playlist
  Future<void> updateOneFieldPlaylist(String playlistId, SongModel song) async {
    try {
      await _db.collection('playlists').doc(playlistId).update({
        'songs': FieldValue.arrayUnion([song.toJson()])
      });
    } catch (e) {
      rethrow;
    }
  }
}
