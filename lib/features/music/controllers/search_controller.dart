import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';

class SearchingController extends GetxController {
  static SearchingController get to => Get.find();
  final TextEditingController searchEditController = TextEditingController();
  RxBool showListView = false.obs;
  final dio = Dio();
  RxList<SongModel> searchSongList = <SongModel>[].obs;
  void changeShowListView() {
    showListView.value = !showListView.value;
  }

  void getNames() async {
    searchSongList.clear(); // Clear the list before adding new items
    String query = searchEditController.text.trim();
    String url = 'http://54.151.129.13/v1/song/search?name=$query';
    try {
      var response = await dio.get(url);
      // Debug print to check the response structure
      //print(StringSimilarity.compareTwoStrings('mong yu', 'Mong yu'));

      for (var item in response.data['data']['results']) {
        var song = SongModel.fromJson(item);
        await searchSongById(song.userId);
      }
    } catch (e) {
      throw Exception('Error fetching songs: $e');
    }
  }

  Future<void> searchSongById(String songId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('uploads')
          .doc(songId)
          .get();
      //print(documentSnapshot.data());
      if (documentSnapshot.exists) {
        var song = SongModel.fromSnapshot2(
            documentSnapshot.data() as Map<String, dynamic>);

        bool songExists = searchSongList
            .any((s) => s.songName == song.songName); // giai phap tam thoi
        if (!songExists) {
          searchSongList.add(song);
        } else {
          print('Song already in search list');
        }
      } else {
        print('Song not found');
      }
    } catch (e) {
      print('Error fetching song by ID: $e');
    }
  }
}
