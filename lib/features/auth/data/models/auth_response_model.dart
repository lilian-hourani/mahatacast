

import 'dart:convert';

AuthResponseModel authResponseModelFromJson(String str) => AuthResponseModel.fromJson(json.decode(str));

String authResponseModelToJson(AuthResponseModel data) => json.encode(data.toJson());

class AuthResponseModel {
    final int? status;
    final String? msg;
    final AuthModel? data;

    AuthResponseModel({
        this.status,
        this.msg,
        this.data,
    });

    factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : AuthModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class AuthModel {
    final String? token;
    final String? name;
    final String? email;

    AuthModel({
        this.token,
        this.name,
        this.email,
    });

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "email": email,
    };
}
