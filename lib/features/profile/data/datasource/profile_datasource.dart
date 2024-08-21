import 'package:mahatacast/core/api/get_with_token_api.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/features/profile/data/models/profile_response_model.dart';

class ProfileDataSource {
  Future<ProfileResponseModel> getProfileInfo(String token) async {
    final result = GetWithTokenApi(
        uri: Uri.parse("$baseUri/api/user/profile"),
        token: token,
        fromJson: profileResponseModelFromJson);
        return await result.callRequest();
  }
}
