import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/utils/constants/sizes.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';

class TrackViewScreen extends StatelessWidget {
  const TrackViewScreen({super.key});

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

// ignore: must_be_immutable
class TrackView extends StatelessWidget {
  bool lyricsDisplay;
  final trackViewController = TrackViewController.to;
  
  TrackView({super.key, required this.lyricsDisplay});

  @override
  Widget build(BuildContext context) {
    if (lyricsDisplay) {
      return Center(
        child: Text(
          'No Lyrics Available',
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: Colors.white,
              ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Obx(
              () => Container(
                height: TSizes.screenHeight,
                width: TSizes.screenWidth,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: trackViewController
                          .currentSongListPlay[trackViewController.indexSong.value]
                          .coverImage,
                      placeholder: (context, url) =>
                          ShimmerEffect(height: 340, width: 340),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.darken),
                          ),
                        ),
                        child: Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(
                                    0.2), // Transparent container to apply the blur
                              ),
                            ),
                            // Other child widgets can go here
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: TSizes.screenHeight,
                      child: CachedNetworkImage(
                        imageUrl: trackViewController
                            .currentSongListPlay[
                                trackViewController.indexSong.value]
                            .coverImage,
                        placeholder: (context, url) =>
                            ShimmerEffect(height: 340, width: 340),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => Container(
                          height: TSizes.screenHeight / 2,
                          width: TSizes.screenWidth,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              opacity: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  //header
                  Container(
                    width: 400,
                    height: 40,
                    margin: const EdgeInsets.only(top: 48, left: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            trackViewController.setPreIndex(
                                trackViewController.indexSong.value);
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
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              trackViewController
                                  .currentSongListPlay[
                                      trackViewController.indexSong.value]
                                  .songName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        // add

                        Container(
                          margin: const EdgeInsets.only(top: 16),
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
                      margin: const EdgeInsets.only(top: 60),
                      height: 340,
                      width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: trackViewController
                              .currentSongListPlay[
                                  trackViewController.indexSong.value]
                              .coverImage,
                          placeholder: (context, url) =>
                              ShimmerEffect(height: 340, width: 340),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                      margin: const EdgeInsets.only(top: 55),
                      child: Text(
                        trackViewController
                            .currentSongListPlay[
                                trackViewController.indexSong.value]
                            .songName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // Artist
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        trackViewController
                            .currentSongListPlay[
                                trackViewController.indexSong.value]
                            .artist,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: const Color.fromRGBO(182, 182, 182, 1),
                            ),
                      ),
                    ),
                  ),
                  // Slider song
                  //
                  //
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Slider(
                        min: 0,
                        max: trackViewController.duration.value.inSeconds
                            .toDouble(),
                        value: trackViewController.position.value.inSeconds
                            .toDouble(),

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
                      margin: const EdgeInsets.only(left: 30, right: 30),
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
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        // Repeat
                        Obx(
                          () => InkWell(
                            onTap: () {
                              trackViewController.isRe();
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(right: 40, left: 36),
                              child: trackViewController.isRepeat.value
                                  ? Image.asset(
                                      'assets/icons/repeat.png',
                                      color:
                                          const Color.fromRGBO(218, 0, 255, 1),
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
                          child: Image.asset(
                            'assets/icons/control.png',
                            color: Colors.white,
                            width: 30,
                          ),
                        ),

                        // play button
                        Obx(
                          () => InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              trackViewController.controll(trackViewController
                                  .currentSongListPlay[
                                      trackViewController.indexSong.value]
                                  .url);
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.only(left: 40, right: 40),
                                child: trackViewController.playButton.value
                                    ? Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromRGBO(195, 71, 216, 1),
                                              Color.fromRGBO(106, 53, 219, 1),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                          size: 45,
                                        ),
                                      )
                                    : Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromRGBO(195, 71, 216, 1),
                                              Color.fromRGBO(106, 53, 219, 1),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 45,
                                        ),
                                      )),
                          ),
                        ),

                        // next
                        InkWell(
                          onTap: () {
                            trackViewController.next();
                          },
                          child: Transform.rotate(
                            angle: 180 * 3.14 / 180,
                            child: Image.asset(
                              'assets/icons/control.png',
                              color: Colors.white,
                              width: 30,
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
                              margin: const EdgeInsets.only(left: 40),
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
                    margin: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Swipe for lyrics >>',
                      style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: const Color.fromRGBO(182, 182, 182, 1),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
