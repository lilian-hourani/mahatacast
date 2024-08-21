import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/widgets/back_button.dart';

class PodcastAppBar extends StatelessWidget {
  const PodcastAppBar(
      {super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomBackButton(),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
    );
  }
}
