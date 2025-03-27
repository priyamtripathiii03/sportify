import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../helper/api_helper.dart';
import '../modal/music_modal.dart';


class MusicProvider extends ChangeNotifier {
  int selectedIndex = 0;

  final audioPlayer = AudioPlayer();
  bool isPlay = false;

  Duration? position = Duration.zero;
  Duration? duration = Duration.zero;
  double speed = 1.0;

  List<Result> favouriteList = [];

  MusicModal? searchList;

  ApiHelper apiHelper = ApiHelper();

  bool isMiniPlayer = false;

  List<Result> miniPlayerResult = [];

  // variables to store different categories songs
  MusicModal? artistData;
  MusicModal? punjabiSongs;
  MusicModal? hindiSongs;
  MusicModal? haryanaSongs;
  MusicModal? topData;

  // current position of the current music
  Duration? positionOfTheSlider() {
    audioPlayer.positionStream.listen(
          (event) {
        position = event;
        notifyListeners();
      },
    );
    return position;
  }

  // current music's duration
  Duration? durationOfTheTimer() {
    audioPlayer.durationStream.listen(
          (event) {
        duration = event;
        notifyListeners();
      },
    );
    return duration;
  }

  void toggleMiniPlayer(){
    isMiniPlayer = !isMiniPlayer;
    notifyListeners();
  }

  // changing the position to seconds
  Future<void> changeToSeconds(int seconds) async {
    Duration duration = Duration(seconds: seconds);
    await audioPlayer.seek(duration);
    notifyListeners();
  }

  // toggling the speed of the music
  Future<void> toggleSpeed(double value) async {
    speed = value;
    await audioPlayer.setSpeed(speed);
    notifyListeners();
  }

  // forwarding song
  Future<void> forwardSong(List<Result> result) async {
    selectedIndex = selectedIndex + 1;
    await audioPlayer.setUrl(result[selectedIndex].downloadUrl.first.url);
    notifyListeners();
  }

  // reversing the song
  Future<void> backSong(List<Result> result) async {
    selectedIndex = selectedIndex - 1;
    await audioPlayer.setUrl(result[selectedIndex].downloadUrl.first.url);
    notifyListeners();
  }

  // toggling the between play and pause
  Future<void> togglePlay() async {
    isPlay = !isPlay;
    if (isPlay) {
      await audioPlayer.play();
    } else {
      await audioPlayer.pause();
    }
    notifyListeners();
  }

  Future<MusicModal?> fetchApiData(String value) async {
    final data = await apiHelper.fetchApi(value);
    artistData = MusicModal.fromMap(data);
    return artistData;
  }

  Future<MusicModal?> fetchPunjabiApiData() async {
    final data = await apiHelper.fetchPunjabiApi("Punjabi");
    punjabiSongs = MusicModal.fromMap(data);
    return punjabiSongs;
  }

  Future<MusicModal?> fetchHaryanaApiData() async {
    final data = await apiHelper.fetchPunjabiApi("Haryanvi");
    haryanaSongs = MusicModal.fromMap(data);
    return haryanaSongs;
  }

  Future<MusicModal?> fetchHindi() async {
    final data = await apiHelper.fetchPunjabiApi("Bollywood");
    hindiSongs = MusicModal.fromMap(data);
    return hindiSongs;
  }

  Future<MusicModal?> fetchTopApiData() async {
    final data = await apiHelper.fetchTopApi("Lofi");
    topData = MusicModal.fromMap(data);
    return topData;
  }

  Future<MusicModal?> fetchSearchApiData(String value) async {
    final data = await apiHelper.fetchSearchApi(value);
    searchList = MusicModal.fromMap(data);
    return searchList;
  }

  String search = 'Jass';

  Future<void> searchData(String value) async {
    search = value;
    await fetchSearchApiData(search);
    notifyListeners();
  }

  void addingFavouriteSongs(List<Result> result, BuildContext context) {
    if (!favouriteList.contains(result[selectedIndex])) {
      favouriteList.add(result[selectedIndex]);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Music Added to My Music'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Music already added'),
        ),
      );
    }
    notifyListeners();
  }

  MusicProvider() {
    positionOfTheSlider();
    durationOfTheTimer();
    fetchApiData('Arijit');
    fetchPunjabiApiData();
    fetchSearchApiData("Jass");
    fetchTopApiData();
  }
}