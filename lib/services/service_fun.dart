import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class ServiceFunctions {
  static Future<bool> checkIsVisitor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      return true;
    }
    return false;
  }

  static Future<void> setUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    print(token);
    return token;
  }

  static Future<void> deleteUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> setChannelId(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
  }

  static Future<int?> getChannelId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');
    print(id);
    return id;
  }

  static Future<void> deleteChannelId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
  }

  static Future<bool> hasChannel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');
    if (id == null) {
      return false;
    }
    print(id);
    return true;
  }

  //convert duration into min:sec
  static String formatTime(Duration duration) {
    String towDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$towDigitSeconds";
    return formattedTime;
  }

  static String formatTimeForAPI(Duration duration) {
    String towDigitHours =
        duration.inHours.remainder(60).toString().padLeft(2, '0');
    String towDigitMins =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String towDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "$towDigitHours:$towDigitMins:$towDigitSeconds";
    return formattedTime;
  }

  //convert Date into 2024-6-1 01:15
  static String formatDate(DateTime date) {
    String convertedDateTime =
        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}-${date.minute.toString().padLeft(2, '0')}";
    return convertedDateTime;
  }

  // calculate the file size
  static String calculateSize(File file) {
    final kb = file.lengthSync() / 1024;
    final mb = kb / 1024;
    final String fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    return fileSize;
  }

  // download podcast to your local storge
  static void downloadPodcast(String podcastPath) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = Directory('/storage/emulated/0/Download');
      await FlutterDownloader.enqueue(
          url: "$baseUri$podcastPath",
          fileName: basename(podcastPath),
          savedDir: directory.path,
          showNotification: true,
          openFileFromNotification: true);
    }
  }

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort?.send([id, status, progress]);
  }

  // if the app lang is arabic
  static bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  // set and save the app langauge
  static void setLangauge(String lan) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lan', lan);
  }

  // get that app langauge
  static Future<String?> getLangauge() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? lan = prefs.getString('lan');
    print(lan);
    return lan;
  }
}
