import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/generated/l10n.dart';

class ReportPodcastMessage extends StatelessWidget {
  const ReportPodcastMessage({super.key, required this.podcastId});
  final int podcastId;
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
                S.of(context).Areyougoingreport,
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
                  BlocListener<AudioCubit, AudioState>(
                    listener: (context, state) {
                      if (state.reported) {
                        BotToast.showText(
                          text: S.of(context).reportSuccess,
                        );
                      } else {
                        BotToast.showText(
                          text: S.of(context).reportFailed,
                        );
                      }
                    },
                    listenWhen: (previous, current) =>
                        previous.reported != current.reported,
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<AudioCubit>(context)
                              .reportPodcast(podcastId);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "yes",
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
