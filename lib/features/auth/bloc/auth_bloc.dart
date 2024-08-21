import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/auth/data/models/auth_response_model.dart';
import 'package:mahatacast/features/auth/data/models/content_response_model.dart';
import 'package:mahatacast/features/auth/data/repositories/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<GetRegistEvent>((event, emit) async {
      emit(state.copyWith(authModelStatus: AuthStatus.loading));
      final result = await AuthRepo().getRegist(
          event.name, event.email, event.password, event.confirmPassword);
      result.fold((left) {
        emit(state.copyWith(authModelStatus: AuthStatus.authFailed));
      }, (right) {
        emit(state.copyWith(
            authModel: right.data, authModelStatus: AuthStatus.authSuccess));
      });
    });
    on<GetLoginEvent>((event, emit) async {
      emit(state.copyWith(authModelStatus: AuthStatus.loading));
      final result = await AuthRepo().getLogin(event.email, event.password);
      result.fold((left) {
        emit(state.copyWith(authModelStatus: AuthStatus.authFailed));
      }, (right) {
        emit(state.copyWith(
            authModel: right.data, authModelStatus: AuthStatus.authSuccess));
      });
    });
    on<GetLogoutEvent>((event, emit) async {
      emit(state.copyWith(authModelStatus: AuthStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await AuthRepo().getLogout(token);
        result.fold((left) {}, (right) {
          emit(state.copyWith(authModelStatus: AuthStatus.authFailed));
        });
      }
    });
    on<CheckAuthEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final isFirst = prefs.getBool('firstTime');
      if (isFirst != null) {
        final token = prefs.getString('token');
        if (token != null) {
          emit(state.copyWith(authModelStatus: AuthStatus.authSuccess));
        } else {
          emit(state.copyWith(authModelStatus: AuthStatus.authFailed));
        }
      } else {
        emit(state.copyWith(authModelStatus: AuthStatus.intro));
      }
    });
    on<GetNotificationTokenEvent>((event, emit) async {
      final String? token = await ServiceFunctions.getUserToken();
      final String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (token != null && fcmToken != null) {
        final result =
            await AuthRepo().sentNotificationToken(token[0], fcmToken);
        result.fold((left) {
          print(" did not added");
        }, (right) {
          print(fcmToken);
          print(token[0]);
          print("added");
        });
      }
    });
    on<GetAllContentEvent>((event, emit) async {
      emit(state.copyWith(contentListStatus: AuthStatus.loading));
      final result = await AuthRepo().getAllContent();
      result.fold((left) {
        emit(state.copyWith(contentListStatus: AuthStatus.getFailed));
      }, (right) {
        emit(state.copyWith(
            contentList: right.contentList!,
            contentListStatus: AuthStatus.getSuccess));
      });
    });
    on<GetContentNum>((event, emit) async {
      emit(state.copyWith(contentListStatus: AuthStatus.loading));
      final result = await AuthRepo().getAllContent();
      result.fold((left) {}, (right) {
        emit(state.copyWith(contentNum: right.contentList!.length));
      });
    });
    on<SelectContentEvent>((event, emit) async {
      emit(state.copyWith(selectContentStatus: AuthStatus.loading));
      final String? token = await ServiceFunctions.getUserToken();
      if (token != null) {
        final result = await AuthRepo().selectContent(event.contentIds, token);
        result.fold(
            (left) => emit(
                state.copyWith(selectContentStatus: AuthStatus.selectFailed)),
            (right) => emit(state.copyWith(
                selectContentStatus: AuthStatus.selectSuccess,
                contentNum: event.contentIds.length)));
      }
    });
    on<CheckSelectEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final isSelect = prefs.getBool('select');
      if (isSelect != null) {
        if (isSelect) {
          emit(state.copyWith(selectContentStatus: AuthStatus.selectSuccess));
        } else {
          emit(state.copyWith(selectContentStatus: AuthStatus.selectFailed));
        }
      } else {
        emit(state.copyWith(authModelStatus: AuthStatus.intro));
      }
    });
  }
}
