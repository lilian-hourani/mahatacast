import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/profile/blocs/channel-bloc/channel_bloc.dart';
import 'package:mahatacast/generated/l10n.dart';

class AreYouSureMessage extends StatelessWidget {
  const AreYouSureMessage(
      {super.key, required this.podcastId, required this.channelId});
  final int podcastId;
  final int channelId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: .75.sw,
        height: .15.sh,
        padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
            color: backgoundColor, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            children: [
              Text(
                S.of(context).AreYouSure,
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
                      if (state.deletePodcastStatus == ChannelStatus.loading) {
                        BotToast.showLoading();
                      } else if (state.deletePodcastStatus ==
                          ChannelStatus.success) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: S.of(context).deletingSuccess);
                        context
                            .read<ChannelBloc>()
                            .add(ShowChannelPodcasts(id: channelId));
                        Navigator.pop(context);
                      } else {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: S.of(context).deletingFailed);
                        Navigator.pop(context);
                      }
                    },
                    listenWhen: (previous, current) =>
                        previous.deletePodcastStatus !=
                        current.deletePodcastStatus,
                    child: TextButton(
                        onPressed: () {
                          context
                              .read<ChannelBloc>()
                              .add(DeletePodcastEvent(id: podcastId));
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
