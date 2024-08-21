
import 'dart:convert';

CommentResponseModel commentResponseModelFromJson(String str) => CommentResponseModel.fromJson(json.decode(str));

String commentResponseModelToJson(CommentResponseModel data) => json.encode(data.toJson());

class CommentResponseModel {
    final int? status;
    final String? msg;
    final List<CommentModel>? commentsList;

    CommentResponseModel({
        this.status,
        this.msg,
        this.commentsList,
    });

    factory CommentResponseModel.fromJson(Map<String, dynamic> json) => CommentResponseModel(
        status: json["status"],
        msg: json["msg"],
        commentsList: json["data"] == null ? [] : List<CommentModel>.from(json["data"]!.map((x) => CommentModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": commentsList == null ? [] : List<dynamic>.from(commentsList!.map((x) => x.toJson())),
    };
}

class CommentModel {
    final String? commentWriter;
    final String? comment;
    final DateTime? commentDate;

    CommentModel({
        this.commentWriter,
        this.comment,
        this.commentDate,
    });

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentWriter: json["comment writer"],
        comment: json["comment"],
        commentDate: json["comment date"] == null ? null : DateTime.parse(json["comment date"]),
    );

    Map<String, dynamic> toJson() => {
        "comment writer": commentWriter,
        "comment": comment,
        "comment date": commentDate?.toIso8601String(),
    };
}
