import 'package:bloc/bloc.dart';
import 'package:mahatacast/features/explore/data/repositories/explore_repo.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreState()) {
    on<SearchBasedOnTitleEvent>((event, emit) async {
      emit(state.copyWith(resultListStatus: ExploreStatus.loading));
      final result = await ExploreRepo().searchBasedOnTitle(event.title);
      result.fold((left) {
        emit(state.copyWith(resultListStatus: ExploreStatus.failed));
      }, (right) {
        emit(state.copyWith(
            resultListStatus: ExploreStatus.success,
            resultList: right.resultList));
      });
    });
    on<GetMostListendPodcastsEvent>((event, emit) async {
      emit(state.copyWith(mostListenedListStatus: ExploreStatus.loading));
      final result = await ExploreRepo().getMostListendPodcasts();
      result.fold((left) {
        emit(state.copyWith(mostListenedListStatus: ExploreStatus.failed));
      }, (right) {
        emit(state.copyWith(
            mostListenedListStatus: ExploreStatus.success,
            mostListenedList: right.podcastList));
      });
    });
    on<GetTopRatedPodcastsEvent>((event, emit) async {
      emit(state.copyWith(topRatedListStatus: ExploreStatus.loading));
      final result = await ExploreRepo().getTopRatedPodcasts();
      result.fold((left) {
        emit(state.copyWith(topRatedListStatus: ExploreStatus.failed));
      }, (right) {
        emit(state.copyWith(
            topRatedListStatus: ExploreStatus.success,
            topRatedList: right.podcastList));
      });
    });
    on<GetLatestPodcastsEvent>((event, emit) async {
      emit(state.copyWith(latestListStatus: ExploreStatus.loading));
      final result = await ExploreRepo().getLatestPodcasts();
      result.fold((left) {
        emit(state.copyWith(latestListStatus: ExploreStatus.failed));
      }, (right) {
        emit(state.copyWith(
            latestListStatus: ExploreStatus.success,
            latestList: right.podcastList));
      });
    });
  }
}
