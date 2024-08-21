import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/home/data/repositories/podcast_repo.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(AudioState());

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //initialy not playing
  bool _isPlaying = false;
  // is the podcast completed
  bool _isCompleted = false;
  // is the podcast one of my favorites
  bool _isFavorite = false;
  // the number of the favorites
  int _FavoriteNum = 0;

  bool _reported = false;

  // listen to duration
  void listenToDuratin() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      emit(AudioState(
          isPlaying: true, isFinished: false, totalDuration: _totalDuration));
    });
    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      emit(AudioState(
          isPlaying: true,
          isFinished: false,
          currentDuration: _currentDuration));
    });
    //listen for podcast completion
    _audioPlayer.onPlayerComplete.listen((event) {
      _isCompleted = true;
      print("Finished");
      emit(AudioState(isPlaying: false, isFinished: _isCompleted));
    });
  }

  //play the podcast in the assets only
  void playAsset(String podcastPath) async {
    final String path = podcastPath;
    await _audioPlayer.stop(); // stop current podcast
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    _isCompleted = false;
    emit(AudioState(isPlaying: _isPlaying, isFinished: _isCompleted));
  }

  // play the podcast from the files
  void playFile(String podcastPath) async {
    final String path = podcastPath;
    await _audioPlayer.stop(); // stop current podcast
    await _audioPlayer.play(DeviceFileSource(path));
    _isPlaying = true;
    _isCompleted = false;
    emit(AudioState(isPlaying: _isPlaying, isFinished: _isCompleted));
  }

  // play the podcast from the network
  void playNetWork(String podcastPath) async {
    final String path = podcastPath;
    await _audioPlayer.stop(); // stop current podcast
    await _audioPlayer.play(UrlSource(path));
    _isPlaying = true;
    _isCompleted = false;
    emit(AudioState(
      isPlaying: _isPlaying,
    ));
  }

  //pause current podcast
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    emit(AudioState(isPlaying: _isPlaying));
  }

  //resume palying
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    emit(AudioState(isPlaying: _isPlaying));
  }

  //pause or resume
  void pauseOrResuem() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    emit(AudioState(isPlaying: _isPlaying));
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // 10 seconds forwards
  void tenSecForward() async {
    await _audioPlayer.seek(_currentDuration + const Duration(seconds: 10));
  }

  // 10 seconds backword
  void tenSecBackword() async {
    await _audioPlayer.seek(_currentDuration - const Duration(seconds: 10));
  }

  //check if this podcast is one of my favorites
  Future<void> checkFavorite(int id) async {
    final String? token = await ServiceFunctions.getUserToken();
    if (token != null) {
      final result = await PodcastRepo().checkFavorite(token, id);
      result.fold((left) {
        _isFavorite = _isFavorite;
      }, (right) {
        print(right);
        if (right.contains(id)) {
          _isFavorite = true;
        } else {
          _isFavorite = false;
        }
      });
      emit(AudioState(isFavorite: _isFavorite));
    }
  }

  //get the new number of the podcast favorite
  Future<void> getFavoriteNum(int id) async {
    final String? token = await ServiceFunctions.getUserToken();
    if (token != null) {
      final result = await PodcastRepo().showPodcast(id, token);
      result.fold((left) {}, (right) {
        print(right);
        _FavoriteNum = right.data!.podcastFavourites!;
      });
      emit(AudioState(favoriteNum: _FavoriteNum));
    }
  }

  //toggle favorite
  Future<void> toggleFavorite(int id) async {
    final String? token = await ServiceFunctions.getUserToken();
    if (token != null) {
      final result = await PodcastRepo().toggleFavorite(token, id);
      result.fold((left) {
        _isFavorite = _isFavorite;
      }, (right) {
        print(right.msg);
        if (right.msg == "Podcast Added To Favourite Successfully") {
          _isFavorite = true;
        } else {
          _isFavorite = false;
        }
      });
      emit(AudioState(isFavorite: _isFavorite));
    }
  }

  // add the podcast to the listen history
  Future<void> addPodcastToListen(int podcastId, String duration) async {
    final String? token = await ServiceFunctions.getUserToken();
    if (token != null) {
      final result =
          await PodcastRepo().addPodcastToListen(token, podcastId, duration);
      result.fold((l) => print("Added"), (r) => print("Not added"));
    }
  }

  Future<void> reportPodcast(int podcastId) async {
    final String? token = await ServiceFunctions.getUserToken();
    if (token != null) {
      BotToast.showLoading();
      final result = await PodcastRepo().reportPodcast(token, podcastId);
      result.fold((l) {
        BotToast.closeAllLoading();
        _reported = false;
      }, (r) {
        BotToast.closeAllLoading();
        _reported = true;
      });
    }
    emit(AudioState(reported: _reported));
  }

  /* G E T T E R S */
  bool get isPlaying => _isPlaying;
  bool get isCompleted => _isCompleted;
  bool get isFavorite => _isFavorite;
  Duration get currnetDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /* S E T T E R S */
  set currentDuration(Duration duration) => _currentDuration = duration;
}
