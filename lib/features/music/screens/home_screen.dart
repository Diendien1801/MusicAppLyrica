import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/common/widgets/popup_music/popup_music.dart';
import 'package:lyrica_ver2/common/widgets/slider/slider_top_playlists.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_vertical.dart';
import 'package:lyrica_ver2/common/widgets/special/avatar.dart';
import 'package:lyrica_ver2/common/widgets/special/group_3_of_song.dart';
import 'package:lyrica_ver2/features/authentication/controllers/avatar/avatar_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/artist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';
import 'package:lyrica_ver2/features/personalization/screens/personal.dart';
import 'package:lyrica_ver2/utils/constants/colors.dart';
import 'package:lyrica_ver2/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final artistController = Get.put(ArtistController());

    // Update current Song List Play
    //TrackViewController.to
    //    .updateCurrentSongListPlay(TrackViewController.to.songList);

    // Update current Song List use to display
    //TrackViewController.to.updateSongList(TrackViewController.to.songList);
    //final currentSongName = TrackViewController.to.currentSongName.value;
    // Set index of current song
    //int songIndex = TrackViewController.to.songList.indexWhere(
    //  (song) => song.songName == currentSongName,
    //);
    //if (songIndex == -1) {
    //  songIndex = 0;
    //}
    // TrackViewController.to.setIndex(songIndex);
    TrackViewController.to.setPreIndex(-1); // -> avoid the case that play the third song in album and then play the third song in the home screen
    final songList = TrackViewController.to.songList;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 29, 14, 45)),
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
                              margin: const EdgeInsets.only(top: 50, left: 120),
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
                        width: TSizes.screenWidth,
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
                  SizedBox(
                    height: 185,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.87),
                      itemCount: 5,
                      itemBuilder: (context, index1) {
                        return RepaintBoundary(
                          child: GroupThreeOfSong(index: index1 * 3),
                        );
                      },
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
                              // currentSongList nay` la` all List
                              () =>
                                  SongCoverVertical(song: songList[index + 3]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // Artists
                  SizedBox(
                    height: 270,
                    width: TSizes.screenWidth,
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
                                        AvatarController.instance.avatar.value =
                                            'assets/images/artists/art${index + 1}.png';

                                        Get.to(
                                          () => PersonalScreen(
                                              img:
                                                  'assets/images/artists/art1.png',
                                              isMe: false),
                                        );
                                        await TrackViewController.to
                                            .fetchMySongList(ArtistController
                                                .to.artists[index].id);
                                        await PlaylistController.to
                                            .fetchMyPlaylists(ArtistController
                                                .to.artists[index].id);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 24),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
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
              child: PopUpMusic(),
            ),
          ),
        ],
      ),
    );
  }
}
