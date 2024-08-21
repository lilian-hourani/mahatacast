import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';

class LoadingPodcastDetails extends StatelessWidget {
  const LoadingPodcastDetails({super.key});

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
          padding: EdgeInsets.symmetric(horizontal: .1.sw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 90,
                height: 12,
                decoration: BoxDecoration(
                    color: lightestGreyColor,
                    borderRadius: BorderRadius.circular(40)),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(
                      duration: 1200.ms, color: Colors.grey[100], angle: 120),
              Row(
                children: [
                  SizedBox(
                    width: .02.sw,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 12,
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
                      SvgPicture.asset(
                        "assets/icons/home/follower.svg",
                        color: greyColor,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: .03.sh,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
                backgroundColor: lightestGreyColor,
                child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/home/share.svg",
                      color: greyColor,
                    ))),
            ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(.4.sw, .06.sh),
                        backgroundColor: lightestGreyColor),
                    onPressed: () {},
                    child: const SizedBox())
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                    duration: 1200.ms, color: Colors.grey[100], angle: 120),
            CircleAvatar(
                backgroundColor: lightestGreyColor,
                child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/home/download.svg",
                      color: greyColor,
                    ))),
          ],
        ),
        SizedBox(
          height: .02.sh,
        ),
      ],
    );
  }
}
