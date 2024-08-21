import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';

class LoadingUserChannel extends StatelessWidget {
  const LoadingUserChannel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: .25.sh,
          width: .75.sw,
          decoration: BoxDecoration(
              color: lightestGreyColor,
              borderRadius: BorderRadius.circular(20)),
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .shimmer(duration: 1200.ms, color: Colors.grey[100], angle: 120),
        SizedBox(
          height: .02.sh,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: .2.sw),
          child: Container(
            width: 90,
            height: 12,
            decoration: BoxDecoration(
                color: lightestGreyColor,
                borderRadius: BorderRadius.circular(40)),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shimmer(duration: 1200.ms, color: Colors.grey[100], angle: 120),
        ),
        SizedBox(
          height: .03.sh,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "90",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Following",
                  style: TextStyle(
                      color: greyColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 30,
              child: VerticalDivider(
                color: lightestGreyColor,
                thickness: 2,
              ),
            ),
            Column(
              children: [
                Text(
                  "90",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Followers",
                  style: TextStyle(
                      color: greyColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 30,
              child: VerticalDivider(
                color: lightestGreyColor,
                thickness: 2,
              ),
            ),
            Column(
              children: [
                Text(
                  "90",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Download",
                  style: TextStyle(
                      color: greyColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: .03.sh,
        ),
      ],
    );
  }
}
