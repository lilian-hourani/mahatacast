import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/explore/presentation/pages/search_page.dart';
import 'package:mahatacast/generated/l10n.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: .13.sw,
                height: .13.sh,
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(color: redColor, shape: BoxShape.circle),
                child: Image.asset("assets/images/profile.jpg"),
              ),
              SizedBox(
                width: .03.sw,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).HeyThere,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
                  ),
                  Text(
                    S.of(context).ListenTo,
                    style: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp),
                  )
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                )),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset(
                "assets/icons/home/search.svg",
                color: Colors.white,
                width: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
