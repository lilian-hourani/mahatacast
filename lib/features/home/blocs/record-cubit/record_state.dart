part of 'record_cubit.dart';

class RecordState {
  final bool isRecording;
  final Duration currentDuration;
  final File? audioFile;
  RecordState({
    this.isRecording = false,
    this.currentDuration = Duration.zero,
    this.audioFile,
  });

  

  RecordState copyWith({
    bool? isRecording,
    Duration? currentDuration,
    File? audioFile,
  }) {
    return RecordState(
      isRecording: isRecording ?? this.isRecording,
      currentDuration: currentDuration ?? this.currentDuration,
      audioFile: audioFile ?? this.audioFile,
    );
  }
}
