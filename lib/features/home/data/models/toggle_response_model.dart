
import 'dart:convert';

ToggleResponseModel toggleResponseModelFromJson(String str) => ToggleResponseModel.fromJson(json.decode(str));

String toggleResponseModelToJson(ToggleResponseModel data) => json.encode(data.toJson());

class ToggleResponseModel {
    final int? status;
    final String? msg;
    final List<dynamic>? data;

    ToggleResponseModel({
        this.status,
        this.msg,
        this.data,
    });

    factory ToggleResponseModel.fromJson(Map<String, dynamic> json) => ToggleResponseModel(
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
