part of 'channel_bloc.dart';

class ChannelEvent {}

class CreateChannelEvent extends ChannelEvent {
  String name;
  File image;
  String description;
  CreateChannelEvent({
    required this.name,
    required this.image,
    required this.description,
  });
}

class GetUserChannelEvent extends ChannelEvent{}

class CheckAndShowChannelEvent extends ChannelEvent{
   int id;
  CheckAndShowChannelEvent({
    required this.id,
  });
}

class UpdateChannelImageEvent extends ChannelEvent {
  int channelId;
  File image;
  UpdateChannelImageEvent({
    required this.channelId,
    required this.image,
  });
}

class ShowChannelInfo extends ChannelEvent {
  int id;
  ShowChannelInfo({
    required this.id,
  });
}

class ShowChannelPodcasts extends ChannelEvent {
  int id;
  ShowChannelPodcasts({
    required this.id,
  });
}

class ShowChannelDescription extends ChannelEvent {
  int id;
  ShowChannelDescription({
    required this.id,
  });
}

class DeletePodcastEvent extends ChannelEvent {
  int id;
  DeletePodcastEvent({
    required this.id,
  });
}

class ToggleFollowEvent extends ChannelEvent {
  int id;
  ToggleFollowEvent({
    required this.id,
  });
  
}

class CheckChannelFollowEvent extends ChannelEvent {
   int id;
  CheckChannelFollowEvent({
    required this.id,
  });
  
}
