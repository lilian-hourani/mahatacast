import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/profile/presentation/pages/check_user_channel_page.dart';
import 'package:mahatacast/generated/l10n.dart';

class MakeChannelMessage extends StatelessWidget {
  const MakeChannelMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: .8.sw,
        height: .5.sh,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r), color: backgoundColor),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset("assets/icons/home/alert.svg"),
              Text(
                S.of(context).DonotHaveChannel,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
              ),
              Text(
                S.of(context).pleaseMakeChannel,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: greyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp),
              ),
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
                          builder: (context) => const CheckUserChannel(),
                        ));
                  },
                  child: Text(
                    S.of(context).CreateChannel,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  )),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  S.of(context).Cancel,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
