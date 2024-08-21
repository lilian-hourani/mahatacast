import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/profile/presentation/widgets/channel_app_bar.dart';

class LoadingPodcastPLayerPage extends StatelessWidget {
  const LoadingPodcastPLayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const ChannelAppBar(
              title: "Podcast Player",
            ),
            12.verticalSpace,
            Container(
              width: .75.sw,
              height: .35.sh,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: lightestGreyColor),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                    duration: 1200.ms, color: Colors.grey[100], angle: 120),
            20.verticalSpace,
            Container(
              width: 270,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: lightestGreyColor,
                  borderRadius: BorderRadius.circular(25)),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                    duration: 1200.ms, color: Colors.grey[100], angle: 120),
            30.verticalSpace,
            Container(
              width: 150,
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
            10.verticalSpace,
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
                    duration: 1200.ms, color: Colors.grey[100], angle: 120),
            90.verticalSpace,
            Container(
              width: 350,
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
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    child: SvgPicture.asset("assets/icons/home/message.svg")),
                GestureDetector(
                  child: SvgPicture.asset(
                      "assets/icons/home/backward_10_seconds.svg"),
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
                GestureDetector(
                  child: SvgPicture.asset(
                      "assets/icons/home/forward_10_seconds.svg"),
                ),
                const Text("1.0x")
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
