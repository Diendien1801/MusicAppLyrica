// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/common/widgets/popup_music/popup_music.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_horizontal.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_vertical.dart';

import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/authentication/controllers/avatar/avatar_controller.dart';
import 'package:lyrica_ver2/features/authentication/screens/choose_avatar_screen.dart';
import 'package:lyrica_ver2/features/music/controllers/artist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';
import 'package:lyrica_ver2/utils/constants/colors.dart';
import 'package:lyrica_ver2/utils/effects/shimmer_effect.dart';

// ignore: must_be_immutable
class PersonalScreen extends StatelessWidget {
  bool isMe;
  String img;
  PersonalScreen({
    super.key,
    required this.isMe,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvatarController());
    final userController = UserController.to;
    print(userController.user.value.username);
    return Material(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      TColors.primaryBackground,
                      Color.fromRGBO(21, 16, 26, 1),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // HEADER
                    Stack(
                      children: [
                        // Background
                        Container(
                          height: 230,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Color.fromRGBO(195, 71, 216, 1),
                                Color.fromRGBO(106, 53, 219, 1),
                              ],
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/background.png'),
                              fit: BoxFit.fitWidth,
                              opacity: 0.65,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50, left: 30),
                              child: IconButton(
                                onPressed: () async {
                                  await PlaylistController.to.fetchMyPlaylists(
                                      AuthenticationRepository
                                          .instance.AuthUser!.uid);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50, left: 230),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.settings),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: IconButton(
                                onPressed: () async {
                                  await AuthenticationRepository.instance
                                      .logout();
                                },
                                icon: const Icon(Icons.logout),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 180, left: 160),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChooseAvatarScreen(
                                            fromEdit: true,
                                          )));
                            },
                            child: Obx(
                              () => Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(150),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(207, 134, 237, 1),
                                    width: 3,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(controller.avatar.value),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // BODY

                    // USER NAME

                    Obx(
                      () => Container(
                        margin: const EdgeInsets.only(top: 20, left: 10),
                        child: Text(
                          ArtistController.to.currentArtistName.value,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),

                    // USER STATUS
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        'This is a very long status that is going to be displayed here',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: const Color.fromRGBO(137, 139, 170, 1)),
                      ),
                    ),
                    // FOLLOWERS AND FOLLOWING
                    Container(
                      margin: const EdgeInsets.only(left: 80),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            child: Text(
                              '1000 Following',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            child: Text(
                              '1000 Followers',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    )

                    // MOST LISTENED

                    ,
                    isMe
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, left: 30),
                                width: 300,
                                child: Text(
                                  'Liked tracks',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              Container(
                                height: 207,
                                margin: const EdgeInsets.only(top: 0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: UserController
                                      .to.user.value.playlist.songs.length,
                                  itemBuilder: (context, index1) {
                                    return SongCoverVertical(
                                        song: UserController.to.user.value
                                            .playlist.songs[index1]);
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 20, right: 180, bottom: 10),
                      width: 170,
                      child: Text(
                        'Hot songs for you',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),

                    // MOST LISTENED LIST
                    SizedBox(
                      height: 185,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.87),
                        itemCount: 3,
                        itemBuilder: (context, index1) => Container(
                          height: 185,
                          // color: Colors.blue,
                          margin: const EdgeInsets.only(top: 0, left: 6),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: 3,
                            itemBuilder: (context, index2) {
                              return Container(
                                margin:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: SongCoverHorizontal(
                                    song: TrackViewController
                                        .to.songList[index1 * 3 + index2]),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // RELEASED
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 30),
                          width: 300,
                          child: Text(
                            'Released',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Obx(
                          () => Container(
                            height: 207,
                            margin: const EdgeInsets.only(top: 0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  TrackViewController.to.mySongList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Avatar
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 30),
                                      height: 140,
                                      width: 140,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: TrackViewController
                                              .to.mySongList[index].coverImage,
                                          placeholder: (context, url) =>
                                              ShimmerEffect(
                                                  height: 140, width: 140),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          imageBuilder:
                                              (context, imageProvider) =>
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
                                    // Artist Name

                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 30, top: 6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            TrackViewController
                                                .to.mySongList[index].songName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          Text(
                                            TrackViewController
                                                .to.mySongList[index].artist,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                        ],
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

                    //PLAYLISTS

                    Obx(
                      () => SizedBox(
                        height: 270,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20, left: 30),
                              width: 170,
                              child: Text(
                                'Playlists',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Container(
                              height: 210,
                              margin: const EdgeInsets.only(top: 0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    PlaylistController.to.myPlaylist.length,
                                itemBuilder: (context, index) {
                                  if (PlaylistController
                                      .to.myPlaylist.isEmpty) {
                                    return const Text('No playlist');
                                  } else {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Avatar
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 28),
                                          height: 140,
                                          width: 140,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.fromBorderSide(
                                              BorderSide(
                                                color: Color.fromRGBO(
                                                    106, 53, 219, 1),
                                              ),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/logo_intro.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        // Artist Name
                                        Container(
                                          height: 40,
                                          width: 140,
                                          margin: const EdgeInsets.only(
                                              top: 10, left: 34),
                                          child: Text(
                                            PlaylistController
                                                .to.myPlaylist[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 22,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const PopUpMusic(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
