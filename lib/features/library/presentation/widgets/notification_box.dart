import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/library/data/models/notification_response_model.dart';
import 'package:mahatacast/generated/l10n.dart';

class NotificationBox extends StatelessWidget {
  const NotificationBox({super.key, required this.notificationModel});
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                  height: 70,
                  width: 80,
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                        "assets/images/laoding.png",
                      ),
                      image: NetworkImage(
                          "$assetUri${notificationModel.channelImage}")))),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: .6.sw,
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: S.of(context).TheChannel,
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: "${notificationModel.channelName}",
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: S.of(context).UploadedFollowingPodcast,
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: "${notificationModel.podcastTitle}",
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ])),
              ),
              5.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/home/clock.svg",
                    color: lightGreyColor,
                  ),
                  3.horizontalSpace,
                  Text(
                    "${notificationModel.createdAt}",
                    style: TextStyle(color: lightGreyColor, fontSize: 11.sp),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
