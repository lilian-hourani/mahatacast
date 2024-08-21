
import 'dart:convert';

AddPodcastToListen addPodcastToListenFromJson(String str) => AddPodcastToListen.fromJson(json.decode(str));

String addPodcastToListenToJson(AddPodcastToListen data) => json.encode(data.toJson());

class AddPodcastToListen {
    final String? status;
    final String? msg;
    final Data? data;

    AddPodcastToListen({
        this.status,
        this.msg,
        this.data,
    });

    factory AddPodcastToListen.fromJson(Map<String, dynamic> json) => AddPodcastToListen(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class Data {
    final int? userId;
    final String? podcastId;
    final String? listeningDuration;
    final dynamic rating;

    Data({
        this.userId,
        this.podcastId,
        this.listeningDuration,
        this.rating,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user id"],
        podcastId: json["podcast_id"],
        listeningDuration: json["listening_duration"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "user id": userId,
        "podcast_id": podcastId,
        "listening_duration": listeningDuration,
        "rating": rating,
    };
}
