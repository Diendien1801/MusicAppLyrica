import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/music/screens/track_view_screen.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';

// ignore: must_be_immutable
class SongCoverVertical extends SongCover {
  SongModel song;
  @override
  void navigateToTrackViewScreen() {
    final controller = TrackViewController.to;
    // click a song in home screen -> update current song list play is all the songs
    controller.updateCurrentSongListPlay(controller.songList);
    controller.setIndex(controller.songList.indexOf(song));
    if (controller.indexSong.value != controller.preIndexSong.value) {
      if (controller.player.state == PlayerState.playing) {
        controller.player.stop();
        controller.playButton.value = false;
      }
      controller.inItPlayer();
    }
    Get.to(() => TrackViewScreen());
    //print(controller.songList.indexOf(song));
  }

  SongCoverVertical({required this.song});
  @override
  Widget build(BuildContext context) {
    // Add a return statement here
    return InkWell(
      onTap: navigateToTrackViewScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            margin: EdgeInsets.only(top: 20, left: 30),
            height: 140,
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: song.coverImage,
                placeholder: (context, url) =>
                    ShimmerEffect(height: 140, width: 220),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
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
          // Artist Name
          Container(
            margin: EdgeInsets.only(left: 34, top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.songName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  song.artist,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
