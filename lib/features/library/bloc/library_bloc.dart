import 'package:bloc/bloc.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/library/data/models/notification_response_model.dart';
import 'package:mahatacast/features/library/data/models/show_followed_channel_model.dart';
import 'package:mahatacast/features/library/data/repositories/library_repo.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(LibraryState()) {
    on<GetFollowedChannelsListEvent>((event, emit) async {
      emit(state.copyWith(followedChannelsListStatus: LibraryStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await LibraryRepo().getFollowedChannels(token);
        result.fold(
            (left) => emit(state.copyWith(
                followedChannelsListStatus: LibraryStatus.failure)),
            (right) => emit(state.copyWith(
                followedChannelsListStatus: LibraryStatus.success,
                followedChannelsList: right.channelList)));
      }
    });
    on<GetFavoriteListEvent>((event, emit) async {
      emit(state.copyWith(favoriteListStatus: LibraryStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await LibraryRepo().getFavoriteList(token);
        result.fold(
            (left) =>
                emit(state.copyWith(favoriteListStatus: LibraryStatus.failure)),
            (right) => emit(state.copyWith(
                favoriteListStatus: LibraryStatus.success,
                favoriteList: right.podcastList)));
      }
    });
    on<GetDownloadListEvent>((event, emit) async {
      emit(state.copyWith(downloadListStatus: LibraryStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await LibraryRepo().getDownloadList(token);
        result.fold(
            (left) =>
                emit(state.copyWith(downloadListStatus: LibraryStatus.failure)),
            (right) => emit(state.copyWith(
                downloadListStatus: LibraryStatus.success,
                downloadList: right.podcastList)));
      }
    });
    on<GetUnreadNotificationEvent>((event, emit) async {
      emit(state.copyWith(unreadNotificationListStatus: LibraryStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await LibraryRepo().getUnreadNotification(token);
        result.fold(
            (left) => emit(state.copyWith(
                unreadNotificationListStatus: LibraryStatus.failure)),
            (right) => emit(state.copyWith(
                unreadNotificationListStatus: LibraryStatus.success,
                unreadNotificationList: right.data)));
      }
    });
  }
}
