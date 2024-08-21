part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authSuccess,
  authFailed,
  getSuccess,
  getFailed,
  selectSuccess,
  selectFailed,
  intro
}

class AuthState {
  AuthStatus authModelStatus;
  AuthModel? authModel;
  String? msg;
  AuthStatus contentListStatus;
  final List<Content> contentList;
  final int contentNum;
  AuthStatus selectContentStatus;
  AuthStatus sendTokenStatus;
  AuthState({
    this.authModelStatus = AuthStatus.initial,
    this.authModel,
    this.msg,
    this.contentListStatus = AuthStatus.initial,
    this.contentList = const [],
    this.contentNum = 0,
    this.selectContentStatus = AuthStatus.initial,
    this.sendTokenStatus = AuthStatus.initial
  });

  AuthState copyWith({
    AuthStatus? authModelStatus,
    AuthModel? authModel,
    String? msg,
    AuthStatus? contentListStatus,
    List<Content>? contentList,
    int? contentNum,
    AuthStatus? selectContentStatus,
    AuthStatus? sendTokenStatus,
  }) {
    return AuthState(
      authModelStatus: authModelStatus ?? this.authModelStatus,
      authModel: authModel ?? this.authModel,
      msg: msg ?? this.msg,
      contentListStatus: contentListStatus ?? this.contentListStatus,
      contentList: contentList ?? this.contentList,
      contentNum: contentNum ?? this.contentNum,
      selectContentStatus: selectContentStatus ?? this.selectContentStatus,
      sendTokenStatus: sendTokenStatus ?? this.sendTokenStatus,
    );
  }
}
