import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';

class LoadingPodcastBox extends StatelessWidget {
  const LoadingPodcastBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 12),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: lightestGreyColor,
                  borderRadius: BorderRadius.circular(12)),
              width: .5.sw,
              height: .2.sh,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                    duration: 1200.ms, color: Colors.grey[100], angle: 120),
          ],
        ),
        SizedBox(
          width: .5.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
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
                  10.verticalSpace,
                  Container(
                    width: 50,
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
              ),
              SizedBox(
                width: 30,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: SvgPicture.asset(
                    "assets/icons/home/upload_cerli.svg",
                    width: 15,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
