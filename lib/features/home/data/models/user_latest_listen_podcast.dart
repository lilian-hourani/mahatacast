
import 'dart:convert';

import 'package:mahatacast/features/home/data/models/podcast_model.dart';

UserLatestListenPodcast userLatestListenPodcastFromJson(String str) => UserLatestListenPodcast.fromJson(json.decode(str));

String userLatestListenPodcastToJson(UserLatestListenPodcast data) => json.encode(data.toJson());

class UserLatestListenPodcast {
    final int? status;
    final String? msg;
    final PodcastModel? podcastModel;

    UserLatestListenPodcast({
        this.status,
        this.msg,
        this.podcastModel,
    });

    factory UserLatestListenPodcast.fromJson(Map<String, dynamic> json) => UserLatestListenPodcast(
        status: json["status"],
        msg: json["msg"],
        podcastModel: json["data"] == null ? null : PodcastModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": podcastModel?.toJson(),
    };
}

