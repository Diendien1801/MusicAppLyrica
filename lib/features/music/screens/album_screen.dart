import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/common/widgets/popup_music/popup_music.dart';
import 'package:lyrica_ver2/common/widgets/special/avatar.dart';
import 'package:lyrica_ver2/data/models/playlist_model.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/screens/recent_listen_screen.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playlistController = Get.put(PlaylistController());
    final userController = Get.put(UserController());
    Future<void> fetchMyPlaylist() async {
      await playlistController
          .fetchMyPlaylists(AuthenticationRepository.instance.AuthUser!.uid);
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: 190,
                        child: Text(
                          'Music Library',
                          style:
                              Theme.of(context).textTheme.headlineLarge!.apply(
                                    letterSpacingDelta: 2,
                                  ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50, left: 120),
                        child: Avatar(
                            height: 50,
                            width: 50,
                            img: 'assets/images/avatars/avt5.png'),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 26),
                        height: 50,
                        width: 360,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [
                                Color.fromRGBO(106, 53, 219, 1),
                                Color.fromRGBO(195, 71, 216, 1),
                              ],
                              tileMode: TileMode.mirror,
                            ).createShader(bounds);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(
                                    0.8), // This will be replaced by the gradient
                                width: 2,
                              ),
                            ),
                            child: SearchBar(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (states) => Colors.transparent,
                              ),
                              hintText: 'Search in library',
                              hintStyle:
                                  MaterialStateProperty.resolveWith<TextStyle?>(
                                (states) => const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              padding: MaterialStateProperty.resolveWith<
                                  EdgeInsetsGeometry?>(
                                (states) => const EdgeInsets.only(left: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 42,
                        left: 14,
                        child: Icon(
                          Icons.search,
                          color: Color.fromRGBO(106, 53, 219, 1),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  // Your playlists
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Text(
                      "Your playlists",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: 386,
                      width: 2000,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.4,
                        ),
                        itemCount: playlistController.myPlaylist.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return InkWell(
                              onTap: () {
                                showNameInputDialog(
                                    context, playlistController);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(195, 71, 216, 1),
                                          Color.fromRGBO(106, 53, 219, 1),
                                        ],
                                        tileMode: TileMode.mirror,
                                      ).createShader(bounds);
                                    },
                                    child: Stack(
                                      children: [
                                        const Positioned(
                                          top: 60,
                                          left: 50,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        Positioned(
                                          top: 50,
                                          left: 40,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 3,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 130,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 9),
                                    child: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return const LinearGradient(
                                          colors: [
                                            Color.fromRGBO(195, 71, 216, 1),
                                            Color.fromRGBO(106, 53, 219, 1),
                                          ],
                                          tileMode: TileMode.mirror,
                                        ).createShader(bounds);
                                      },
                                      child: Text(
                                        'New playlist',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Obx(
                              () => InkWell(
                                onTap: () {
                                  Get.to(() => RecentListenScreen(
                                      playlistName: playlistController
                                          .myPlaylist[index - 1].name));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 130,
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              106, 53, 219, 1),
                                          width: 4,
                                        ),
                                        color: Colors.transparent,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/logo_intro.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 9),
                                      child: Text(
                                        playlistController
                                            .myPlaylist[index - 1].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  //Other playlists

                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Text(
                      "Other playlists",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Obx(
                    () => Container(
                      height: 386,
                      width: 2000,
                      margin: const EdgeInsets.only(bottom: 80),
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.4,
                        ),
                        itemCount: playlistController.playlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => RecentListenScreen(
                                  playlistName:
                                      playlistController.playlist[index].name));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 130,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color:
                                          const Color.fromRGBO(106, 53, 219, 1),
                                      width: 4,
                                    ),
                                    image: const DecorationImage(
                                      image:
                                          AssetImage('assets/logo_intro.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 9),
                                  child: Text(
                                    playlistController.playlist[index].name,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 26,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const PopUpMusic(),
            ),
          ),
        ],
      ),
    );
  }
}

void showNameInputDialog(
    BuildContext context, PlaylistController playlistController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter your playlist\'s name'),
        content: TextField(
          controller: playlistController.nameController,
          decoration: const InputDecoration(hintText: "Playlist name"),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Next'),
            onPressed: () async {
              String name = playlistController.nameController.text;
              if (name == '') {
                showAboutDialog(
                    context: context,
                    children: [const Text('Please enter your playlist name')]);
              } else {
                final playlist = PlaylistModel(
                  stt: '${playlistController.playlist.length}',
                  name: name,
                  songs: [SongModel.empty()],
                  id: AuthenticationRepository.instance.AuthUser!.uid,
                );

                playlistController.addPlaylist(playlist);
                // Handle the name input here
                //Get.to(() => RecentListenScreen(playlistName: name));
                await PlaylistController.to.fetchPlaylists();
                await PlaylistController.to.fetchMyPlaylists(
                    AuthenticationRepository.instance.AuthUser!.uid);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                Get.snackbar(
                  'Check now !',
                  'Your playlist has been created',
                );
              }
            },
          ),
        ],
      );
    },
  );
}
