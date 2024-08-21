import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/generated/l10n.dart';

class NoInternetMessage extends StatelessWidget {
  const NoInternetMessage({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          100.verticalSpace,
          SvgPicture.asset(
            "assets/icons/explore/internet.svg",
            width: .8.sw,
          ),
          Text(
            S.of(context).NoInternetConnection,
            style: TextStyle(
                color: lightGreyColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          10.verticalSpace,
          TextButton(
              onPressed: onPressed,
              child: Text(
                S.of(context).tryAgain,
                style: TextStyle(
                    color: textButtonColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
