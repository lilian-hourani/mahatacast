
import 'dart:convert';

import 'package:mahatacast/features/home/data/models/podcast_model.dart';

ChannelPodcastResponseModel channelPodcastResponseModelFromJson(String str) => ChannelPodcastResponseModel.fromJson(json.decode(str));

String channelPodcastResponseModelToJson(ChannelPodcastResponseModel data) => json.encode(data.toJson());

class ChannelPodcastResponseModel {
    final int? status;
    final String? msg;
    final List<PodcastModel>? data;

    ChannelPodcastResponseModel({
        this.status,
        this.msg,
        this.data,
    });

    factory ChannelPodcastResponseModel.fromJson(Map<String, dynamic> json) => ChannelPodcastResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<PodcastModel>.from(json["data"]!.map((x) => PodcastModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

