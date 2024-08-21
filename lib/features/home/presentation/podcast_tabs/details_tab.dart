import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab(
      {super.key, required this.description, required this.channelName});
  final String channelName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            channelName,
            style: TextStyle(
                color: const Color(0xff484848),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: .03.sh,
          ),
          Text(
            description,
            style: TextStyle(color: greyColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
