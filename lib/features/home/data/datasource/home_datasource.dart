import 'package:mahatacast/core/api/get_with_token_api.dart';
import 'package:mahatacast/core/api/post_api.dart';
import 'package:mahatacast/core/api/post_api_with_token.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/features/home/data/models/home_response_model.dart';
import 'package:mahatacast/features/home/data/models/user_latest_listen_podcast.dart';

class HomeDataSource {
  Future<HomeResponseModel> showPodcastBasedOnContent(
      List<int> contentId) async {
    final result = PostApi(
        uri: Uri.parse("$baseUri/api/show/podcasts/based/content"),
        body: ({
          'contentId': contentId,
        }),
        fromJson: homeResponseModelFromJson);
    return await result.call();
  }

  Future<HomeResponseModel> showPodcastBasedOnContentWithUser(
      List<int> contentId, String token) async {
    final result = PostApiWithToken(
        uri: Uri.parse("$baseUri/api/show/podcasts/based/content/with/user"),
        token: token,
        body: ({
          'contentId': contentId,
        }),
        fromJson: homeResponseModelFromJson);
    return await result.call();
  }

  Future<UserLatestListenPodcast> userLatestListenPodcast(String token) async{
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/user/latest/listened/podcast"),
        token: token,
        fromJson: userLatestListenPodcastFromJson);
        return await result.callRequest();
  }

  }
