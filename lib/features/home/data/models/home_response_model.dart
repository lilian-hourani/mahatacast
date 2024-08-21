
import 'dart:convert';

import 'package:mahatacast/features/home/data/models/podcast_model.dart';

HomeResponseModel homeResponseModelFromJson(String str) => HomeResponseModel.fromJson(json.decode(str));

String homeResponseModelToJson(HomeResponseModel data) => json.encode(data.toJson());

class HomeResponseModel {
    final int? status;
    final String? msg;
    final List<PodcastModel>? podcastList;

    HomeResponseModel({
        this.status,
        this.msg,
        this.podcastList,
    });

    factory HomeResponseModel.fromJson(Map<String, dynamic> json) => HomeResponseModel(
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


