import 'dart:io';

import 'package:mahatacast/core/api/get_api.dart';
import 'package:mahatacast/core/api/get_with_token_api.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/features/home/data/models/toggle_response_model.dart';
import 'package:mahatacast/features/profile/data/models/channel_info_response_model.dart';
import 'package:mahatacast/features/profile/data/models/channel_model.dart';
import 'package:mahatacast/features/profile/data/models/channel_podcast_response_model.dart';
import 'package:mahatacast/features/profile/data/models/channnel_description_response_model.dart';
import 'package:mahatacast/features/profile/data/models/update_channel_image_response_model.dart';

import '../../../../core/api/multi_post_api.dart';

class ChannelDataSource {
  Future<ChannelInfoResponseModel> createChannel(
      String token, String name, File image, String description) async {
    final result = MultiPostApi(
        uri: Uri.parse("$baseUri/api/request/create/channel"),
        token: token,
        body: ({
          "name": name,
          "description": description,
        }),
        images: {'image': image},
        fromJson: channelInfoResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ChannelResponseModel> getUserChannel(String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/get/user/channel/info"),
        token: token,
        fromJson: channelResponseModelFromJson);
    return await result.callRequest();
  }

  Future<UpdateChannelImageResponseModel> updateChannelImage(
      String token, int channelId, File image) async {
    final result = MultiPostApi(
        uri: Uri.parse("$baseUri/api/update/channel/image"),
        body: ({"channel_id": channelId.toString()}),
        images: {'image': image},
        fromJson: updateChannelImageResponseModelFromJson,
        token: token);
    return await result.callRequest();
  }

  Future<ChannelInfoResponseModel> showChannelInfo(int id) async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/channel/info/$id"),
        fromJson: channelInfoResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ChannelPodcastResponseModel> showChannelPodcasts(int id) async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/channel/podcasts/$id"),
        fromJson: channelPodcastResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ChannelDescriptionResponseModel> showChannelDescription(int id) async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/channel/description/$id"),
        fromJson: channelDescriptionResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ToggleResponseModel> toggleFollow(String token, int id) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/follow/$id"),
        token: token,
        fromJson: toggleResponseModelFromJson);
    return await result.callRequest();
  }
}
