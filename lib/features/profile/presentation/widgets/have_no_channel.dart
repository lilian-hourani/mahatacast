import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/profile/presentation/pages/create_channel_page.dart';
import 'package:mahatacast/generated/l10n.dart';

class HaveNoChannel extends StatelessWidget {
  const HaveNoChannel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).youhavenoChannel,
          style: TextStyle(
              color: darkGrey, fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        15.verticalSpace,
        Text(
          S.of(context).pleasemakenewone,
          style: TextStyle(
              color: greyColor, fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        70.verticalSpace,
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(.45.sw, .07.sh),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r))),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateChannelPage(),
                  ));
            },
            child: Text(
              S.of(context).CreateChannel,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            )),
      ],
    );
  }
}
