
import 'dart:convert';

LogoutResponseModel logoutResponseModelFromJson(String str) => LogoutResponseModel.fromJson(json.decode(str));

String logoutResponseModelToJson(LogoutResponseModel data) => json.encode(data.toJson());

class LogoutResponseModel {
    final int? status;
    final String? msg;
    final List<dynamic>? data;

    LogoutResponseModel({
        this.status,
        this.msg,
        this.data,
    });

    factory LogoutResponseModel.fromJson(Map<String, dynamic> json) => LogoutResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    };
}
