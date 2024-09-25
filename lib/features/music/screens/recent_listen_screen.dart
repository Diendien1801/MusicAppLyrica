import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lyrica_ver2/common/widgets/popup_music/popup_music.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_horizontal.dart';
import 'package:lyrica_ver2/common/widgets/special/avatar.dart';

import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/music/screens/navigation_menu.dart';
import 'package:lyrica_ver2/features/music/screens/track_view_screen.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';
import 'package:lyrica_ver2/utils/constants/sizes.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';

// ignore: must_be_immutable
class RecentListenScreen extends StatelessWidget {
  String? playlistName;

  RecentListenScreen({Key? key, this.playlistName}) : super(key: key);
  Future<void> _updatePlaylistAndTrackView() async {
    final trackViewController = TrackViewController.to;
    final playListController = Get.put(PlaylistController());
    //await playListController.fetchPlaylists();
    // get the index of the playlist
    var stt = int.parse(playListController.playlist
        .lastWhere((playlist) => playlist.name == playlistName)
        .stt);

    final userController = Get.put(UserController());
    playListController.creator.value = userController.user.value.username;

    // update the current song list is the songs of this album
    trackViewController
        // ignore: invalid_use_of_protected_member
        .updateSongList(playListController.playlist.value[stt].songs);

    // avoid the case that currentIndex = PreIndex that current song and pre song not in the same playlist
    trackViewController.setPreIndex(-1);
  }

  @override
  Widget build(BuildContext context) {
    // Schedule the state change after the current frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updatePlaylistAndTrackView();
    });
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: TSizes.screenHeight,
                  width: TSizes.screenWidth,
                  child: Stack(
                    children: [
                      Container(
                        height: 230,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color.fromRGBO(195, 71, 216, 1),
                              Color.fromRGBO(106, 53, 219, 1),
                            ],
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/background.png'),
                            fit: BoxFit.fitWidth,
                            opacity: 0.65,
                            alignment: Alignment(0.4, -0.35),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50, left: 30),
                              width: 170,
                              child: Text(
                                playlistName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .apply(
                                      letterSpacingDelta: 2,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 170,
                        child: SizedBox(
                          height: TSizes.screenHeight - 150,
                          width: TSizes.screenWidth + 2,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 35),
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(32, 18, 57, 1),
                                        Color.fromRGBO(21, 16, 26, 1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  height: 716,
                                  child: Column(
                                    children: [
                                      // playlist header
                                      Obx(
                                        () => SizedBox(
                                          height: 80,
                                          width: double.infinity,
                                          child: Stack(
                                            children: [
                                              // Playlist name
                                              Positioned(
                                                top: 16,
                                                left: 100,
                                                child: Text(
                                                    PlaylistController
                                                        .to.creator.value,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!),
                                              ),
                                              // icon
                                              Positioned(
                                                top: 50,
                                                left: 50,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 16),
                                                      height: 24,
                                                      width: 24,
                                                      child: const Image(
                                                        image: AssetImage(
                                                            'assets/icons/shuffle.png'),
                                                        color: Color.fromRGBO(
                                                            137, 149, 170, 1),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 16),
                                                      height: 24,
                                                      width: 24,
                                                      child: const Image(
                                                        image: AssetImage(
                                                            'assets/icons/add.png'),
                                                        color: Color.fromRGBO(
                                                            137, 149, 170, 1),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/icons/more.png'),
                                                        color: Color.fromRGBO(
                                                            137, 149, 170, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //AVATAR
                                              Positioned(
                                                  top: 10,
                                                  left: 50,
                                                  child: Avatar(
                                                      height: 30,
                                                      width: 30,
                                                      img:
                                                          'assets/images/avatars/avt5.png')),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Obx(
                                        () => SizedBox(
                                          height: 600,
                                          width: double.infinity,
                                          // current song list is not empty -> show the list >< else -> show nothing
                                          child: TrackViewController
                                                  .to
                                                  .currentSongList
                                                  .value
                                                  .isNotEmpty
                                              ? ListView.builder(
                                                  itemCount: TrackViewController
                                                      .to
                                                      .currentSongList
                                                      .value
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5,
                                                            top: 10,
                                                            left: 30,
                                                            right: 10),
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10, top: 6),
                                                      child: TrackViewController
                                                                  .to
                                                                  .currentSongList[
                                                                      index]
                                                                  .coverImage !=
                                                              ''
                                                          ? SongCoverHorizontal(
                                                              song: TrackViewController
                                                                      .to
                                                                      .currentSongList[
                                                                  index],
                                                              isFromPlaylist:
                                                                  true,
                                                            )
                                                          : Container(),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // background
                      // Positioned(
                      //   top: 200,
                      //   child: Container(
                      //     height: 700,
                      //     width: TSizes.screenWidth,
                      //     decoration: const BoxDecoration(
                      //         image: DecorationImage(
                      //       image: AssetImage('assets/backgroundalbum.jpg'),
                      //       fit: BoxFit.cover,
                      //       opacity: 0.7,
                      //     )),
                      //   ),
                      // ),

                      // play button 
                      // if current song list is not empty -> show the play button >< else -> show nothing
                      TrackViewController.to.currentSongListPlay.isNotEmpty
                          ? Positioned(
                              right: 50,
                              top: 200,
                              child: InkWell(
                                onTap: () {
                                  // play the first song in the current song list
                                  TrackViewController.to.setIndex(0);

                                  // update the current song list play to the current song list
                                  TrackViewController.to
                                      .updateCurrentSongListPlay(
                                          TrackViewController
                                              .to.currentSongList);
                                  
                                  // check if the song is not the same as the previous song
                                  if (TrackViewController.to.indexSong.value !=
                                      TrackViewController
                                          .to.preIndexSong.value) 
                                          // check if the player is playing -> stop the player
                                          {
                                    if (TrackViewController.to.player.state ==
                                        PlayerState.playing) {
                                      TrackViewController.to.player.stop();
                                      TrackViewController.to.playButton.value =
                                          false;
                                    }
                                    TrackViewController.to.inItPlayer();
                                  }

                                  Get.to(() => const TrackViewScreen());
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(195, 71, 216, 1),
                                        Color.fromRGBO(106, 53, 219, 1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(Icons.play_arrow_rounded,
                                      color: Colors.white, size: 30),
                                ),
                              ),
                            )
                          : Container(),
                      // back
                      Positioned(
                        top: 20,
                        left: 20,
                        child: IconButton(
                          onPressed: () {
                            if (TrackViewController
                                .to.currentSongList.isNotEmpty) {
                              TrackViewController.to.updateCurrentSongName(
                                  TrackViewController
                                      .to
                                      .currentSongListPlay[TrackViewController
                                          .to.indexSong.value]
                                      .songName);
                            }

                            Get.offAll(() => NavigationMenu(
                                  initialIndex: 2,
                                ));
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Popup song
          const Positioned(
            bottom: 10,
            left: 26,
            child: PopUpMusic(),
          ),
        ],
      ),
    ));
  }
}
