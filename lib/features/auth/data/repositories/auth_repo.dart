import 'package:dartz/dartz.dart';
import 'package:mahatacast/core/api/failures.dart';
import 'package:mahatacast/core/api/handling_exception_manager.dart';
import 'package:mahatacast/features/auth/data/datasource/auth_datasource.dart';
import 'package:mahatacast/features/auth/data/models/auth_response_model.dart';
import 'package:mahatacast/features/auth/data/models/content_response_model.dart';
import 'package:mahatacast/features/auth/data/models/logout_response_model.dart';

class AuthRepo with HandlingExceptionManager {
  Future<Either<Failure, AuthResponseModel>> getRegist(
      String name, String email, String password, String confirmPassword) {
    return wrapHandling(tryCall: () async {
      final result =
          await AuthDataSource().regist(name, email, password, confirmPassword);
      return Right(result);
    });
  }

  Future<Either<Failure, AuthResponseModel>> getLogin(
      String email, String password) {
    return wrapHandling(tryCall: () async {
      final result = await AuthDataSource().login(email, password);
      return Right(result);
    });
  }

  Future<Either<Failure, LogoutResponseModel>> getLogout(String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await AuthDataSource().logout(token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ContentResponseModel>> getAllContent() {
    return wrapHandling(
      tryCall: () async {
        final result = await AuthDataSource().getAllContent();
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ContentResponseModel>> getUserContent(
      String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await AuthDataSource().getUserContent(token);
        return Right(result);
      },
    );
  }

  Future<Either<Failure, ContentResponseModel>> selectContent(
      List<int> contentList, String token) {
    return wrapHandling(tryCall: () async {
      final result = await AuthDataSource().selectContent(contentList, token);
      return Right(result);
    });
  }

  Future<Either<Failure, void>> sentNotificationToken(String id, String token) {
    return wrapHandling(
      tryCall: () async {
        final result = await AuthDataSource().sentNotificationToken(id, token);
        return Right(result);
      },
    );
  }
}
