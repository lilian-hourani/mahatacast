part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failed }

class HomeState {
  HomeStatus homeContentListStatus;
  List<Content> homeContentList;
  HomeStatus homeListStatus;
  List<PodcastModel> homeList;
  HomeStatus podcastModelStatus;
  PodcastModel? podcastModel;
  HomeStatus latestListenPodcastStatus;
  PodcastModel? latestListenPodcast;
  HomeState({
    this.homeContentListStatus = HomeStatus.initial,
    this.homeContentList = const [],
    this.homeListStatus = HomeStatus.initial,
    this.homeList = const [],
    this.podcastModelStatus = HomeStatus.initial,
    this.podcastModel,
    this.latestListenPodcastStatus = HomeStatus.initial,
    this.latestListenPodcast,
  });

  HomeState copyWith({
    HomeStatus? homeContentListStatus,
    List<Content>? homeContentList,
    HomeStatus? homeListStatus,
    List<PodcastModel>? homeList,
    HomeStatus? podcastModelStatus,
    PodcastModel? podcastModel,
    HomeStatus? latestListenPodcastStatus,
    PodcastModel? latestListenPodcast,
  }) {
    return HomeState(
      homeContentListStatus: homeContentListStatus ?? this.homeContentListStatus,
      homeContentList: homeContentList ?? this.homeContentList,
      homeListStatus: homeListStatus ?? this.homeListStatus,
      homeList: homeList ?? this.homeList,
      podcastModelStatus: podcastModelStatus ?? this.podcastModelStatus,
      podcastModel: podcastModel ?? this.podcastModel,
      latestListenPodcastStatus: latestListenPodcastStatus ?? this.latestListenPodcastStatus,
      latestListenPodcast: latestListenPodcast ?? this.latestListenPodcast,
    );
  }
}
