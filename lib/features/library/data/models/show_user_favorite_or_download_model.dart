
import 'dart:convert';

import 'package:mahatacast/features/home/data/models/podcast_model.dart';

ShowUserListResponseModel showUserListResponseModelFromJson(String str) => ShowUserListResponseModel.fromJson(json.decode(str));

String showUserListResponseModelToJson(ShowUserListResponseModel data) => json.encode(data.toJson());

class ShowUserListResponseModel {
    final int? status;
    final String? msg;
    final List<PodcastModel>? podcastList;

    ShowUserListResponseModel({
        this.status,
        this.msg,
        this.podcastList,
    });

    factory ShowUserListResponseModel.fromJson(Map<String, dynamic> json) => ShowUserListResponseModel(
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

