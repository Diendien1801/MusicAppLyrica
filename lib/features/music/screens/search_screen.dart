import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/common/widgets/popup_music/popup_music.dart';
import 'package:lyrica_ver2/common/widgets/search/search_bar.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_horizontal.dart';
import 'package:lyrica_ver2/common/widgets/special/group_of_playlist.dart';
import 'package:lyrica_ver2/features/music/controllers/search_controller.dart';
import 'package:lyrica_ver2/utils/constants/colors.dart';

class SearchScreen extends StatelessWidget {
  final searchController = Get.put(SearchingController());

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  TColors.primaryBackground,
                  Colors.black,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Container(
                      child: searchController.showListView.value
                          ? Container(
                              margin: const EdgeInsets.only(left: 24, top: 50),
                            )
                          : Container(
                              margin: const EdgeInsets.only(left: 24, top: 50),
                              width: 200,
                              child: Text(
                                'Explore your music',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .apply(
                                      letterSpacingDelta: 1.5,
                                    ),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: MySearchBar(),
                  ),
                  Obx(
                    () => SizedBox(
                      height: 980,
                      width: MediaQuery.of(context).size.width,
                      child: searchController.showListView.value
                          ? Container(
                              margin: const EdgeInsets.only(left: 20),
                              height: 500,
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: 16, left: 6),
                                    height: 20,
                                    width: 140,
                                    child: Text("Recent search",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                  ),
                                  Obx(
                                    () => Container(
                                      margin: const EdgeInsets.only(top: 0),
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: 400,
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: SongCoverHorizontal(
                                                song: searchController
                                                    .searchSongList[index],
                                              ),
                                            );
                                          },
                                          itemCount: searchController
                                              .searchSongList.length),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(left: 11),
                              height: 980,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GroupOfPlayList(
                                        itemStart: index * 4);
                                  },
                                  itemCount: 2),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Popup song
          const Positioned(
            bottom: 10,
            left: 26,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: PopUpMusic()),
          ),
        ],
      ),
    );
  }
}
