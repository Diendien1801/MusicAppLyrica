// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/authentication/controllers/avatar/avatar_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/artist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';

import 'package:lyrica_ver2/features/personalization/screens/personal.dart';

class Avatar extends StatelessWidget {
  double height;
  double width;
  String img;
  Avatar({
    Key? key,
    required this.height,
    required this.width,
    required this.img,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvatarController());
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonalScreen(
                      img: controller.avatar.value,
                      isMe: true,
                    )));
        await UserController.to.fetchUserDetails();
        ArtistController.to
            .updateCurrentArtistName(UserController.to.user.value.username);
        await TrackViewController.to
            .fetchMySongList(AuthenticationRepository.instance.AuthUser!.uid);
        await PlaylistController.to
            .fetchMyPlaylists(AuthenticationRepository.instance.AuthUser!.uid);
      },
      child: Obx(
        () => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(150),
            border: Border.all(
              color: Color.fromRGBO(207, 134, 237, 1),
              width: 3,
            ),
            image: DecorationImage(
              image: AssetImage(controller.avatar.value),
            ),
          ),
        ),
      ),
    );
  }
}
