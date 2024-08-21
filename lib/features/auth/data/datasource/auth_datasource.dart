import 'package:mahatacast/core/api/get_api.dart';
import 'package:mahatacast/core/api/get_with_token_api.dart';
import 'package:mahatacast/core/api/post_api.dart';
import 'package:mahatacast/core/api/post_api_with_token.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/features/auth/data/models/auth_response_model.dart';
import 'package:mahatacast/features/auth/data/models/content_response_model.dart';
import 'package:mahatacast/features/auth/data/models/logout_response_model.dart';

class AuthDataSource {
  Future<AuthResponseModel> regist(String name, String email, String password,
      String confirmPassword) async {
    final result = PostApi(
      uri: Uri.parse("$baseUri/api/register"),
      body: ({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword
      }),
      fromJson: authResponseModelFromJson,
    );
    return await result.call();
  }

  Future<AuthResponseModel> login(String email, String password) async {
    final result = PostApi(
      uri: Uri.parse("$baseUri/api/login"),
      body: ({
        'email': email,
        'password': password,
      }),
      fromJson: authResponseModelFromJson,
    );
    return await result.call();
  }

  Future<LogoutResponseModel> logout(String token) async {
    final result = PostApiWithToken(
        uri: Uri.parse("$baseUri/api/logout"),
        token: token,
        body: ({}),
        fromJson: logoutResponseModelFromJson);
    return await result.call();
  }

  Future<ContentResponseModel> getAllContent() async {
    final result = GetApi(
        uri: Uri.parse("$baseUri/api/show/all/content"),
        fromJson: contentResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ContentResponseModel> getUserContent(String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/show/user/home"),
        token: token,
        fromJson: contentResponseModelFromJson);
    return await result.callRequest();
  }

  Future<ContentResponseModel> selectContent(
      List<int> contentList, String token) async {
    final result = PostApiWithToken(
        uri: Uri.parse("$baseUri/api/contents/select"),
        token: token,
        body: ({
          'contentsIds': contentList,
        }),
        fromJson: contentResponseModelFromJson);
    return await result.call();
  }

  Future<void> sentNotificationToken(String id, String token) async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/api/sent/token?id=$id&token=$token"),
      fromJson: (json) {},
    );
    return await result.callRequest();
  }
}
