import 'dart:convert';

ProfileResponseModel profileResponseModelFromJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) => json.encode(data.toJson());

class ProfileResponseModel {
    final int? status;
    final String? msg;
    final ProfileModel? profileModel;

    ProfileResponseModel({
        this.status,
        this.msg,
        this.profileModel,
    });

    factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
        status: json["status"],
        msg: json["msg"],
        profileModel: json["data"] == null ? null : ProfileModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": profileModel?.toJson(),
    };
}

class ProfileModel {
    final int? userId;
    final String? userName;
    final String? userEmail;

    ProfileModel({
        this.userId,
        this.userName,
        this.userEmail,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userId: json["user id"],
        userName: json["user name"],
        userEmail: json["user email"],
    );

    Map<String, dynamic> toJson() => {
        "user id": userId,
        "user name": userName,
        "user email": userEmail,
    };
}
