import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/music/screens/recent_listen_screen.dart';
import 'package:lyrica_ver2/features/music/screens/track_view_screen.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MySlider extends StatelessWidget {
  const MySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Swiper(
          axisDirection: AxisDirection.right,
          itemCount: 3,
          layout: SwiperLayout.STACK,
          itemWidth: 300,
          itemHeight: 320,
          loop: true,
          duration: 500,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var songName = TrackViewController.to.songList[index + 2].songName;
            return InkWell(
              onTap: () {
                // bấm vào đây sẽ mở trình duyệt web và vào url sau
                final controller = TrackViewController.to;

                var index = controller.currentSongList
                    .indexWhere((s) => s.songName == songName);
                controller.setIndex(index);
                print(index);
                if (controller.indexSong.value !=
                    controller.preIndexSong.value) {
                  if (controller.player.state == PlayerState.playing) {
                    controller.player.stop();
                    controller.playButton.value = false;
                  }
                  controller.inItPlayer();
                }

                Get.to(() => TrackViewScreen());
                //print(controller.songList.indexOf(song));
                TrackViewController.to.currentSongName.value = songName;
              },
              child: Stack(
                children: [
                  Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: TrackViewController
                            .to.songList[index + 2].coverImage,
                        placeholder: (context, url) =>
                            ShimmerEffect(height: 50, width: 50),
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
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      height: 50,
                      width: 250,
                      child: Text(
                        TrackViewController.to.songList[index + 2].songName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20,
                    child: Container(
                      height: 40,
                      width: 200,
                      child: Text(
                        TrackViewController.to.songList[index + 2].artist,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
