import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';

class THelperFunctions {
  static void addToPlaylist(BuildContext context, SongModel song) {
    showDialog(
      barrierColor: const Color.fromRGBO(15, 5, 26, 0.75),
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(15, 5, 26, 0.75),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              // Cancel button
              child: Container(
                height: 50,
                width: 110,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(106, 53, 219, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
          ],
          content: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(23, 14, 31, 1),
              border: Border.all(
                  width: 1.5, color: const Color.fromRGBO(106, 53, 219, 1)),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 120,
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        height: 24,
                        width: 24,
                        child: const Image(
                            image: AssetImage('assets/icons/heart.png'),
                            color: Colors.white),
                      ),
                      InkWell(
                        onTap: () async {
                          UserController.to.favoriteSongs.add(song);
                          Map<String, dynamic> fav = {
                            'id': 'favorites_id', // Replace with actual ID
                            'name': 'Favorites',
                            'stt': 'favorites_stt', // Replace with actual STT
                            'songs': UserController.to.favoriteSongs
                                .map((song) => song.toJson())
                                .toList(),
                          };
                          await UserController.to.updateUserField(
                              AuthenticationRepository.instance.AuthUser!.uid,
                              'playlist',
                              fav);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          Get.snackbar('Successfully added to favorites',
                              'Check your favorites now!');
                        },
                        child: Text(
                          'Add to favorites',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // DIALOG PLAYLIST
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(23, 14, 31, 1),
                              border: Border.all(
                                  width: 1.5,
                                  color: const Color.fromRGBO(106, 53, 219, 1)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 300,
                            width: double.maxFinite,
                            child: ListView.builder(
                              itemCount: PlaylistController.to.myPlaylist.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    PlaylistController.to.myPlaylist[index].songs
                                        .add(song);

                                    PlaylistController.to.updatePlaylist(
                                        PlaylistController
                                            .to.playlist[index].stt,
                                        song);

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Get.snackbar(
                                        'Successfully added ${PlaylistController.to.myPlaylist[index].name} ',
                                        'Check your playlist now!');
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1.5,
                                            color: const Color.fromRGBO(
                                                106, 53, 219, 1))),
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 20,
                                        right: 20,
                                        bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(PlaylistController
                                            .to.myPlaylist[index].name),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          backgroundColor: const Color.fromRGBO(23, 14, 31, 1),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(106, 53, 219, 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        height: 24,
                        width: 24,
                        child: const Image(
                            image: AssetImage('assets/icons/add.png'),
                            color: Colors.white),
                      ),
                      Text(
                        'Add to a playlist',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
