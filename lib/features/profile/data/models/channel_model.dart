
import 'dart:convert';

ChannelResponseModel channelResponseModelFromJson(String str) => ChannelResponseModel.fromJson(json.decode(str));

String channelResponseModelToJson(ChannelResponseModel data) => json.encode(data.toJson());

class ChannelResponseModel {
    final int? status;
    final String? msg;
    final UserChannelModel? channel;

    ChannelResponseModel({
        this.status,
        this.msg,
        this.channel,
    });

    factory ChannelResponseModel.fromJson(Map<String, dynamic> json) => ChannelResponseModel(
        status: json["status"],
        msg: json["msg"],
        channel: json["data"] == null ? null : UserChannelModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": channel?.toJson(),
    };
}

class UserChannelModel {
    final int? id;
    final String? channelName;
    final String? channelImage;
    final String? description;
    final int? channelOwnerId;
    final int? channelApprove;

    UserChannelModel({
        this.id,
        this.channelName,
        this.channelImage,
        this.description,
        this.channelOwnerId,
        this.channelApprove,
    });

    factory UserChannelModel.fromJson(Map<String, dynamic> json) => UserChannelModel(
        id: json["id"],
        channelName: json["channel_name"],
        channelImage: json["channel_image"],
        description: json["description"],
        channelOwnerId: json["channel_owner_id"],
        channelApprove: json["channel_approve"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "channel_name": channelName,
        "channel_image": channelImage,
        "description": description,
        "channel_owner_id": channelOwnerId,
        "channel_approve": channelApprove,
    };
}

