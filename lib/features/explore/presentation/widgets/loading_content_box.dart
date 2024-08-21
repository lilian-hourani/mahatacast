import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/explore/presentation/widgets/loading_podcast_box.dart';

class LoadingContentBox extends StatelessWidget {
  const LoadingContentBox({super.key, required this.contentTitle});
  final String contentTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: .02.sh),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                contentTitle,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
              Text(
                "See all",
                style: TextStyle(
                    color: purpleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp),
              ),
            ],
          ),
        ),
        SizedBox(
          height: .26.sh,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const LoadingPodcastBox();
            },
          ),
        ),
        SizedBox(
          height: .03.sh,
        )
      ],
    );
  }
}
