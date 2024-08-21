part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, created, success, failed }

class ProfileState {
  ProfileModel? profileModel;
  ProfileStatus profileStatus;
  ProfileState({
   this.profileModel,
   this.profileStatus = ProfileStatus.initial,
  });

  ProfileState copyWith({
    ProfileModel? profileModel,
    ProfileStatus? profileStatus,
  }) {
    return ProfileState(
      profileModel: profileModel ?? this.profileModel,
      profileStatus: profileStatus ?? this.profileStatus,
    );
  }
}
