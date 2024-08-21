import 'dart:convert';

UpdateChannelImageResponseModel updateChannelImageResponseModelFromJson(String str) => UpdateChannelImageResponseModel.fromJson(json.decode(str));

String updateChannelImageResponseModelToJson(UpdateChannelImageResponseModel data) => json.encode(data.toJson());

class UpdateChannelImageResponseModel {
    final int? status;
    final String? msg;
    final List<dynamic>? data;

    UpdateChannelImageResponseModel({
        this.status,
        this.msg,
        this.data,
    });

    factory UpdateChannelImageResponseModel.fromJson(Map<String, dynamic> json) => UpdateChannelImageResponseModel(
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
