import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/repositories/music/music_repository.dart';
import 'package:lyrica_ver2/features/music/controllers/fav_playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';

class TrackViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return TrackView(
            lyricsDisplay: index == 1,
          );
        },
      ),
    );
  }
}

class TrackView extends StatelessWidget {
  bool lyricsDisplay;
  final trackViewController = TrackViewController.to;
  final favPlaylistController = Get.put(FavPlaylistController());
  TrackView({required this.lyricsDisplay});

  @override
  Widget build(BuildContext context) {
    if (lyricsDisplay) {
      return Container(
        child: Center(
          child: Text(
            'No Lyrics Available',
            style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: Colors.white,
                ),
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(32, 18, 57, 1),
                Color.fromRGBO(21, 16, 26, 1),
                Color.fromRGBO(0, 0, 0, 1),
              ],
            ),
          ),
          child: Column(
            children: [
              //header
              Container(
                width: 400,
                height: 40,
                margin: EdgeInsets.only(top: 48, left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        trackViewController
                            .setPreIndex(trackViewController.indexSong.value);
                        Navigator.pop(context);
                      },
                      child: Transform.rotate(
                        angle: 540 * 3.14 / 360,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    //name

                    Obx(
                      () => Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          trackViewController
                              .currentSongList[
                                  trackViewController.indexSong.value]
                              .songName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    // add

                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Image.asset(
                        'assets/icons/broadcast.png',
                        color: Colors.white,
                        width: 24,
                      ),
                    ),
                  ],
                ),
              ),
              //image
              Obx(
                () => Container(
                  margin: EdgeInsets.only(top: 60),
                  height: 340,
                  width: 340,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: trackViewController
                          .currentSongList[trackViewController.indexSong.value]
                          .coverImage,
                      placeholder: (context, url) =>
                          ShimmerEffect(height: 340, width: 340),
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
              ),

              // Name
              Obx(
                () => Container(
                  margin: EdgeInsets.only(top: 55),
                  child: Text(
                    trackViewController
                        .currentSongList[trackViewController.indexSong.value]
                        .songName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Artist
              Obx(
                () => Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    trackViewController
                        .currentSongList[trackViewController.indexSong.value]
                        .artist,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: Color.fromRGBO(182, 182, 182, 1),
                        ),
                  ),
                ),
              ),
              // Slider song
              //
              //
              Obx(
                () => Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Slider(
                    min: 0,
                    max:
                        trackViewController.duration.value.inSeconds.toDouble(),
                    value:
                        trackViewController.position.value.inSeconds.toDouble(),
                    
                    onChanged: (double value) {
                      final position = Duration(seconds: value.toInt());
                      TrackViewController.to.seek(position);
                      
                    },
                    activeColor: Colors
                        .white, // Change this to your desired active color
                    inactiveColor: Colors
                        .grey, // Change this to your desired inactive color
                  ),
                ),
              ),
              Obx(
                () => Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0${trackViewController.position.value.inSeconds ~/ 60}:${(trackViewController.position.value.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '0${trackViewController.duration.value.inSeconds ~/ 60}:${trackViewController.duration.value.inSeconds % 60}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              // Control

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    // Repeat
                    Obx(
                      () => InkWell(
                        onTap: () {
                          trackViewController.isRe();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 40, left: 36),
                          child: trackViewController.isRepeat.value
                              ? Image.asset(
                                  'assets/icons/repeat.png',
                                  color: Color.fromRGBO(218, 0, 255, 1),
                                  width: 24,
                                )
                              : Image.asset(
                                  'assets/icons/repeat.png',
                                  color: Colors.white,
                                  width: 24,
                                ),
                        ),
                      ),
                    ),

                    // back
                    InkWell(
                      onTap: () {
                        trackViewController.previous();
                      },
                      child: Container(
                        child: Image.asset(
                          'assets/icons/control.png',
                          color: Colors.white,
                          width: 30,
                        ),
                      ),
                    ),

                    // play button
                    Obx(
                      () => InkWell(
                        onTap: () {
                          trackViewController.controll(trackViewController
                              .currentSongList[
                                  trackViewController.indexSong.value]
                              .url);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: trackViewController.playButton.value
                              ? Image.asset(
                                  'assets/icons/stop.png',
                                  color: Colors.white,
                                  width: 70,
                                )
                              : Image.asset(
                                  'assets/icons/play_button.png',
                                  color: Colors.white,
                                  width: 70,
                                ),
                        ),
                      ),
                    ),

                    // next
                    InkWell(
                      onTap: () {
                        trackViewController.next();
                      },
                      child: Container(
                        child: Transform.rotate(
                          angle: 180 * 3.14 / 180,
                          child: Image.asset(
                            'assets/icons/control.png',
                            color: Colors.white,
                            width: 30,
                          ),
                        ),
                      ),
                    ),

                    // heart
                    Obx(
                      () => InkWell(
                        onTap: () {
                          trackViewController.isFavourite();
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 40),
                          child: trackViewController.isFav.value
                              ? Image.asset(
                                  'assets/icons/heart_valid.png',
                                  color: Colors.red,
                                  width: 24,
                                )
                              : Image.asset(
                                  'assets/icons/heart.png',
                                  color: Colors.white,
                                  width: 24,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Swipe
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  'Swipe for lyrics >>',
                  style: Theme.of(context).textTheme.titleLarge!.apply(
                        color: Color.fromRGBO(182, 182, 182, 1),
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
