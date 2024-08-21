part of 'podcast_bloc.dart';

enum PodcastStatus { intial, loading, success, failed }

class PodcastState {
  List<Tag> tagList;
  PodcastStatus createTagStatus;
  PodcastStatus upLoadStatus;
  PodcastModel? uploadedPodcast;
  PodcastStatus tagListStatus;
  PodcastStatus commentsListStatus;
  PodcastStatus rateAndReviewStatus;
  List<CommentModel> commentsList;
  PodcastStatus downloadPodcastStatus;
  PodcastStatus podcastTagsListStatus;
  List<Tag> podcastTagsList;
  PodcastStatus podcastListBasedOnTagStatus;
  List<PodcastModel> podcastListBasedOnTag;
  PodcastState({
    this.tagList = const [],
    this.createTagStatus = PodcastStatus.intial,
    this.upLoadStatus = PodcastStatus.intial,
    this.uploadedPodcast,
    this.tagListStatus = PodcastStatus.intial,
    this.commentsListStatus = PodcastStatus.intial,
    this.rateAndReviewStatus = PodcastStatus.intial,
    this.commentsList = const [],
    this.downloadPodcastStatus = PodcastStatus.intial,
    this.podcastTagsListStatus = PodcastStatus.intial,
    this.podcastTagsList = const [],
    this.podcastListBasedOnTagStatus = PodcastStatus.intial,
    this.podcastListBasedOnTag = const []
  });

  PodcastState copyWith({
    List<Tag>? tagList,
    PodcastStatus? createTagStatus,
    PodcastStatus? upLoadStatus,
    PodcastModel? uploadedPodcast,
    PodcastStatus? tagListStatus,
    PodcastStatus? commentsListStatus,
    PodcastStatus? rateAndReviewStatus,
    List<CommentModel>? commentsList,
    PodcastStatus? downloadPodcastStatus,
    PodcastStatus? podcastTagsListStatus,
    List<Tag>? podcastTagsList,
    PodcastStatus? podcastListBasedOnTagStatus,
    List<PodcastModel>? podcastListBasedOnTag,
  }) {
    return PodcastState(
      tagList: tagList ?? this.tagList,
      createTagStatus: createTagStatus ?? this.createTagStatus,
      upLoadStatus: upLoadStatus ?? this.upLoadStatus,
      uploadedPodcast: uploadedPodcast ?? this.uploadedPodcast,
      tagListStatus: tagListStatus ?? this.tagListStatus,
      commentsListStatus: commentsListStatus ?? this.commentsListStatus,
      rateAndReviewStatus: rateAndReviewStatus ?? this.rateAndReviewStatus,
      commentsList: commentsList ?? this.commentsList,
      downloadPodcastStatus: downloadPodcastStatus ?? this.downloadPodcastStatus,
      podcastTagsListStatus: podcastTagsListStatus ?? this.podcastTagsListStatus,
      podcastTagsList: podcastTagsList ?? this.podcastTagsList,
      podcastListBasedOnTagStatus: podcastListBasedOnTagStatus ?? this.podcastListBasedOnTagStatus,
      podcastListBasedOnTag: podcastListBasedOnTag ?? this.podcastListBasedOnTag,
    );
  }
}
