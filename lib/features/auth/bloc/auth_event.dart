part of 'auth_bloc.dart';

class AuthEvent {}

class GetRegistEvent extends AuthEvent {
  final String name, email, password, confirmPassword;
  GetRegistEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class GetLoginEvent extends AuthEvent {
  final String email;
  final String password;
  GetLoginEvent({
    required this.email,
    required this.password,
  });
}

class GetLogoutEvent extends AuthEvent{}

class CheckAuthEvent extends AuthEvent{}

class GetNotificationTokenEvent extends AuthEvent{}

class GetAllContentEvent extends AuthEvent {}

class GetContentNum extends AuthEvent{}

class SelectContentEvent extends AuthEvent {
  List<int> contentIds;
  SelectContentEvent({
    required this.contentIds,
  });
}
class CheckSelectEvent extends AuthEvent{}

