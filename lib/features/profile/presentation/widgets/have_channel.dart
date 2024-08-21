import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/profile/data/models/channel_model.dart';
import 'package:mahatacast/features/profile/presentation/pages/create_channel_page.dart';
import 'package:mahatacast/generated/l10n.dart';

class HaveChannel extends StatelessWidget {
  const HaveChannel({super.key, required this.channel});
  final UserChannelModel? channel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).youDoHaveChannel,
          style: TextStyle(
              color: darkGrey, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        20.verticalSpace,
        Container(
          width: .75.sw,
          height: .35.sh,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage("$baseUri${channel!.channelImage}"),
                  fit: BoxFit.cover)),
        ),
        20.verticalSpace,
        Text(
          "${channel!.channelName}",
          style: TextStyle(
              color: greyColor, fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
        50.verticalSpace,
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
