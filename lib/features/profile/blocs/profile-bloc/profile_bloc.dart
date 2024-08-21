import 'package:bloc/bloc.dart';
import 'package:mahatacast/features/profile/data/models/profile_response_model.dart';
import 'package:mahatacast/features/profile/data/repositories/profile_repo.dart';
import 'package:mahatacast/services/service_fun.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<GetProfileInfoEvent>((event, emit) async {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await ProfileRepo().getProfileInfo(token);
        result.fold(
            (left) => emit(state.copyWith(profileStatus: ProfileStatus.failed)),
            (right) => emit(state.copyWith(
                profileStatus: ProfileStatus.success,
                profileModel: right.profileModel)));
      }
    });
  }
}
