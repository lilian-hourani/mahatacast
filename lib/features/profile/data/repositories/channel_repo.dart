import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mahatacast/core/api/failures.dart';
import 'package:mahatacast/core/api/handling_exception_manager.dart';
import 'package:mahatacast/features/home/data/models/toggle_response_model.dart';
import 'package:mahatacast/features/profile/data/datasource/channel_datasource.dart';
import 'package:mahatacast/features/profile/data/models/channel_info_response_model.dart';
import 'package:mahatacast/features/profile/data/models/channel_model.dart';
import 'package:mahatacast/features/profile/data/models/channel_podcast_response_model.dart';
import 'package:mahatacast/features/profile/data/models/channnel_description_response_model.dart';
import 'package:mahatacast/features/profile/data/models/update_channel_image_response_model.dart';

class ChannelRepo with HandlingExceptionManager {
  Future<Either<Failure, ChannelInfoResponseModel>> createChannel(
      String token, String name, File image, String description) {
    return wrapHandling(
      tryCall: () async {
        final result = await ChannelDataSource()
            .createChannel(token, name, image, description);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ChannelResponseModel>> getUserChannel(String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await ChannelDataSource().getUserChannel(token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, UpdateChannelImageResponseModel>> updateChannelImage(
      String token, int channelId, File image) {
    return wrapHandling(
      tryCall: () async {
        final result = await ChannelDataSource()
            .updateChannelImage(token, channelId, image);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ChannelInfoResponseModel>> showChannelInfo(int id) {
    return wrapHandling(
      tryCall: () async {
        final result = await ChannelDataSource().showChannelInfo(id);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ChannelPodcastResponseModel>> showChannelPodcasts(
      int id) {
    return wrapHandling(
      tryCall: () async {
        final result = await ChannelDataSource().showChannelPodcasts(id);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ChannelDescriptionResponseModel>>
      showChannelDescription(int id) {
    return wrapHandling(
      tryCall: () async {
        final result = await ChannelDataSource().showChannelDescription(id);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ToggleResponseModel>> toggleFollow(
      String token, int id) {
    return wrapHandling(
      tryCall: () async {
        final result = await ChannelDataSource().toggleFollow(token, id);
        return Right(result);
      },
    );
  }
}
