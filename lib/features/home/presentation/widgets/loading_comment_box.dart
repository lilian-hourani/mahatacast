import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';

class LoadingCommentBox extends StatelessWidget {
  const LoadingCommentBox({super.key});

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
                decoration: BoxDecoration(
                    color: lightestGreyColor, shape: BoxShape.circle),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(
                      duration: 1200.ms, color: Colors.grey[100], angle: 120),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 10,
                    decoration: BoxDecoration(
                        color: lightestGreyColor,
                        borderRadius: BorderRadius.circular(40)),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .shimmer(
                          duration: 1200.ms,
                          color: Colors.grey[100],
                          angle: 120),
                  5.verticalSpace,
                  Container(
                    width: 90,
                    height: 10,
                    decoration: BoxDecoration(
                        color: lightestGreyColor,
                        borderRadius: BorderRadius.circular(40)),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .shimmer(
                          duration: 1200.ms,
                          color: Colors.grey[100],
                          angle: 120),
                ],
              )
            ],
          ),
          12.verticalSpace,
          SizedBox(
            width: .8.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 10,
                  decoration: BoxDecoration(
                      color: lightestGreyColor,
                      borderRadius: BorderRadius.circular(40)),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .shimmer(
                        duration: 1200.ms, color: Colors.grey[100], angle: 120),
                5.verticalSpace,
                Container(
                  width: 250,
                  height: 10,
                  decoration: BoxDecoration(
                      color: lightestGreyColor,
                      borderRadius: BorderRadius.circular(40)),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .shimmer(
                        duration: 1200.ms, color: Colors.grey[100], angle: 120),
              ],
            ),
          )
        ],
      ),
    );
  }
}
