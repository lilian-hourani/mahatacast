import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class MultiAudioPostApi with HandlingExceptionRequest {
  final Uri uri;
  final Map<String, String> body;
  final File audio;
  final FromJson fromJson;
  final Duration timeout;
  final String token;

  const MultiAudioPostApi({
    required this.uri,
    required this.body,
    required this.audio,
    required this.fromJson,
    this.timeout = const Duration(seconds: 40),
    required this.token,
  });

  Future<dynamic> callRequest() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('podcast', audio.path,
          filename: basename(
              audio.path))); // Use 'basename' to get the file name from path
      request.fields.addAll(body);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(timeout);
      http.Response response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception',
        name: 'RequestManager post function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri',
        name: 'RequestManager post function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception',
        name: 'RequestManager post function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager post function',
      );
      rethrow;
    }
  }
}
