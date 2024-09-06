import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/playlist_model.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/repositories/playlists/playlists_repository.dart';
import 'package:lyrica_ver2/features/music/controllers/fav_playlist_controller.dart';

class PlaylistController extends GetxController {
  static PlaylistController get to => Get.find();
  RxList<PlaylistModel> playlist = <PlaylistModel>[].obs;
  final playlistsRepository = Get.find<PlaylistsRepository>();
  TextEditingController nameController = TextEditingController();
  Rx<PlaylistModel> playlistWithID = PlaylistModel.empty().obs;
  var favPlaylistController = Get.put(FavPlaylistController());
  RxList<PlaylistModel> myPlaylist = <PlaylistModel>[].obs;

  Rx<String> creator = ''.obs;

  @override
  void onInit() async {
    //await fetchMyPlaylists(AuthenticationRepository.instance.AuthUser!.uid);
    await fetchPlaylists();
    super.onInit();
  }

  // update song
  Future<void> updatePlaylist(String playlistIdDoc, SongModel song) async {
    try {
      await playlistsRepository.updateOneFieldPlaylist(playlistIdDoc, song);
    } on FirebaseException catch (e) {
      Get.snackbar('', e.message!);
      //rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchPlaylistWithID(String id) async {
    try {
      // fetch playlists
      var fetchedPlaylists = await playlistsRepository.fetchPlaylistWithID(id);
      playlistWithID.value = fetchedPlaylists;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchPlaylists() async {
    try {
      // fetch playlists
      final fetchedPlaylists = await playlistsRepository.fetchPlaylists();

      playlist.assignAll(fetchedPlaylists);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchMyPlaylists(String uid) async {
    try {
      // fetch playlists
      final fetchedPlaylists = await playlistsRepository.fetchPlaylists();

      myPlaylist.assignAll(
          fetchedPlaylists.where((playlist) => playlist.id == uid).toList());
      //final favPlaylist = UserController.to.user.value.playlist;
      //myPlaylist.add(favPlaylist);
      //print('playlist: ${UserController.to.user.value.playlist.name}');
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addPlaylist(PlaylistModel playlist) async {
    try {
      // add playlist
      await playlistsRepository.addPlaylist(playlist);
    } catch (e) {
      rethrow;
    }
  }
}
