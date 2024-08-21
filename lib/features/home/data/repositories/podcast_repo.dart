import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mahatacast/core/api/failures.dart';
import 'package:mahatacast/core/api/handling_exception_manager.dart';
import 'package:mahatacast/features/home/data/datasource/podcast_datasource.dart';
import 'package:mahatacast/features/home/data/models/add_podcast_to_listen.dart';
import 'package:mahatacast/features/home/data/models/comment_response_model.dart';
import 'package:mahatacast/features/home/data/models/home_response_model.dart';
import 'package:mahatacast/features/home/data/models/review_response_model.dart';
import 'package:mahatacast/features/home/data/models/show_podcast_response_model.dart';
import 'package:mahatacast/features/home/data/models/tag_response_model.dart';
import 'package:mahatacast/features/home/data/models/toggle_response_model.dart';
import 'package:mahatacast/features/home/data/models/upload_response_model.dart';

class PodcastRepo with HandlingExceptionManager {
  Future<Either<Failure, ShowPodcastResponseModel>> showPodcast(
      int podcastId, String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource().showPodcast(podcastId, token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, AddPodcastToListen>> addPodcastToListen(
      String token, int podcastId, String duration) {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource()
            .addPodcastToListen(token, podcastId, duration);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, CommentResponseModel>> showPodcastCommenst(
      int podcastId, String token) {
    return wrapHandling(
      tryCall: () async {
        final result =
            await PodcastDataSource().showPodcastCommenst(podcastId, token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, List<int>>> checkFavorite(String token, int id) {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource().checkFavorite(token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ToggleResponseModel>> toggleFavorite(
      String token, int podcastId) {
    return wrapHandling(
      tryCall: () async {
        final result =
            await PodcastDataSource().toggleFavorite(token, podcastId);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ReviewResponseModel>> rateAndReview(
      String token, int podcastId, int rating, String comment) {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource()
            .rateAndReview(token, podcastId, rating, comment);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, UploadResponseModel>> uploadPodcast(
      String token,
      String title,
      File podcast,
      int contentId,
      List<int> tags,
      String duration) {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource()
            .uploadPodcast(token, title, podcast, contentId, tags, duration);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ToggleResponseModel>> deletePodcast(
      String token, int podcastId) {
    return wrapHandling(
      tryCall: () async {
        final result =
            await PodcastDataSource().deletePodcast(token, podcastId);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ToggleResponseModel>> downloadPodcast(
      String token, int podcastId) async {
    return wrapHandling(
      tryCall: () async {
        final result =
            await PodcastDataSource().downloadPodcast(token, podcastId);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, TagResponseModel>> getAllTags() {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource().getAllTags();
        return Right(result);
      },
    );
  }

  Future<Either<Failure, TagResponseModel>> createTag(
      String token, List<String> tags) {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource().createTag(token, tags);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, TagResponseModel>> getPodcastTags(
      int podcastId) async {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource().getPodcastTags(podcastId);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, HomeResponseModel>> showPodcastBasedOnTag(
      int tagId) async {
    return wrapHandling(
      tryCall: () async {
        final result = await PodcastDataSource().showPodcastBasedOnTag(tagId);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ToggleResponseModel>> reportPodcast(
      String token, int podcastId) {
    return wrapHandling(
      tryCall: () async {
        final result =
            await PodcastDataSource().reportPodcast(token, podcastId);
        return Right(result);
      },
    );
  }
}
