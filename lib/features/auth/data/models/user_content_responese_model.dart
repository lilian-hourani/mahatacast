import 'dart:convert';

import 'package:mahatacast/features/auth/data/models/content_response_model.dart';

UserContentResponseModel userContantResponseModelFromJson(String str) => UserContentResponseModel.fromJson(json.decode(str));

String userContantResponseModelToJson(UserContentResponseModel data) => json.encode(data.toJson());

class UserContentResponseModel {
    final int? status;
    final String? msg;
    final List<Content>? userContentList;

    UserContentResponseModel({
        this.status,
        this.msg,
        this.userContentList,
    });

    factory UserContentResponseModel.fromJson(Map<String, dynamic> json) => UserContentResponseModel(
        status: json["status"],
        msg: json["msg"],
        userContentList: json["data"] == null ? [] : List<Content>.from(json["data"]!.map((x) => Content.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": userContentList == null ? [] : List<dynamic>.from(userContentList!.map((x) => x.toJson())),
    };
}