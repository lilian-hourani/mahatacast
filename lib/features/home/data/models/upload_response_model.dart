
import 'dart:convert';

import 'package:mahatacast/features/home/data/models/podcast_model.dart';

UploadResponseModel uploadResponseModelFromJson(String str) => UploadResponseModel.fromJson(json.decode(str));

String uploadResponseModelToJson(UploadResponseModel data) => json.encode(data.toJson());

class UploadResponseModel {
    final int? status;
    final String? msg;
    final PodcastModel? podcastModel;

    UploadResponseModel({
        this.status,
        this.msg,
        this.podcastModel,
    });

    factory UploadResponseModel.fromJson(Map<String, dynamic> json) => UploadResponseModel(
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

