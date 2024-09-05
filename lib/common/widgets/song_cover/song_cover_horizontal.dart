import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/music/screens/track_view_screen.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';
import 'package:lyrica_ver2/utils/helpers/helpers.dart';

// ignore: must_be_immutable
class SongCoverHorizontal extends SongCover {
  SongModel song;

  @override
  void navigateToTrackViewScreen() {
    final controller = TrackViewController.to;
    var songName = song.songName;
    var index =
        controller.currentSongList.indexWhere((s) => s.songName == songName);
    controller.setIndex(index);
    
    if (controller.indexSong.value != controller.preIndexSong.value) {
      if (controller.player.state == PlayerState.playing) {
        controller.player.stop();
        controller.playButton.value = false;
      }
      controller.inItPlayer();
    }

    Get.to(() => TrackViewScreen());
    //print(controller.songList.indexOf(song));
    TrackViewController.to.currentSongName.value = song.songName;
  }

  SongCoverHorizontal({required this.song});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateToTrackViewScreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // avatar
              SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: song.coverImage,
                    placeholder: (context, url) =>
                        ShimmerEffect(height: 50, width: 50),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
              // song name and artist name
              Container(
                margin: const EdgeInsets.only(left: 10, top: 6),
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
          // ...
          // ...
          Container(
            margin: const EdgeInsets.only(left: 0),
            child: IconButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Color.fromRGBO(137, 139, 170, 1),
                size: 20,
              ),
              onPressed: () {
                // SHOW DIALOG
                THelperFunctions.addToPlaylist(context, song);
              },
            ),
          ),
        ],
      ),
    );
  }
}
