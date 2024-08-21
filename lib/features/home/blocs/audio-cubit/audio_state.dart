part of 'audio_cubit.dart';

class AudioState {
  final bool isPlaying;
  final bool isFinished;
  final bool isFavorite;
  final bool reported;
  final int favoriteNum;
  final Duration currentDuration;
  final Duration totalDuration;
  AudioState({
    this.isPlaying = false,
    this.isFinished = false,
    this.isFavorite = false,
    this.reported = false,
    this.favoriteNum = 0,
    this.currentDuration = Duration.zero,
    this.totalDuration = Duration.zero,
  });
}

