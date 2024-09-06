import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lyrica_ver2/data/models/playlist_model.dart';

class UserModel {
  String id;
  String email;
  String username;
  bool isPremium;
  bool isBanned;
  PlaylistModel playlist;
  UserModel(
      {required this.id,
      required this.email,
      required this.username,
      required this.isPremium,
      required this.isBanned,
      required this.playlist});

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'isPremium': isPremium,
        'isBanned': isBanned,
        'playlist': playlist.toJson()
      };
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        isPremium: data['isPremium'] ?? false,
        isBanned: data['isBanned'] ?? false,
        playlist: PlaylistModel.fromJson(data['playlist']));
  }

  static UserModel empty() => UserModel(
        isPremium: false,
        id: '',
        username: '',
        email: '',
        isBanned: false,
        playlist: PlaylistModel.empty(),
      );
}
