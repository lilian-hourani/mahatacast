import 'package:bloc/bloc.dart';
import 'package:mahatacast/features/auth/data/models/content_response_model.dart';
import 'package:mahatacast/features/auth/data/repositories/auth_repo.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/data/repositories/home_repo.dart';
import 'package:mahatacast/features/home/data/repositories/podcast_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<GetHomeContentListEvent>((event, emit) async {
      final bool isVisiter = await ServiceFunctions.checkIsVisitor();
      if (isVisiter) {
        emit(state.copyWith(homeContentListStatus: HomeStatus.loading));
        final result = await AuthRepo().getAllContent();
        result.fold(
            (left) =>
                emit(state.copyWith(homeContentListStatus: HomeStatus.failed)),
            (right) => emit(state.copyWith(
                homeContentList: right.contentList,
                homeListStatus: HomeStatus.success)));
      } else {
        emit(state.copyWith(homeContentListStatus: HomeStatus.loading));
        final String? token = await ServiceFunctions.getUserToken();
        if (token != null) {
          final result = await AuthRepo().getUserContent(token);
          result.fold(
              (left) => emit(
                  state.copyWith(homeContentListStatus: HomeStatus.failed)),
              (right) => emit(state.copyWith(
                  homeContentList: right.contentList,
                  homeContentListStatus: HomeStatus.success)));
        }
      }
    });
    on<SelectContentWithVisitorEvent>((event, emit) async {
      emit(state.copyWith(homeListStatus: HomeStatus.loading));
      final result =
          await HomeRepo().showPodcastBasedOnContent([event.contentId]);
      result.fold((left) {
        emit(state.copyWith(homeListStatus: HomeStatus.failed));
      }, (right) {
        emit(state.copyWith(
            homeList: right.podcastList, homeListStatus: HomeStatus.success));
      });
    });
    on<SelectContentWithUserEvent>((event, emit) async {
      emit(state.copyWith(homeListStatus: HomeStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await HomeRepo()
            .showPodcastBasedOnContentWithUser([event.contentId], token);
        result.fold(
            (left) => emit(state.copyWith(homeListStatus: HomeStatus.failed)),
            (right) => emit(state.copyWith(
                homeList: right.podcastList,
                homeListStatus: HomeStatus.success)));
      }
    });
    on<ShowPocastEvent>((event, emit) async {
      emit(state.copyWith(podcastModelStatus: HomeStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await PodcastRepo().showPodcast(event.podacastId, token);
        result.fold(
            (left) =>
                emit(state.copyWith(podcastModelStatus: HomeStatus.failed)),
            (right) => emit(state.copyWith(
                podcastModelStatus: HomeStatus.success,
                podcastModel: right.data)));
      }
    });
    on<GetLatestListenPodcastEvent>((event, emit) async {
      emit(state.copyWith(latestListenPodcastStatus: HomeStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await HomeRepo().userLatestListenPodcast(token);
        result.fold(
            (left) => emit(
                state.copyWith(latestListenPodcastStatus: HomeStatus.failed)),
            (right) => emit(state.copyWith(
                latestListenPodcastStatus: HomeStatus.success,
                latestListenPodcast: right.podcastModel)));
      }
    });
  }
}
