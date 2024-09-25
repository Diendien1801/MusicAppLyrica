import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/song_model.dart';
import 'package:lyrica_ver2/data/repositories/music/music_repository.dart';

class TrackViewController extends GetxController {
  static TrackViewController get to => Get.find();
  final playButton = false.obs;
  RxBool isFav = false.obs;
  RxBool isRepeat = true.obs;
  AudioPlayer player = AudioPlayer();

  var duration = const Duration().obs;
  var position = const Duration().obs;
  var popUp = false.obs;

  // all songs
  RxList<SongModel> songList = <SongModel>[].obs;
  var indexSong = 0.obs;
  final songRepository = Get.find<MusicRepository>();
  var preIndexSong = 0.obs;

  // current song list -> display
  RxList<SongModel> currentSongList = <SongModel>[].obs;
  // current song list -> play
  RxList<SongModel> currentSongListPlay = <SongModel>[].obs;
  RxList<SongModel> mySongList = <SongModel>[].obs;
  Rx<String> currentSongName = ''.obs;

  RxBool isCompleted = false.obs;
  // update current song name
  void updateCurrentSongName(String name) {
    currentSongName.value = name;
  }

  // fetch my song list
  Future<void> fetchMySongList(String uid) async {
    try {
      List<SongModel> songs = await songRepository.fetchSongDetails();
      mySongList.assignAll(songs.where((element) {
        return element.isChecked == true && (element.userId == uid);
      }));
    } catch (e) {
      throw Exception('Error fetching songs: $e');
    }
  }

  void updateSongList(List<SongModel> songList) {
    currentSongList.assignAll(songList);
  }

  setPreIndex(int index) {
    preIndexSong.value = index;
  }

  setIndex(int index) {
    indexSong.value = index;
  }

  @override
  void onInit() async {
    await fetchSongs();

    player.onDurationChanged.listen((event) {
      duration.value = event;
    });
    player.onPositionChanged.listen((event) {
      position.value = event;
    });
    if (player.state == PlayerState.playing) {
      playButton.value = true;
    }
    if (player.state == PlayerState.paused) {
      playButton.value = false;
    }
    if (player.state == PlayerState.stopped) {
      playButton.value = false;
    }

    super.onInit();
  }

  Future<void> fetchSongs() async {
    try {
      List<SongModel> songs = await songRepository.fetchSongDetails();
      songList.assignAll(songs.where((element) => element.isChecked == true));
    } catch (e) {
      throw Exception('Error fetching songs: $e');
    }
  }

  isPopUp() {
    popUp.value = true;
  }

  isFavourite() {
    isFav.value = !isFav.value;
  }

  isRe() {
    isRepeat.value = !isRepeat.value;
    player.setReleaseMode(
        isRepeat.value ? ReleaseMode.loop : ReleaseMode.release);
  }

  controll(String url) {
    isPopUp();
    if (player.state == PlayerState.playing) {
      pause();
      playButton.value = false;
    } else if (player.state == PlayerState.paused) {
      resume();
      playButton.value = true;
    } else if (player.state == PlayerState.stopped) {
      play(url);
      playButton.value = true;
    } else if (player.state == PlayerState.completed) {
      play(url);
      playButton.value = true;
    }
  }

  play(String url) async {
    // set source
    await player.play(UrlSource(url));
    // Listen to player state
    player.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.completed && isRepeat.value == false) {
        next();
      } else if (playerState == PlayerState.completed &&
          isRepeat.value == true) {
        player.seek(Duration.zero);
        player.play(UrlSource(currentSongList[indexSong.value].url));
      }
    });
  }

  stop() async {
    await player.stop();
  }

  pause() async {
    await player.pause();
  }

  seek(Duration value) async {
    await player.seek(Duration(seconds: value.inSeconds));
  }

  resume() async {
    await player.resume();
  }

  void togglePlayButton() {
    playButton.value = !playButton.value;
  }

  void next() {
    if (indexSong.value < currentSongListPlay.length - 1) {
      indexSong.value++;
      player.stop();
      playButton.value = false;
      inItPlayer();
      //playButton.value = true;
    }
  }

  void previous() {
    if (indexSong.value > 0) {
      indexSong.value--;
      player.stop();
      playButton.value = false;
      inItPlayer();
      //playButton.value = true;
    }
  }

  void updateCurrentSongListPlay(List<SongModel> songList) {
    currentSongListPlay.assignAll(songList);
  }

  inItPlayer() {
    // Initialize player 
    player = AudioPlayer();
    
    player.setSource(UrlSource(currentSongListPlay[indexSong.value].url));
    // Listen to player state
    player.onDurationChanged.listen((event) {
      duration.value = event;
    });
    player.onPositionChanged.listen((event) {
      position.value = event;
    });
  }
}
