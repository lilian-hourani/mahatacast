part of 'explore_bloc.dart';

enum ExploreStatus { initial, loading, success, failed }

class ExploreState {
  ExploreStatus mostListenedListStatus;
  List<PodcastModel> mostListenedList;
  ExploreStatus topRatedListStatus;
  List<PodcastModel> topRatedList;
  ExploreStatus latestListStatus;
  List<PodcastModel> latestList;
  ExploreStatus resultListStatus;
  List<PodcastModel> resultList;
  ExploreState({
     this.mostListenedListStatus = ExploreStatus.initial,
     this.mostListenedList = const [],
     this.topRatedListStatus = ExploreStatus.initial,
     this.topRatedList = const [],
     this.latestListStatus = ExploreStatus.initial,
     this.latestList = const [],
     this.resultListStatus = ExploreStatus.initial,
     this.resultList = const [],
  });

  ExploreState copyWith({
    ExploreStatus? mostListenedListStatus,
    List<PodcastModel>? mostListenedList,
    ExploreStatus? topRatedListStatus,
    List<PodcastModel>? topRatedList,
    ExploreStatus? latestListStatus,
    List<PodcastModel>? latestList,
    ExploreStatus? resultListStatus,
    List<PodcastModel>? resultList,
  }) {
    return ExploreState(
      mostListenedListStatus: mostListenedListStatus ?? this.mostListenedListStatus,
      mostListenedList: mostListenedList ?? this.mostListenedList,
      topRatedListStatus: topRatedListStatus ?? this.topRatedListStatus,
      topRatedList: topRatedList ?? this.topRatedList,
      latestListStatus: latestListStatus ?? this.latestListStatus,
      latestList: latestList ?? this.latestList,
      resultListStatus: resultListStatus ?? this.resultListStatus,
      resultList: resultList ?? this.resultList,
    );
  }
}
