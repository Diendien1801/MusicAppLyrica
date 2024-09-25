import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/common/widgets/song_cover/song_cover_horizontal.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';

class GroupThreeOfSong extends StatelessWidget {
  final int index;
  GroupThreeOfSong({Key? key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SongCoverHorizontal(
            song: TrackViewController.to.songList[index],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SongCoverHorizontal(
            song: TrackViewController.to.songList[index + 1],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SongCoverHorizontal(
            song: TrackViewController.to.songList[index + 2],
          ),
        ),
      ]),
    );
  }
}
