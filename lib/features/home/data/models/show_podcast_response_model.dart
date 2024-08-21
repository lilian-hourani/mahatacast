
import 'dart:convert';

import 'package:mahatacast/features/home/data/models/podcast_model.dart';

ShowPodcastResponseModel showPodcastResponseModelFromJson(String str) => ShowPodcastResponseModel.fromJson(json.decode(str));

String showPodcastResponseModelToJson(ShowPodcastResponseModel data) => json.encode(data.toJson());

class ShowPodcastResponseModel {
    final int? status;
    final String? msg;
    final PodcastModel? data;

    ShowPodcastResponseModel({
        this.status,
        this.msg,
        this.data,
    });

    factory ShowPodcastResponseModel.fromJson(Map<String, dynamic> json) => ShowPodcastResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : PodcastModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
    };
}

