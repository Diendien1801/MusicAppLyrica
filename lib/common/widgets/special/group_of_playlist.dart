import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lyrica_ver2/common/widgets/playlist_card/playlist_card.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/screens/recent_listen_screen.dart';

class GroupOfPlayList extends StatelessWidget {
  int itemStart;
  GroupOfPlayList({required this.itemStart});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440,
      margin: const EdgeInsets.only(left: 11),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                Get.to(() => RecentListenScreen(
                      playlistName:
                          PlaylistController.to.playlist[itemStart].name,
                    ));
              },
              child: PlaylistCard(
                height: 300,
                width: 180,
                image: 'assets/images/playlists/play${itemStart + 1}.png',
                name: PlaylistController.to.playlist[itemStart].name,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 190,
            child: InkWell(
              onTap: () {
                Get.to(() => RecentListenScreen(
                      playlistName:
                          PlaylistController.to.playlist[itemStart + 1].name,
                    ));
              },
              child: PlaylistCard(
                height: 120,
                width: 180,
                image: 'assets/images/playlists/play${itemStart + 2}.png',
                name: PlaylistController.to.playlist[itemStart + 1].name,
              ),
            ),
          ),
          Positioned(
            top: 310,
            left: 0,
            child: InkWell(
              onTap: () {
                Get.to(() => RecentListenScreen(
                      playlistName:
                          PlaylistController.to.playlist[itemStart + 2].name,
                    ));
              },
              child: PlaylistCard(
                height: 120,
                width: 180,
                image: 'assets/images/playlists/play${itemStart + 3}.png',
                name: PlaylistController.to.playlist[itemStart + 2].name,
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 190,
            child: InkWell(
              onTap: () {
                Get.to(() => RecentListenScreen(
                      playlistName:
                          PlaylistController.to.playlist[itemStart + 3].name,
                    ));
              },
              child: PlaylistCard(
                height: 300,
                width: 180,
                image: 'assets/images/playlists/play${itemStart + 4}.png',
                name: PlaylistController.to.playlist[itemStart + 3].name,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
