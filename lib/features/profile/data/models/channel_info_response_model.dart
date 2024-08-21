// To parse this JSON data, do
//
//     final channelInfoResponseModel = channelInfoResponseModelFromJson(jsonString);

import 'dart:convert';

ChannelInfoResponseModel channelInfoResponseModelFromJson(String str) => ChannelInfoResponseModel.fromJson(json.decode(str));

String channelInfoResponseModelToJson(ChannelInfoResponseModel data) => json.encode(data.toJson());

class ChannelInfoResponseModel {
    final int? status;
    final String? msg;
    final ChannelInfo? data;

    ChannelInfoResponseModel({
        this.status,
        this.msg,
        this.data,
    });

    factory ChannelInfoResponseModel.fromJson(Map<String, dynamic> json) => ChannelInfoResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : ChannelInfo.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class ChannelInfo {
    final int? id;
    final String? channelName;
    final String? channelImage;
    final String? description;
    final int? channelOwnerId;
    final int? channelFollowersNumber;
    final int? channelApprove;

    ChannelInfo({
        this.id,
        this.channelName,
        this.channelImage,
        this.description,
        this.channelOwnerId,
        this.channelFollowersNumber,
        this.channelApprove,
    });

    factory ChannelInfo.fromJson(Map<String, dynamic> json) => ChannelInfo(
        id: json["id"],
        channelName: json["channel_name"],
        channelImage: json["channel_image"],
        description: json["description"],
        channelOwnerId: json["channel_owner_id"],
        channelFollowersNumber: json["channel followers number"],
        channelApprove: json["channel_approve"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "channel_name": channelName,
        "channel_image": channelImage,
        "description": description,
        "channel_owner_id": channelOwnerId,
        "channel followers number": channelFollowersNumber,
        "channel_approve": channelApprove,
    };
}
