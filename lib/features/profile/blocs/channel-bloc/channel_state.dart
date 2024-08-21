part of 'channel_bloc.dart';

enum ChannelStatus {
  initial,
  loading,
  created,
  success,
  failed,
  deleted,
  undeleted
}

class ChannelState {
  ChannelStatus createChannelStatus;
  ChannelInfo? channelModel;
  ChannelStatus userChannelStatus;
  UserChannelModel? userChannel;
  ChannelStatus channelInfoStatus;
  ChannelInfo? channelInfo;
  ChannelStatus channelPodcastStatus;
  List<PodcastModel>? podcastList;
  ChannelStatus descriptionStatus;
  String? description;
  ChannelStatus updateChannelImageStatus;
  ChannelStatus deletePodcastStatus;
  final bool isFollowed;
  final List<ChannelModel> followedChannels;
  String? channelMsg;
  String? podcastMsg;
  ChannelStatus checkDeleteStatus;
  ChannelState({
    this.createChannelStatus = ChannelStatus.initial,
    this.channelModel,
    this.userChannelStatus = ChannelStatus.initial,
    this.userChannel,
    this.channelInfoStatus = ChannelStatus.initial,
    this.channelInfo,
    this.channelPodcastStatus = ChannelStatus.initial,
    this.podcastList = const [],
    this.descriptionStatus = ChannelStatus.initial,
    this.description,
    this.updateChannelImageStatus = ChannelStatus.initial,
    this.deletePodcastStatus = ChannelStatus.initial,
    this.isFollowed = false,
    this.followedChannels = const [],
    this.channelMsg,
    this.podcastMsg,
    this.checkDeleteStatus = ChannelStatus.initial,
  });

  ChannelState copyWith({
    ChannelStatus? createChannelStatus,
    ChannelInfo? channelModel,
    ChannelStatus? userChannelStatus,
    UserChannelModel? userChannel,
    ChannelStatus? channelInfoStatus,
    ChannelInfo? channelInfo,
    ChannelStatus? channelPodcastStatus,
    List<PodcastModel>? podcastList,
    ChannelStatus? descriptionStatus,
    String? description,
    ChannelStatus? updateChannelImageStatus,
    ChannelStatus? deletePodcastStatus,
    bool? isFollowed,
    List<ChannelModel>? followedChannels,
    String? channelMsg,
    String? podcastMsg,
    ChannelStatus? checkDeleteStatus,
  }) {
    return ChannelState(
      createChannelStatus: createChannelStatus ?? this.createChannelStatus,
      channelModel: channelModel ?? this.channelModel,
      userChannelStatus: userChannelStatus ?? this.userChannelStatus,
      userChannel: userChannel ?? this.userChannel,
      channelInfoStatus: channelInfoStatus ?? this.channelInfoStatus,
      channelInfo: channelInfo ?? this.channelInfo,
      channelPodcastStatus: channelPodcastStatus ?? this.channelPodcastStatus,
      podcastList: podcastList ?? this.podcastList,
      descriptionStatus: descriptionStatus ?? this.descriptionStatus,
      description: description ?? this.description,
      updateChannelImageStatus: updateChannelImageStatus ?? this.updateChannelImageStatus,
      deletePodcastStatus: deletePodcastStatus ?? this.deletePodcastStatus,
      isFollowed: isFollowed ?? this.isFollowed,
      followedChannels: followedChannels ?? this.followedChannels,
      channelMsg: channelMsg ?? this.channelMsg,
      podcastMsg: podcastMsg ?? this.podcastMsg,
      checkDeleteStatus: checkDeleteStatus ?? this.checkDeleteStatus,
    );
  }
}
