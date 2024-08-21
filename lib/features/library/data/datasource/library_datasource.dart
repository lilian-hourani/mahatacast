import 'package:mahatacast/core/api/get_with_token_api.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/features/library/data/models/notification_response_model.dart';
import 'package:mahatacast/features/library/data/models/show_followed_channel_model.dart';
import 'package:mahatacast/features/library/data/models/show_user_favorite_or_download_model.dart';

class LibraryDataSource {
  Future<ShowFollowedChannelModel> getFollowedChannels(
      String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/show/user/followed/channels"),
        token: token,
        fromJson: showFollowedChannelModelFromJson);
    return await result.callRequest();
  }

  Future<ShowUserListResponseModel> getFavoriteList(String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/show/user/favourites/podcasts"),
        token: token,
        fromJson: showUserListResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ShowUserListResponseModel> getDownloadList(String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/user/downloads"),
        token: token,
        fromJson: showUserListResponseModelFromJson);
    return await result.callRequest();
  }

  Future<NotificationResponseModel> getUnreadNotification(String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/show/unread/notifications"),
        token: token,
        fromJson: notificationResponseModelFromJson);
    return await result.callRequest();
  }
}
