import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';

class PlaylistModel {
  String name;
  List<SongModel> songs;
  String id;
  String stt;

  PlaylistModel({
    required this.name,
    required this.songs,
    required this.id,
    required this.stt,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'songs': songs.map((e) => e.toJson()).toList(),
        'id': id,
        'stt': stt,
      };
  factory PlaylistModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PlaylistModel(
      name: data['name'] ?? '',
      songs: List<SongModel>.from(
          data['songs'].map((e) => SongModel.fromJson(e)).toList()),
      id: data['id'] ?? '',
      stt: data['stt'] ?? '',
    );
  }

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        name: json['name'] ?? '',
        songs: List<SongModel>.from(
            json['songs'].map((e) => SongModel.fromJson(e)).toList()),
        id: json['id'] ?? '',
        stt: json['stt'] ?? '',
      );
  static PlaylistModel empty() => PlaylistModel(
        name: '',
        songs: [],
        id: '',
        stt: '',
      );
}
