import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/playlist_model.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/repositories/playlists/playlists_repository.dart';


class PlaylistController extends GetxController {
  static PlaylistController get to => Get.find();
  // all playlists
  RxList<PlaylistModel> playlist = <PlaylistModel>[].obs;
  final playlistsRepository = Get.find<PlaylistsRepository>();

  // controll Name of playlist
  TextEditingController nameController = TextEditingController();
  
  Rx<PlaylistModel> playlistWithID = PlaylistModel.empty().obs;
  
  RxList<PlaylistModel> myPlaylist = <PlaylistModel>[].obs;

  Rx<String> creator = ''.obs;
  Rx<File> playlistImage = Rx<File>(File(''));

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

  List<PlaylistModel> mergeSort(List<PlaylistModel> playlists) {
    if (playlists.length <= 1) {
      return playlists;
    }

    final middle = playlists.length ~/ 2;
    final left = playlists.sublist(0, middle);
    final right = playlists.sublist(middle);

    return merge(mergeSort(left), mergeSort(right));
  }

  List<PlaylistModel> merge(
      List<PlaylistModel> left, List<PlaylistModel> right) {
    List<PlaylistModel> result = [];
    int leftIndex = 0;
    int rightIndex = 0;

    while (leftIndex < left.length && rightIndex < right.length) {
      if (int.parse(left[leftIndex].stt) < int.parse(right[rightIndex].stt)) {
        result.add(left[leftIndex]);
        leftIndex++;
      } else {
        result.add(right[rightIndex]);
        rightIndex++;
      }
    }

    result.addAll(left.sublist(leftIndex));
    result.addAll(right.sublist(rightIndex));

    return result;
  }

  Future<void> fetchPlaylists() async {
    try {
      // fetch playlists
      final fetchedPlaylists = await playlistsRepository.fetchPlaylists();
      final sortedPlaylists = mergeSort(fetchedPlaylists);
      playlist.assignAll(sortedPlaylists);
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
      final sortedPlaylists = mergeSort(fetchedPlaylists);

      myPlaylist.assignAll(
          sortedPlaylists.where((playlist) => playlist.id == uid).toList());
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
