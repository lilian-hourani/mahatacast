part of 'podcast_bloc.dart';

class PodcastEvent {}

class GetAllTagsEvent extends PodcastEvent {}

class CreateTagEvent extends PodcastEvent {
  List<String> tags;
  CreateTagEvent({
    required this.tags,
  });
}

class GetPodcastTagsEvent extends PodcastEvent {
  int id;
  GetPodcastTagsEvent({
    required this.id,
  });
}

class ShowPodcastBasedOnTagEvent extends PodcastEvent {
  int tagId;
  ShowPodcastBasedOnTagEvent({
    required this.tagId,
  });
}

class UpLoadPodcastEvent extends PodcastEvent {
  String title;
  File podcast;
  int contentId;
  List<int> tags;
  String duration;
  UpLoadPodcastEvent({
    required this.title,
    required this.podcast,
    required this.contentId,
    required this.tags,
    required this.duration,
  });
}

class DownLoadPodcastEvent extends PodcastEvent {
  int id;
  DownLoadPodcastEvent({
    required this.id,
  });
}

class GetPodcastCommentsEvent extends PodcastEvent {
  int id;
  GetPodcastCommentsEvent({
    required this.id,
  });
}

class RateAndReviewEvent extends PodcastEvent {
  int podcastId;
  int rate;
  String comment;
  RateAndReviewEvent({
    required this.podcastId,
    required this.rate,
    required this.comment,
  });
}

