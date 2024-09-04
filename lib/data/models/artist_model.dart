import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistModel {
  String username;
  String id;
  bool isBanned;
  bool isPremium;
  String email;

  ArtistModel({
    required this.username,
    required this.id,
    required this.isBanned,
    required this.isPremium,
    required this.email,
  });

  factory ArtistModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ArtistModel(
      username: data['username'] ?? '',
      id: data['id'] ?? '',
      isBanned: data['isBanned'] ?? false,
      isPremium: data['isPremium'] ?? false,
      email: data['email'] ?? '',
    );
  }

  factory ArtistModel.empty() {
    return ArtistModel(
      username: '',
      id: '',
      isBanned: false,
      isPremium: false,
      email: '',
    );
  }
}
