import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/generated/l10n.dart';

class ExploreTextField extends StatelessWidget {
  const ExploreTextField({super.key, this.onChanged});
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            "assets/icons/home/search.svg",
          ),
        ),
        hintText: S.of(context).SearchPodcast,
        hintStyle: TextStyle(
            color: greyColor, fontWeight: FontWeight.w600, fontSize: 13.sp),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            "assets/icons/home/Mic.svg",
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
      ),
    );
  }
}
