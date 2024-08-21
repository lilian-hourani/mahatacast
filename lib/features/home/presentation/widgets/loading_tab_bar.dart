import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mahatacast/core/constants/colors.dart';

class LoadingTabBar extends StatelessWidget {
  const LoadingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(left: 5),
            width: 60,
            height: 20,
            decoration: BoxDecoration(
                color: lightestGreyColor,
                borderRadius: BorderRadius.circular(20)),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shimmer(duration: 1200.ms, color: Colors.grey[100], angle: 120),
        ));
  }
}
