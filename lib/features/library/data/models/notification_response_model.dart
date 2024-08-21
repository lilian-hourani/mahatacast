import 'dart:convert';

NotificationResponseModel notificationResponseModelFromJson(String str) => NotificationResponseModel.fromJson(json.decode(str));

String notificationResponseModelToJson(NotificationResponseModel data) => json.encode(data.toJson());

class NotificationResponseModel {
    final List<NotificationModel>? data;

    NotificationResponseModel({
        this.data,
    });

    factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
        data: json["data"] == null ? [] : List<NotificationModel>.from(json["data"]!.map((x) => NotificationModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class NotificationModel {
    final int? podcastId;
    final String? podcastTitle;
    final String? channelName;
    final String? channelImage;
    final DateTime? createdAt;

    NotificationModel({
        this.podcastId,
        this.podcastTitle,
        this.channelName,
        this.channelImage,
        this.createdAt,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        podcastId: json["podcast_id"],
        podcastTitle: json["podcast_title"],
        channelName: json["channel_name"],
        channelImage: json["channel_image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "podcast_id": podcastId,
        "podcast_title": podcastTitle,
        "channel_name": channelName,
        "channel_image": channelImage,
        "created_at": createdAt?.toIso8601String(),
    };
}
