
import 'dart:convert';

ChannelDescriptionResponseModel channelDescriptionResponseModelFromJson(String str) => ChannelDescriptionResponseModel.fromJson(json.decode(str));

String channelDescriptionResponseModelToJson(ChannelDescriptionResponseModel data) => json.encode(data.toJson());

class ChannelDescriptionResponseModel {
    final int? status;
    final String? msg;
    final String? description;

    ChannelDescriptionResponseModel({
        this.status,
        this.msg,
        this.description,
    });

    factory ChannelDescriptionResponseModel.fromJson(Map<String, dynamic> json) => ChannelDescriptionResponseModel(
        status: json["status"],
        msg: json["msg"],
        description: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": description,
    };
}
