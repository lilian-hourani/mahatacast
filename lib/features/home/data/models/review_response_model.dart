
import 'dart:convert';

ReviewResponseModel reviewResponseModelFromJson(String str) => ReviewResponseModel.fromJson(json.decode(str));

String reviewResponseModelToJson(ReviewResponseModel data) => json.encode(data.toJson());

class ReviewResponseModel {
    final String? status;
    final String? msg;
    final ReviewModel? data;

    ReviewResponseModel({
        this.status,
        this.msg,
        this.data,
    });

    factory ReviewResponseModel.fromJson(Map<String, dynamic> json) => ReviewResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReviewModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class ReviewModel {
    final int? ratingId;
    final String? rating;
    final String? comment;

    ReviewModel({
        this.ratingId,
        this.rating,
        this.comment,
    });

    factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        ratingId: json["rating id"],
        rating: json["rating"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "rating id": ratingId,
        "rating": rating,
        "comment": comment,
    };
}
