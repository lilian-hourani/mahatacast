
import 'dart:convert';

ContentResponseModel contentResponseModelFromJson(String str) => ContentResponseModel.fromJson(json.decode(str));

String contentResponseModelToJson(ContentResponseModel data) => json.encode(data.toJson());

class ContentResponseModel {
    final int? status;
    final String? msg;
    final List<Content>? contentList;

    ContentResponseModel({
        this.status,
        this.msg,
        this.contentList,
    });

    factory ContentResponseModel.fromJson(Map<String, dynamic> json) => ContentResponseModel(
        status: json["status"],
        msg: json["msg"],
        contentList: json["data"] == null ? [] : List<Content>.from(json["data"]!.map((x) => Content.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": contentList == null ? [] : List<dynamic>.from(contentList!.map((x) => x.toJson())),
    };
}

class Content {
    final int? contentId;
    final String? contentName;

    Content({
        this.contentId,
        this.contentName,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        contentId: json["content_id"],
        contentName: json["content_name"],
    );

    Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_name": contentName,
    };
}
