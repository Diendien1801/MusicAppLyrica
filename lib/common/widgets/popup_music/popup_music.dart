import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/music/screens/track_view_screen.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';

class PopUpMusic extends StatelessWidget {
  const PopUpMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TrackViewController.to;
    
    return Obx(
      () => Material(
        child: controller.popUp.value == false
            ? Container()
            : InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackViewScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(106, 53, 219, 1),
                        Color.fromRGBO(195, 71, 216, 1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // avatar
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: controller
                                    .currentSongListPlay[
                                        controller.indexSong.value]
                                    .coverImage,
                                placeholder: (context, url) =>
                                    ShimmerEffect(height: 50, width: 50),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                          // song name and artist name
                          Container(
                            margin: EdgeInsets.only(left: 16, top: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                      .currentSongListPlay[
                                          controller.indexSong.value]
                                      .songName,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  controller
                                      .currentSongListPlay[
                                          controller.indexSong.value]
                                      .artist,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                          // play button
                        ],
                      ),
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(right: 20),
                          child: IconButton(
                            icon: controller.playButton.value == false
                                ? Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : Icon(
                                    Icons.pause_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                            onPressed: () {
                              controller.controll(controller
                                  .songList[controller.indexSong.value].url);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
