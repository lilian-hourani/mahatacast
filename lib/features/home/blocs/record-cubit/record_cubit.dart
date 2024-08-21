import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  RecordCubit() : super(RecordState());
  // sound record
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  //duration
  Duration currentDuration = Duration.zero;
  // the file name
  String? fileName;
  // the file path
  String? filePath;
  // final String pathToSaveAudio = '/sdcard/Download/temp.aac';

  Future<void> initRecorder() async {
    // get the permission for access the microphone
    final status = await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
    await startRecording();
    listenToDuratin();
  }

  // listen to duration
  void listenToDuratin() {
    recorder.onProgress?.listen((newDuration) {
      if (state.isRecording) {
        currentDuration = newDuration.duration;
      }
      emit(state.copyWith(currentDuration: currentDuration));
    });
  }

  // first time the recording bugin
  Future<void> startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    // Generate a unique file name using the current timestamp
    fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.mp4';
    filePath = '${directory.path}/$fileName';
    await recorder.startRecorder(toFile: filePath);
    emit(state.copyWith(isRecording: true));
  }

  // pause the recording
  Future<void> pauseRecording() async {
    await recorder.pauseRecorder();
    emit(state.copyWith(isRecording: false));
  }

  //resume the recording
  Future<void> resumeRecording() async {
    await recorder.resumeRecorder();
    emit(state.copyWith(isRecording: true, currentDuration: currentDuration));
  }

  // when i finish the recording
  Future<void> stopRecording() async {
    final path = await recorder.stopRecorder();
    final file = File(path!);
    // int size = File(path!).lengthSync();
    // final audioFile = PlatformFile(name: fileName!, size: size, path: path);
    emit(state.copyWith(isRecording: false, audioFile: file));
  }

  void toggleRecording() async {
    if (state.isRecording) {
      await pauseRecording();
    } else {
      await resumeRecording();
    }
  }

  @override
  Future<void> close() {
    recorder.closeRecorder();
    return super.close();
  }
}
