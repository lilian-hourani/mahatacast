import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/profile/presentation/pages/create_channel_page.dart';
import 'package:mahatacast/generated/l10n.dart';

class DeletedChannelMessage extends StatelessWidget {
  const DeletedChannelMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: .2.sh),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/icons/home/alert.svg",
            width: 150,
          ),
          20.verticalSpace,
          Text(
            S.of(context).itseemchanneldeleted,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
          ),
          20.verticalSpace,
          Text(
            S.of(context).pleasemakenewone,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: greyColor, fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
          20.verticalSpace,
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
      ),
    );
  }
}
