import 'package:dartz/dartz.dart';
import 'package:mahatacast/core/api/failures.dart';
import 'package:mahatacast/core/api/handling_exception_manager.dart';
import 'package:mahatacast/features/explore/data/datasource/explore_datasource.dart';
import 'package:mahatacast/features/explore/data/models/explore_list_response_model.dart';
import 'package:mahatacast/features/explore/data/models/search_response_model.dart';

class ExploreRepo with HandlingExceptionManager {
  Future<Either<Failure, SearchResponseModel>> searchBasedOnTitle(
      String title) {
    return wrapHandling(
      tryCall: () async {
        final result = await ExploreDataSource().searchBasedOnTitle(title);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ExploreListResponseModel>> getMostListendPodcasts() {
    return wrapHandling(
      tryCall: () async {
        final result = await ExploreDataSource().getMostListendPodcasts();
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ExploreListResponseModel>> getTopRatedPodcasts() {
    return wrapHandling(
      tryCall: () async {
        final result = await ExploreDataSource().getTopRatedPodcasts();
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ExploreListResponseModel>> getLatestPodcasts() {
    return wrapHandling(
      tryCall: () async {
        final result = await ExploreDataSource().getLatestPodcasts();
        return Right(result);
      },
    );
  }
}
