import 'package:mahatacast/core/api/get_api.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/features/explore/data/models/explore_list_response_model.dart';
import 'package:mahatacast/features/explore/data/models/search_response_model.dart';

class ExploreDataSource {
  Future<SearchResponseModel> searchBasedOnTitle(String title) async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/search/based/title?search=$title"),
        fromJson: searchResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ExploreListResponseModel> getMostListendPodcasts() async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/most/listened/podcasts"),
        fromJson: exploreListResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ExploreListResponseModel> getTopRatedPodcasts() async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/top/podcasts"),
        fromJson: exploreListResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ExploreListResponseModel> getLatestPodcasts() async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/latest/podcasts"),
        fromJson: exploreListResponseModelFromJson);
    return await result.callRequest();
  }
}
