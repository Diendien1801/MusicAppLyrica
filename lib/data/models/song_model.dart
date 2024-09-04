import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  String artist;
  String genre;
  String userId;
  String songName;
  String url;
  String user;
  String coverImage;
  bool isChecked;

  SongModel({
    required this.artist,
    required this.genre,
    required this.userId,
    required this.songName,
    required this.url,
    required this.user,
    required this.coverImage,
    required this.isChecked,
  });

  Map<String, dynamic> toJson() => {
        'artist': artist,
        'genre': genre,
        'id': userId,
        'songName': songName,
        'url': url,
        'user': user,
        'coverImage': coverImage,
        'isChecked': isChecked,
      };

  factory SongModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return SongModel(
      artist: data['artist'] ?? '',
      genre: data['genre'] ?? '',
      userId: data['id'] ?? '',
      songName: data['songName'] ?? '',
      url: data['url'] ?? '',
      user: data['user'] ?? '',
      coverImage: data['coverImage'] ?? '',
      isChecked: data['isChecked'] ?? false,
    );
  }

  static SongModel empty() => SongModel(
        isChecked: false,
        artist: '',
        genre: '',
        userId: '',
        songName: '',
        url: '',
        user: '',
        coverImage: '',
      );

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      artist: json['artist'] ?? '',
      genre: json['genre'] ?? '',
      userId: json['id'] ?? '',
      songName: json['songName'] ?? '' ?? json['name'] ?? '',
      url: json['url'] ?? '',
      user: json['user'] ?? '',
      coverImage: json['coverImage'] ?? '',
      isChecked: json['isChecked'] ?? false,
    );
  }
  factory SongModel.fromSnapshot2(Map<String, dynamic> data) {
    return SongModel(
      songName: data['songName'],
      artist: data['artist'],
      coverImage: data['coverImage'],
      genre: data['genre'],
      isChecked: data['isChecked'],
      user: data['user'],
      url: data['url'],
      userId: data['id'],
    );
  }
}
