import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/home/data/models/comment_response_model.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key, required this.comment});
  final CommentModel comment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration:
                    const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.commentWriter!,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
                  ),
                  Text(
                    ServiceFunctions.formatDate(comment.commentDate!),
                    style: TextStyle(
                        color: lightGreyColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp),
                  ),
                ],
              )
            ],
          ),
          12.verticalSpace,
              SizedBox(
                width: .8.sw,
                child: Text(
                  comment.comment!,
                  style: TextStyle(
                      color: greyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp),
                ),
              )
        ],
      ),
    );
  }
}
