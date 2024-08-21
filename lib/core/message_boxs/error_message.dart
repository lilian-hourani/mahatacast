import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/generated/l10n.dart';

class ErrorMessage extends StatefulWidget {
  const ErrorMessage({super.key, required void Function()? onPressed});

  @override
  State<ErrorMessage> createState() => _ErrorMassegeState();
}

class _ErrorMassegeState extends State<ErrorMessage> {
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/icons/home/internet.svg",
          width: .7.sw,
        ),
        Text(
          S.of(context).SomethingWentWong,
          style: TextStyle(
              color: lightGreyColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        7.verticalSpace,
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
    );
  }
}
