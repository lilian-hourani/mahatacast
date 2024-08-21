part of 'explore_bloc.dart';

class ExploreEvent {}

class SearchBasedOnTitleEvent extends ExploreEvent {
  String title;
  SearchBasedOnTitleEvent({
    required this.title,
  });
  
}

class GetMostListendPodcastsEvent extends ExploreEvent {}

class GetTopRatedPodcastsEvent extends ExploreEvent {}

class GetLatestPodcastsEvent extends ExploreEvent {}
