import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/widgets/back_button.dart';

class ChannelAppBar extends StatelessWidget {
  const ChannelAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          const CustomBackButton(),
          100.horizontalSpace,
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
          ),
          // GestureDetector(
          //   onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => EditChannelPage(
          //             imagePath: BlocProvider.of<ChannelBloc>(context)
          //                 .state
          //                 .channelInfo!
          //                 .channelImage!,
          //             channelName: BlocProvider.of<ChannelBloc>(context)
          //                 .state
          //                 .channelInfo!
          //                 .channelName!,
          //             description: BlocProvider.of<ChannelBloc>(context)
          //                 .state
          //                 .channelInfo!
          //                 .description!),
          //       )),
          //   child: SvgPicture.asset(
          //     "assets/icons/home/edit.svg",
          //     width: 22,
          //     color: darkGrey,
          //   ),
          // )
        ],
      ),
    );
  }
}
