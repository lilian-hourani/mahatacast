import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mahatacast/features/home/data/repositories/podcast_repo.dart';
import 'package:mahatacast/features/library/data/models/show_followed_channel_model.dart';
import 'package:mahatacast/features/library/data/repositories/library_repo.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/profile/data/models/channel_info_response_model.dart';
import 'package:mahatacast/features/profile/data/models/channel_model.dart';
import 'package:mahatacast/features/profile/data/repositories/channel_repo.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  bool isdeleted = false;
  ChannelBloc() : super(ChannelState()) {
    bool isFollowed = false;
    on<CreateChannelEvent>((event, emit) async {
      emit(state.copyWith(createChannelStatus: ChannelStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      print(token);
      if (token != null) {
        final result = await ChannelRepo()
            .createChannel(token, event.name, event.image, event.description);
        result.fold(
            (left) =>
                emit(state.copyWith(createChannelStatus: ChannelStatus.failed)),
            (right) => emit(state.copyWith(
                createChannelStatus: ChannelStatus.created,
                channelModel: right.data)));
      }
    });
    on<GetUserChannelEvent>((event, emit) async {
      emit(state.copyWith(userChannelStatus: ChannelStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      print(token);
      if (token != null) {
        final result = await ChannelRepo().getUserChannel(token);
        result.fold(
            (left) =>
                emit(state.copyWith(userChannelStatus: ChannelStatus.failed)),
            (right) => emit(state.copyWith(
                userChannelStatus: ChannelStatus.success,
                userChannel: right.channel)));
      }
    });
    on<CheckAndShowChannelEvent>((event, emit) async {
      emit(state.copyWith(checkDeleteStatus: ChannelStatus.loading));
      final result = await ChannelRepo().showChannelInfo(event.id);
      result.fold(
          (left) =>
              emit(state.copyWith(checkDeleteStatus: ChannelStatus.failed)),
          (right) {
        if (right.msg == "Channel Not Retrieved Successfully") {
          emit(state.copyWith(checkDeleteStatus: ChannelStatus.deleted));
        } else {
          emit(state.copyWith(
            checkDeleteStatus: ChannelStatus.undeleted,
            channelInfoStatus: ChannelStatus.success,
            channelInfo: right.data,
            descriptionStatus: ChannelStatus.success,
            description: right.data!.description!,
          ));
        }
      });
    });
    on<UpdateChannelImageEvent>((event, emit) async {
      emit(state.copyWith(updateChannelImageStatus: ChannelStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      print(token);
      if (token != null) {
        final result = await ChannelRepo()
            .updateChannelImage(token, event.channelId, event.image);
        result.fold(
            (left) => emit(
                state.copyWith(updateChannelImageStatus: ChannelStatus.failed)),
            (right) => emit(state.copyWith(
                  updateChannelImageStatus: ChannelStatus.success,
                )));
      }
    });
    on<ShowChannelInfo>((event, emit) async {
      emit(state.copyWith(
          channelInfoStatus: ChannelStatus.loading,
          descriptionStatus: ChannelStatus.loading));
      final result = await ChannelRepo().showChannelInfo(event.id);
      result.fold(
          (left) => emit(state.copyWith(
              channelInfoStatus: ChannelStatus.failed,
              descriptionStatus: ChannelStatus.failed)),
          (right) => emit(state.copyWith(
              channelInfoStatus: ChannelStatus.success,
              channelInfo: right.data,
              descriptionStatus: ChannelStatus.success,
              description: right.data!.description!,
              channelMsg: right.msg)));
    });
    on<ShowChannelPodcasts>((event, emit) async {
      emit(state.copyWith(channelPodcastStatus: ChannelStatus.loading));
      final result = await ChannelRepo().showChannelPodcasts(event.id);
      result.fold(
          (left) =>
              emit(state.copyWith(channelPodcastStatus: ChannelStatus.failed)),
          (right) {
        if (right.msg == " No Channel Podcasts ") {
          isdeleted = true;
        }
        emit(state.copyWith(
            channelPodcastStatus: ChannelStatus.success,
            podcastList: right.data,
            podcastMsg: right.msg));
      });
    });
    on<ShowChannelDescription>((event, emit) async {
      emit(state.copyWith(descriptionStatus: ChannelStatus.loading));
      final result = await ChannelRepo().showChannelDescription(event.id);
      result.fold(
          (left) =>
              emit(state.copyWith(descriptionStatus: ChannelStatus.failed)),
          (right) => emit(state.copyWith(
              descriptionStatus: ChannelStatus.success,
              description: right.description)));
    });
    on<DeletePodcastEvent>((event, emit) async {
      emit(state.copyWith(deletePodcastStatus: ChannelStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      print(token);
      if (token != null) {
        final result = await PodcastRepo().deletePodcast(token, event.id);
        result.fold(
            (left) =>
                emit(state.copyWith(deletePodcastStatus: ChannelStatus.failed)),
            (right) => emit(state.copyWith(
                  deletePodcastStatus: ChannelStatus.success,
                )));
      }
    });
    on<ToggleFollowEvent>((event, emit) async {
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await ChannelRepo().toggleFollow(token, event.id);
        result.fold((left) {
          isFollowed = isFollowed;
        }, (right) {
          print(right.msg);
          if (right.msg == "Channel Added To Follow Successfully") {
            isFollowed = true;
          } else {
            isFollowed = false;
          }
        });
        emit(state.copyWith(isFollowed: isFollowed));
      }
    });
    on<CheckChannelFollowEvent>((event, emit) async {
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await LibraryRepo().getFollowedChannels(token);
        result.fold((left) {
          isFollowed = isFollowed;
        }, (right) {
          print(right);
          for (int i = 0; i < right.channelList!.length; i++) {
            if (right.channelList![i].id == event.id) {
              isFollowed = true;
              break;
            } else {
              isFollowed = false;
            }
          }
        });
      }
      emit(state.copyWith(isFollowed: isFollowed));
    });
  }
}
