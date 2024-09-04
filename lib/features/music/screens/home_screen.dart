import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/common/widgets/popup_music/popup_music.dart';
import 'package:lyrica_ver2/common/widgets/slider/slider_top_playlists.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_horizontal.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_vertical.dart';
import 'package:lyrica_ver2/common/widgets/special/avatar.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/repositories/music/music_repository.dart';
import 'package:lyrica_ver2/features/authentication/controllers/avatar/avatar_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/artist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';
import 'package:lyrica_ver2/features/personalization/screens/personal.dart';
import 'package:lyrica_ver2/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final artistController = Get.put(ArtistController());
    final playlistController = Get.put(PlaylistController());

    TrackViewController.to.updateSongList(TrackViewController.to.songList);
    int songIndex = TrackViewController.to.currentSongList.indexWhere(
      (song) => song.songName == TrackViewController.to.currentSongName.value,
    );
    if (songIndex == -1) {
      songIndex = 0;
    }
    TrackViewController.to.setIndex(songIndex);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Container(
                decoration:
                    const BoxDecoration(color: TColors.primaryBackground),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Background
                        Container(
                          height: 390,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Color.fromRGBO(106, 53, 219, 1),
                                Color.fromRGBO(195, 71, 216, 1),
                              ],
                            ),
                            image: DecorationImage(
                                image: AssetImage('assets/background2.png'),
                                fit: BoxFit.none,
                                opacity: 0.80,
                                scale: 1.5,
                                alignment: Alignment(0.0, 0.85)),
                          ),
                        ),

                        // Fade effect
                        Container(
                          height: 390,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                TColors.primaryBackground,
                                Color.fromRGBO(0, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),

                        // Avatar
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50, left: 30),
                              width: 190,
                              child: Text(
                                'TOP PLAYLISTS',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .apply(
                                      letterSpacingDelta: 2,
                                    ),
                              ),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 50, left: 120),
                                child: Avatar(
                                    height: 50,
                                    width: 50,
                                    img: 'assets/images/avatars/avt5.png')),
                          ],
                        ),
                        // SLIDER
                        Container(
                          padding: const EdgeInsets.only(right: 40),
                          margin: const EdgeInsets.only(top: 170),
                          height: 320,
                          width: MediaQuery.of(context).size.width,
                          child: const MySlider(),
                        ),
                      ],
                    ),

                    // TRENDING
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 30, bottom: 10),
                      width: 170,
                      child: Text(
                        'Trending',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    // Trending List
                    Container(
                      height: 185,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.87),
                        itemCount: 5,
                        itemBuilder: (context, index1) => Container(
                          height: 185,
                          // color: Colors.blue,
                          margin: const EdgeInsets.only(top: 0, left: 6),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: 3,
                            itemBuilder: (context, index2) {
                              return Obx(
                                () => Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: SongCoverHorizontal(
                                      song: TrackViewController
                                              .to.currentSongList[
                                          index1 * 3 + index2]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    //Today recommendations
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 30),
                          width: 300,
                          child: Text(
                            'Today recommendations songs',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Container(
                          height: 207,
                          margin: const EdgeInsets.only(top: 0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => SongCoverVertical(
                                    song: TrackViewController
                                        .to.currentSongList[index + 3]),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    // Artists
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20, left: 30),
                            width: 170,
                            child: Text(
                              'Artists you may like',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          // Artists List
                          Obx(
                            () => Container(
                              height: 160,
                              margin: const EdgeInsets.only(top: 0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: artistController.artists.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      // Avatar
                                      InkWell(
                                        onTap: () async {
                                          ArtistController.to
                                              .updateCurrentArtistName(
                                                  ArtistController.to
                                                      .artists[index].username);
                                          AvatarController
                                                  .instance.avatar.value =
                                              'assets/images/artists/art${index + 1}.png';
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PersonalScreen(
                                                  img:
                                                      'assets/images/artists/art1.png',
                                                  isMe: false),
                                            ),
                                          );
                                          await TrackViewController.to
                                              .fetchMySongList(ArtistController
                                                  .to.artists[index].id!);
                                          await PlaylistController.to
                                              .fetchMyPlaylists(ArtistController
                                                  .to.artists[index].id!);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 20, left: 24),
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/artists/art${index + 1}.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Artist Name
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 16),
                                        child: Text(
                                          artistController
                                              .artists[index].username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // More for you
                    Container(
                      height: 280,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 30),
                            width: 170,
                            child: Text(
                              'More for you',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          // Artists List
                          Container(
                            height: 180,
                            margin: const EdgeInsets.only(top: 0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    // Avatar
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 30),
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/artists/art${index + 5 + 1}.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // Artist Name
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 16),
                                      child: Text(
                                        'Favourite Artist',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ],
                                );
                              },
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
          // Popup song
          const Positioned(
            bottom: 10,
            left: 26,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: PopUpMusic(),
            ),
          ),
        ],
      ),
    );
  }
}
