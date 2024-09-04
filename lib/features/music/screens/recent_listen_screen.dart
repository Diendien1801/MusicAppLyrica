import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/common/widgets/popup_music/popup_music.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_horizontal.dart';
import 'package:lyrica_ver2/common/widgets/special/avatar.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';

import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/music/screens/navigation_menu.dart';
import 'package:lyrica_ver2/features/music/screens/track_view_screen.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';

class RecentListenScreen extends StatelessWidget {
  String? playlistName;
  RecentListenScreen({this.playlistName});
  Future<void> _updatePlaylistAndTrackView() async {
    final trackViewController = TrackViewController.to;
    final playListController = Get.put(PlaylistController());
    await playListController.fetchPlaylists();
    var stt = playListController.playlist
        .lastWhere((playlist) => playlist.name == playlistName)
        .stt;
    final userController = Get.put(UserController());
    playListController.creator.value = userController.user.value.username;
    await playListController.fetchPlaylistWithID(stt);

    trackViewController
        .updateSongList(playListController.playlistWithID.value.songs);

    // playlist rong
    if (trackViewController.currentSongList.isEmpty) {
      trackViewController.setIndex(0);
      trackViewController.stop();
      trackViewController.playButton.value = false;
    } else {
      trackViewController.setIndex(trackViewController.currentSongList
          .indexWhere((element) =>
              element.songName ==
              playListController.playlistWithID.value.songs[0].songName));
      trackViewController.stop();
      trackViewController.playButton.value = false;
    }
    if (trackViewController.currentSongList.length == 1) {
      trackViewController.popUp.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: _updatePlaylistAndTrackView(),
              builder: (context, snapshot) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                //Background
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
                                      image:
                                          AssetImage('assets/background.png'),
                                      fit: BoxFit.fitWidth,
                                      opacity: 0.65,
                                      alignment: Alignment(0.4, -0.35),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 50, left: 30),
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
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 50, left: 130),
                                        child: Avatar(
                                            height: 50,
                                            width: 50,
                                            img:
                                                'assets/images/avatars/avt5.png'),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 170,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height -
                                        150,
                                    width:
                                        MediaQuery.of(context).size.width + 2,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 16),
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
                                                  () => Container(
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
                                                                  .to
                                                                  .creator
                                                                  .value,
                                                              style: Theme.of(
                                                                      context)
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
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            16),
                                                                height: 24,
                                                                width: 24,
                                                                child:
                                                                    const Image(
                                                                  image: AssetImage(
                                                                      'assets/icons/shuffle.png'),
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          137,
                                                                          149,
                                                                          170,
                                                                          1),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            16),
                                                                height: 24,
                                                                width: 24,
                                                                child:
                                                                    const Image(
                                                                  image: AssetImage(
                                                                      'assets/icons/add.png'),
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          137,
                                                                          149,
                                                                          170,
                                                                          1),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 24,
                                                                width: 24,
                                                                child:
                                                                    const Image(
                                                                  image: AssetImage(
                                                                      'assets/icons/more.png'),
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          137,
                                                                          149,
                                                                          170,
                                                                          1),
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
                                                        TrackViewController
                                                                    .to
                                                                    .currentSongList
                                                                    .length !=
                                                                1
                                                            ? Positioned(
                                                                right: 50,
                                                                top: 14,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    TrackViewController
                                                                        .to
                                                                        .setIndex(
                                                                            0);

                                                                    if (TrackViewController
                                                                            .to
                                                                            .indexSong
                                                                            .value !=
                                                                        TrackViewController
                                                                            .to
                                                                            .preIndexSong
                                                                            .value) {
                                                                      if (TrackViewController
                                                                              .to
                                                                              .player
                                                                              .state ==
                                                                          PlayerState
                                                                              .playing) {
                                                                        TrackViewController
                                                                            .to
                                                                            .player
                                                                            .stop();
                                                                        TrackViewController
                                                                            .to
                                                                            .playButton
                                                                            .value = false;
                                                                      }
                                                                      TrackViewController
                                                                          .to
                                                                          .inItPlayer();
                                                                    }

                                                                    Get.to(() =>
                                                                        TrackViewScreen());
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 50,
                                                                    width: 50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                          195,
                                                                          71,
                                                                          216,
                                                                          1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                    child: Icon(
                                                                        Icons
                                                                            .play_arrow_rounded,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            40),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 600,
                                                  width: double.infinity,
                                                  child: ListView.builder(
                                                    itemCount:
                                                        PlaylistController
                                                            .to
                                                            .playlistWithID
                                                            .value
                                                            .songs
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
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 10, top: 6),
                                                        child: PlaylistController
                                                                    .to
                                                                    .playlistWithID
                                                                    .value
                                                                    .songs[
                                                                        index]
                                                                    .coverImage !=
                                                                ''
                                                            ? SongCoverHorizontal(
                                                                song: PlaylistController
                                                                    .to
                                                                    .playlistWithID
                                                                    .value
                                                                    .songs[index],
                                                              )
                                                            : Container(),
                                                      ),
                                                    ),
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
                                Positioned(
                                  top: 20,
                                  left: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      TrackViewController.to
                                          .updateCurrentSongName(
                                              TrackViewController
                                                  .to
                                                  .currentSongList[
                                                      TrackViewController
                                                          .to.indexSong.value]
                                                  .songName);

                                      Get.offAll(() => NavigationMenu(
                                            initialIndex: 2,
                                          ));
                                    },
                                    icon: Icon(
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
                );
              })),
    );
  }
}
