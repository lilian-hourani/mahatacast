
import 'dart:convert';

TagResponseModel tagResponseModelFromJson(String str) => TagResponseModel.fromJson(json.decode(str));

String tagResponseModelToJson(TagResponseModel data) => json.encode(data.toJson());

class TagResponseModel {
    final int? status;
    final String? msg;
    final List<Tag>? tagList;

    TagResponseModel({
        this.status,
        this.msg,
        this.tagList,
    });

    factory TagResponseModel.fromJson(Map<String, dynamic> json) => TagResponseModel(
        status: json["status"],
        msg: json["msg"],
        tagList: json["data"] == null ? [] : List<Tag>.from(json["data"]!.map((x) => Tag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": tagList == null ? [] : List<dynamic>.from(tagList!.map((x) => x.toJson())),
    };
}

class Tag {
    final int? tagId;
    final String? tagName;

    Tag({
        this.tagId,
        this.tagName,
    });

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        tagId: json["tag_id"],
        tagName: json["tag_name"],
    );

    Map<String, dynamic> toJson() => {
        "tag_id": tagId,
        "tag_name": tagName,
    };
}
