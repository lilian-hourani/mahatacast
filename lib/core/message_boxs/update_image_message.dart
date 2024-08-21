import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/profile/blocs/channel-bloc/channel_bloc.dart';
import 'package:mahatacast/generated/l10n.dart';

class UpdateChannelImageMessage extends StatelessWidget {
  const UpdateChannelImageMessage(
      {super.key, required this.image, required this.channelId});
  final int channelId;
  final File image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: .8.sw,
        height: .18.sh,
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
            color: backgoundColor, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            children: [
              Text(
                S.of(context).changeChannelImage,
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              25.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.of(context).Cancel,
                        style: TextStyle(
                            color: darkGrey,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      )),
                  BlocListener<ChannelBloc, ChannelState>(
                    listener: (context, state) {
                      if (state.updateChannelImageStatus ==
                          ChannelStatus.loading) {
                        BotToast.showLoading();
                      } else if (state.updateChannelImageStatus ==
                          ChannelStatus.success) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: S.of(context).updatingSuccess);
                        context
                            .read<ChannelBloc>()
                            .add(ShowChannelInfo(id: channelId));
                        Navigator.pop(context);
                      } else {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: S.of(context).updatingFailed);
                        Navigator.pop(context);
                      }
                    },
                    listenWhen: (previous, current) =>
                        previous.updateChannelImageStatus !=
                        current.updateChannelImageStatus,
                    child: TextButton(
                        onPressed: () {
                          context.read<ChannelBloc>().add(
                              UpdateChannelImageEvent(
                                  channelId: channelId, image: image));
                        },
                        child: Text(
                          S.of(context).Yes,
                          style: TextStyle(
                              color: purpleColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
