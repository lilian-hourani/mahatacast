
import 'dart:convert';

ShowFollowedChannelModel showFollowedChannelModelFromJson(String str) => ShowFollowedChannelModel.fromJson(json.decode(str));

String showFollowedChannelModelToJson(ShowFollowedChannelModel data) => json.encode(data.toJson());

class ShowFollowedChannelModel {
    final int? status;
    final String? msg;
    final List<ChannelModel>? channelList;

    ShowFollowedChannelModel({
        this.status,
        this.msg,
        this.channelList,
    });

    factory ShowFollowedChannelModel.fromJson(Map<String, dynamic> json) => ShowFollowedChannelModel(
        status: json["status"],
        msg: json["msg"],
        channelList: json["data"] == null ? [] : List<ChannelModel>.from(json["data"]!.map((x) => ChannelModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": channelList == null ? [] : List<dynamic>.from(channelList!.map((x) => x.toJson())),
    };
}

class ChannelModel {
    final int? id;
    final String? channelName;
    final String? channelImage;
    final String? description;
    final int? channelOwnerId;
    final int? channelFollowersNumber;

    ChannelModel({
        this.id,
        this.channelName,
        this.channelImage,
        this.description,
        this.channelOwnerId,
        this.channelFollowersNumber,
    });

    factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
        id: json["id"],
        channelName: json["channel_name"],
        channelImage: json["channel_image"],
        description: json["description"],
        channelOwnerId: json["channel_owner_id"],
        channelFollowersNumber: json["channel followers number"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "channel_name": channelName,
        "channel_image": channelImage,
        "description": description,
        "channel_owner_id": channelOwnerId,
        "channel followers number": channelFollowersNumber,
    };
}
