part of 'home_bloc.dart';

class HomeEvent {}

class GetHomeContentListEvent extends HomeEvent {}

class GetVisiterHomeContentListEvent extends HomeEvent {}

class SelectContentWithVisitorEvent extends HomeEvent {
  int contentId;
  SelectContentWithVisitorEvent({
    required this.contentId,
  });
}

class SelectContentWithUserEvent extends HomeEvent {
  int contentId;
  SelectContentWithUserEvent({
    required this.contentId,
  });
}

class ShowPocastEvent extends HomeEvent {
  int podacastId;
  ShowPocastEvent({
    required this.podacastId,
  });
}

class GetLatestListenPodcastEvent extends HomeEvent {}
