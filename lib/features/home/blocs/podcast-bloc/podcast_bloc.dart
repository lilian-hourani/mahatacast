import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mahatacast/features/home/data/models/comment_response_model.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/data/models/tag_response_model.dart';
import 'package:mahatacast/features/home/data/repositories/podcast_repo.dart';
import 'package:mahatacast/services/service_fun.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc() : super(PodcastState()) {
    on<GetAllTagsEvent>((event, emit) async {
      emit(state.copyWith(tagListStatus: PodcastStatus.loading));
      final result = await PodcastRepo().getAllTags();
      result.fold(
          (left) => emit(state.copyWith(tagListStatus: PodcastStatus.failed)),
          (right) => emit(state.copyWith(
              tagListStatus: PodcastStatus.success, tagList: right.tagList)));
    });
    on<CreateTagEvent>((event, emit) async {
      emit(state.copyWith(createTagStatus: PodcastStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await PodcastRepo().createTag(token, event.tags);
        result.fold(
            (left) =>
                emit(state.copyWith(createTagStatus: PodcastStatus.failed)),
            (right) =>
                emit(state.copyWith(createTagStatus: PodcastStatus.success)));
      }
    });
    on<GetPodcastTagsEvent>((event, emit) async {
      emit(state.copyWith(podcastTagsListStatus: PodcastStatus.loading));
      final result = await PodcastRepo().getPodcastTags(event.id);
      result.fold(
          (left) =>
              emit(state.copyWith(podcastTagsListStatus: PodcastStatus.failed)),
          (right) => emit(state.copyWith(
              podcastTagsListStatus: PodcastStatus.success,
              podcastTagsList: right.tagList)));
    });
    on<ShowPodcastBasedOnTagEvent>((event, emit) async {
      emit(state.copyWith(podcastListBasedOnTagStatus: PodcastStatus.loading));
      final result = await PodcastRepo().showPodcastBasedOnTag(event.tagId);
      result.fold(
          (left) => emit(state.copyWith(
              podcastListBasedOnTagStatus: PodcastStatus.failed)),
          (right) => emit(state.copyWith(
              podcastListBasedOnTagStatus: PodcastStatus.success,
              podcastListBasedOnTag: right.podcastList)));
    });
    on<UpLoadPodcastEvent>((event, emit) async {
      emit(state.copyWith(upLoadStatus: PodcastStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await PodcastRepo().uploadPodcast(token, event.title,
            event.podcast, event.contentId, event.tags, event.duration);
        result.fold(
            (left) => emit(state.copyWith(upLoadStatus: PodcastStatus.failed)),
            (right) => emit(state.copyWith(
                upLoadStatus: PodcastStatus.success,
                uploadedPodcast: right.podcastModel)));
      }
    });
    on<DownLoadPodcastEvent>((event, emit) async {
      emit(state.copyWith(downloadPodcastStatus: PodcastStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await PodcastRepo().downloadPodcast(token, event.id);
        result.fold(
            (left) => emit(
                state.copyWith(downloadPodcastStatus: PodcastStatus.failed)),
            (right) => emit(state.copyWith(
                  downloadPodcastStatus: PodcastStatus.success,
                )));
      }
    });
    on<GetPodcastCommentsEvent>((event, emit) async {
      emit(state.copyWith(commentsListStatus: PodcastStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await PodcastRepo().showPodcastCommenst(event.id, token);
        result.fold(
            (left) =>
                emit(state.copyWith(commentsListStatus: PodcastStatus.failed)),
            (right) => emit(state.copyWith(
                commentsListStatus: PodcastStatus.success,
                commentsList: right.commentsList)));
      }
    });
    on<RateAndReviewEvent>((event, emit) async {
      emit(state.copyWith(rateAndReviewStatus: PodcastStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await PodcastRepo()
            .rateAndReview(token, event.podcastId, event.rate, event.comment);
        result.fold(
            (left) =>
                emit(state.copyWith(rateAndReviewStatus: PodcastStatus.failed)),
            (right) => emit(state.copyWith(
                  rateAndReviewStatus: PodcastStatus.success,
                )));
      }
    });
  }
}
