part of 'library_bloc.dart';

enum LibraryStatus { initail, loading, success, failure }

class LibraryState {
  List<PodcastModel> favoriteList;
  LibraryStatus favoriteListStatus;
  List<PodcastModel> downloadList;
  LibraryStatus downloadListStatus;
  List<ChannelModel> followedChannelsList;
  LibraryStatus followedChannelsListStatus;
  List<NotificationModel> unreadNotificationList;
  LibraryStatus unreadNotificationListStatus;

  LibraryState({
    this.favoriteList = const [],
    this.favoriteListStatus = LibraryStatus.initail,
    this.downloadList = const [],
    this.downloadListStatus = LibraryStatus.initail,
    this.followedChannelsList = const [],
    this.followedChannelsListStatus = LibraryStatus.initail,
    this.unreadNotificationList = const [],
    this.unreadNotificationListStatus = LibraryStatus.initail
  });

  LibraryState copyWith({
    List<PodcastModel>? favoriteList,
    LibraryStatus? favoriteListStatus,
    List<PodcastModel>? downloadList,
    LibraryStatus? downloadListStatus,
    List<ChannelModel>? followedChannelsList,
    LibraryStatus? followedChannelsListStatus,
    List<NotificationModel>? unreadNotificationList,
    LibraryStatus? unreadNotificationListStatus,
  }) {
    return LibraryState(
      favoriteList: favoriteList ?? this.favoriteList,
      favoriteListStatus: favoriteListStatus ?? this.favoriteListStatus,
      downloadList: downloadList ?? this.downloadList,
      downloadListStatus: downloadListStatus ?? this.downloadListStatus,
      followedChannelsList: followedChannelsList ?? this.followedChannelsList,
      followedChannelsListStatus: followedChannelsListStatus ?? this.followedChannelsListStatus,
      unreadNotificationList: unreadNotificationList ?? this.unreadNotificationList,
      unreadNotificationListStatus: unreadNotificationListStatus ?? this.unreadNotificationListStatus,
    );
  }
}
