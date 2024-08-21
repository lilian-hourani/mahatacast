import 'dart:io';

import 'package:mahatacast/core/api/get_api.dart';
import 'package:mahatacast/core/api/get_with_token_api.dart';
import 'package:mahatacast/core/api/multi_audio_post_api.dart';
import 'package:mahatacast/core/api/post_api_with_token.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/features/home/data/models/add_podcast_to_listen.dart';
import 'package:mahatacast/features/home/data/models/comment_response_model.dart';
import 'package:mahatacast/features/home/data/models/home_response_model.dart';
import 'package:mahatacast/features/home/data/models/review_response_model.dart';
import 'package:mahatacast/features/home/data/models/show_podcast_response_model.dart';
import 'package:mahatacast/features/home/data/models/tag_response_model.dart';
import 'package:mahatacast/features/home/data/models/toggle_response_model.dart';
import 'package:mahatacast/features/home/data/models/upload_response_model.dart';
import 'package:mahatacast/features/home/data/models/user_favorite_ids_model.dart';

class PodcastDataSource {
  Future<ShowPodcastResponseModel> showPodcast(
      int podcastId, String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/show/podcast/$podcastId"),
        token: token,
        fromJson: showPodcastResponseModelFromJson);
    return await result.callRequest();
  }

  Future<AddPodcastToListen> addPodcastToListen(
      String token, int podcastId, String duration) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/add/podcast/to/user/listens"),
        body: ({"podcast_id": podcastId, "listening_duration": duration}),
        token: token,
        fromJson: addPodcastToListenFromJson);
    return await result.callRequest();
  }

  Future<CommentResponseModel> showPodcastCommenst(
      int podcastId, String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/show/podcast/comments/$podcastId"),
        token: token,
        fromJson: commentResponseModelFromJson);
    return await result.callRequest();
  }

  Future<List<int>> checkFavorite(String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/user/favourite/podcasts/ids"),
        token: token,
        fromJson: userFavoriteIdsModelFromJson);
    return await result.callRequest();
  }

  Future<ToggleResponseModel> toggleFavorite(
      String token, int podcastId) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/toggle/podcast/$podcastId"),
        token: token,
        fromJson: toggleResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ReviewResponseModel> rateAndReview(
      String token, int podcastId, int rating, String comment) async {
    final result = PostApiWithToken(
        uri: Uri.parse("$baseUri/api/add/review"),
        body: ({
          "podcast_id": podcastId,
          "rating": rating.toString(),
          "comment": comment
        }),
        token: token,
        fromJson: reviewResponseModelFromJson);
    return await result.call();
  }

  Future<UploadResponseModel> uploadPodcast(String token, String title,
      File podcast, int contentId, List<int> tags, String duration) async {
    Map<String, String> body = {
      "title": title,
      "content_id": contentId.toString(),
      "podcast_duration": duration,
    };
    for (int i = 0; i < tags.length; i++) {
      body["tags[$i]"] = tags[i].toString();
    }
    final result = MultiAudioPostApi(
        uri: Uri.parse("$baseUri/api/upload"),
        body: body,
        audio: podcast,
        fromJson: uploadResponseModelFromJson,
        token: token);
    print(body);
    return await result.callRequest();
  }

  Future<ToggleResponseModel> deletePodcast(String token, int podcastId) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/delete/podcast/$podcastId"),
        token: token,
        fromJson: toggleResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ToggleResponseModel> downloadPodcast(
      String token, int podcastId) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/podcast/download/$podcastId"),
        token: token,
        fromJson: toggleResponseModelFromJson);
    return await result.callRequest();
  }

  Future<TagResponseModel> getAllTags() async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/tags"),
        fromJson: tagResponseModelFromJson);
    return await result.callRequest();
  }

  Future<TagResponseModel> createTag(String token, List<String> tags) async {
    final result = PostApiWithToken(
      uri: Uri.parse("$baseUri/api/create/tags"),
      token: token,
      body: ({
        "tag": tags,
      }),
      fromJson: tagResponseModelFromJson,
    );
    return await result.call();
  }

  Future<TagResponseModel> getPodcastTags(int podcastId) async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/podcast/tags/$podcastId"),
        fromJson: tagResponseModelFromJson);
    return await result.callRequest();
  }

  Future<HomeResponseModel> showPodcastBasedOnTag(int tagId) async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/podcasts/based/tag/$tagId"),
        fromJson: homeResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ToggleResponseModel> reportPodcast(String token, int podcastId) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/report/podcast/$podcastId"),
        token: token,
        fromJson: toggleResponseModelFromJson);
    return await result.callRequest();
  }
}
