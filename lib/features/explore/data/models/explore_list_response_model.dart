
import 'dart:convert';

import 'package:mahatacast/features/home/data/models/podcast_model.dart';

ExploreListResponseModel exploreListResponseModelFromJson(String str) => ExploreListResponseModel.fromJson(json.decode(str));

String exploreListResponseModelToJson(ExploreListResponseModel data) => json.encode(data.toJson());

class ExploreListResponseModel {
    final int? status;
    final String? msg;
    final List<PodcastModel>? podcastList;

    ExploreListResponseModel({
        this.status,
        this.msg,
        this.podcastList,
    });

    factory ExploreListResponseModel.fromJson(Map<String, dynamic> json) => ExploreListResponseModel(
        status: json["status"],
        msg: json["msg"],
        podcastList: json["data"] == null ? [] : List<PodcastModel>.from(json["data"]!.map((x) => PodcastModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": podcastList == null ? [] : List<dynamic>.from(podcastList!.map((x) => x.toJson())),
    };
}

