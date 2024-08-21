
import 'dart:convert';

import 'package:mahatacast/features/home/data/models/podcast_model.dart';

SearchResponseModel searchResponseModelFromJson(String str) => SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) => json.encode(data.toJson());

class SearchResponseModel {
    final int? status;
    final String? msg;
    final List<PodcastModel>? resultList;

    SearchResponseModel({
        this.status,
        this.msg,
        this.resultList,
    });

    factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
        status: json["status"],
        msg: json["msg"],
        resultList: json["data"] == null ? [] : List<PodcastModel>.from(json["data"]!.map((x) => PodcastModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": resultList == null ? [] : List<dynamic>.from(resultList!.map((x) => x.toJson())),
    };
}

