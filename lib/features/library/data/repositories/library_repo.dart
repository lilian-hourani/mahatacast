import 'package:dartz/dartz.dart';
import 'package:mahatacast/core/api/failures.dart';
import 'package:mahatacast/core/api/handling_exception_manager.dart';
import 'package:mahatacast/features/library/data/datasource/library_datasource.dart';
import 'package:mahatacast/features/library/data/models/notification_response_model.dart';
import 'package:mahatacast/features/library/data/models/show_followed_channel_model.dart';
import 'package:mahatacast/features/library/data/models/show_user_favorite_or_download_model.dart';

class LibraryRepo with HandlingExceptionManager {
  Future<Either<Failure, ShowFollowedChannelModel>> getFollowedChannels(
      String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await LibraryDataSource().getFollowedChannels(token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ShowUserListResponseModel>> getFavoriteList(String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await LibraryDataSource().getFavoriteList(token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure,ShowUserListResponseModel>> getDownloadList(
      String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await LibraryDataSource().getDownloadList(token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, NotificationResponseModel>> getUnreadNotification(
      String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await LibraryDataSource().getUnreadNotification(token);
        return Right(result);
      },
    );
  }
}
