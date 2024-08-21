import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';

class LoadindRecntlyPlaying extends StatelessWidget {
  const LoadindRecntlyPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: .03.sh,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: .2.sw,
                height: .08.sh,
                decoration: BoxDecoration(
                    color: lightestGreyColor,
                    borderRadius: BorderRadius.circular(10)),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(
                      duration: 1200.ms, color: Colors.grey[100], angle: 120),
              SizedBox(
                width: .01.sh,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          duration: 1200.ms,
                          color: Colors.grey[100],
                          angle: 120),
                  10.verticalSpace,
                  Container(
                    width: 80,
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
            ],
          ),
        ],
      ),
    );
  }
}
