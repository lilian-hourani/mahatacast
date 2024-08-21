import 'package:dartz/dartz.dart';
import 'package:mahatacast/core/api/failures.dart';
import 'package:mahatacast/core/api/handling_exception_manager.dart';
import 'package:mahatacast/features/profile/data/datasource/profile_datasource.dart';
import 'package:mahatacast/features/profile/data/models/profile_response_model.dart';

class ProfileRepo with HandlingExceptionManager {
  Future<Either<Failure,ProfileResponseModel>> getProfileInfo(String token){
    return wrapHandling(tryCall: () async {
      final result = await ProfileDataSource().getProfileInfo(token);
      return  Right(result);
    },);
  }
}