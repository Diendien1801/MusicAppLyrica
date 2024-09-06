import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/artist_model.dart';
import 'package:lyrica_ver2/data/repositories/artist/artist_repository.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';

class ArtistController extends GetxController {
  static ArtistController get to => Get.find<ArtistController>();
  final artistRepository = Get.put(ArtistRepository());
  RxList<ArtistModel> artists = <ArtistModel>[].obs;
  Rx<String> currentArtistName = ''.obs;
  @override
  void onInit() async {
    await fetchArtists();
    super.onInit();
  }

  void updateCurrentArtistName(String name) {
    currentArtistName.value = name;
  }

  Future<void> fetchArtists() async {
    try {
      // fetch artists
      final fetchedArtists = await artistRepository.fetchArtists();
      artists.value = fetchedArtists
          .where((element) =>
              element.id != AuthenticationRepository.instance.AuthUser?.uid)
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
