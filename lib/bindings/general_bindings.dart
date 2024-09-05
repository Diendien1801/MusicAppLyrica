import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:lyrica_ver2/data/repositories/artist/artist_repository.dart';
import 'package:lyrica_ver2/data/repositories/music/music_repository.dart';
import 'package:lyrica_ver2/data/repositories/playlists/playlists_repository.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    //Get.put(UserController());
    Get.put(ArtistRepository());
    
    Get.put(MusicRepository());
    Get.put(TrackViewController());
    Get.put(PlaylistsRepository());
    //Get.put(PlaylistController());
  }
}
