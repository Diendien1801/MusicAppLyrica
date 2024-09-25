import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';
// ignore: depend_on_referenced_packages
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/common/widgets/popup_music/popup_music.dart';
import 'package:lyrica_ver2/common/widgets/special/avatar.dart';
import 'package:lyrica_ver2/data/models/playlist_model.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/data/services/firebase_api.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/screens/recent_listen_screen.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';
import 'package:lyrica_ver2/utils/constants/sizes.dart';

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
                          borderRadius: BorderRadius.circular(30),
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
                              borderRadius: BorderRadius.circular(30),
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
                                            .myPlaylist[index - 1].name,
                                      ));
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
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: playlistController
                                              .playlist[index - 1].coverImage,
                                          placeholder: (context, url) =>
                                              ShimmerEffect(
                                                  height: 400, width: 400),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
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
                                        playlistController.playlist[index].name,
                                  ));
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
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: playlistController
                                          .playlist[index].coverImage,
                                      placeholder: (context, url) =>
                                          ShimmerEffect(
                                              height: 400, width: 400),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
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
        title: const Text('Create a playlist'),
        content: Container(
          height: 360,
          width: TSizes.screenWidth,
          child: Column(
            children: [
              Obx(
                () => InkWell(
                  onTap: () async {
                    // Request storage permissions
                    if (await Permission.storage.request().isGranted) {
                      try {
                        final result = await FilePicker.platform.pickFiles();
                        if (result == null) return;
                        final path = result.files.single.path;
                        if (path != null) {
                          final file = File(path);
                          playlistController.playlistImage.value = file;
                        } else {
                          print('Failed to retrieve path.');
                        }
                      } catch (e) {
                        print('Error picking file: $e');
                      }
                    } else {
                      print('Storage permission denied.');
                    }
                  },
                  child: playlistController.playlistImage.value.path.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(106, 53, 219, 1),
                                Color.fromRGBO(195, 71, 216, 1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 0, top: 80),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/icons/uploadImage.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 70, top: 20),
                                height: 90,
                                width: 300,
                                child: Text(
                                  'Upload cover image ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .apply(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 250,
                          width: TSizes.screenWidth,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 100,
                                left: 135,
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(106, 53, 219, 1),
                                        Color.fromRGBO(195, 71, 216, 1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 200, top: 160),
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/icons/uploadImage.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: FileImage(
                                        playlistController.playlistImage.value),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(106, 53, 219, 1),
                        Color.fromRGBO(195, 71, 216, 1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.all(
                      2), // Space between border and TextField
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color of the TextField
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: playlistController.nameController,
                      decoration: const InputDecoration(
                        hintText: "Playlist name",
                        border: InputBorder.none, // Remove default border
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              FullScreenLoader.openLoadingDialog('Loading...',
                  'assets/animations/141594-animation-of-docer.json');
              final file = playlistController.playlistImage.value;
              final fileName = file.path.split('/').last;
              final destination = 'images/$fileName';
              final task = FirebaseApi.uploadFile(destination, file);
              final snapshot = await task?.whenComplete(() {});
              final urlDownload = await snapshot?.ref.getDownloadURL();

              String name = playlistController.nameController.text;
              if (name == '') {
                showAboutDialog(
                    context: context,
                    children: [const Text('Please enter your playlist name')]);
              } else {
                final playlist = PlaylistModel(
                  stt: '${playlistController.playlist.length}',
                  name: name,
                  songs: [],
                  id: AuthenticationRepository.instance.AuthUser!.uid,
                  coverImage: urlDownload!,
                );

                playlistController.addPlaylist(playlist);
                // Handle the name input here
                //Get.to(() => RecentListenScreen(playlistName: name));
                await PlaylistController.to.fetchPlaylists();
                await PlaylistController.to.fetchMyPlaylists(
                    AuthenticationRepository.instance.AuthUser!.uid);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                FullScreenLoader.stopLoading();
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
