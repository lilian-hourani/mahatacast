import 'package:dartz/dartz.dart';
import 'package:mahatacast/core/api/failures.dart';
import 'package:mahatacast/core/api/handling_exception_manager.dart';
import 'package:mahatacast/features/home/data/datasource/home_datasource.dart';
import 'package:mahatacast/features/home/data/models/home_response_model.dart';
import 'package:mahatacast/features/home/data/models/user_latest_listen_podcast.dart';

class HomeRepo with HandlingExceptionManager {
  Future<Either<Failure, HomeResponseModel>> showPodcastBasedOnContent(
      List<int> contentId) {
    return wrapHandling(
      tryCall: () async {
        final result =
            await HomeDataSource().showPodcastBasedOnContent(contentId);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, HomeResponseModel>> showPodcastBasedOnContentWithUser(
      List<int> contentId, String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await HomeDataSource()
            .showPodcastBasedOnContentWithUser(contentId, token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, UserLatestListenPodcast>> userLatestListenPodcast(
      String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await HomeDataSource().userLatestListenPodcast(token);
        return Right(result);
      },
    );
  }

}
