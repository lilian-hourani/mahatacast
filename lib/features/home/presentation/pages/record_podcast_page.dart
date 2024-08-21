import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/blocs/record-cubit/record_cubit.dart';
import 'package:mahatacast/features/home/presentation/pages/post_podcast_page.dart';
import 'package:mahatacast/generated/l10n.dart';

class RecorderPage extends StatefulWidget {
  const RecorderPage({super.key});

  @override
  State<RecorderPage> createState() => _RecorderPageState();
}

String twoDigits(int n) => n.toString().padLeft(2, '0');

class _RecorderPageState extends State<RecorderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecordCubit, RecordState>(
        builder: (context, state) {
          String twoDigitMinutes =
              twoDigits(state.currentDuration.inMinutes.remainder(60));
          String twoDigitSeconds =
              twoDigits(state.currentDuration.inSeconds.remainder(60));
          return Container(
            height: 1.sh,
            width: 1.sw,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: .7.sw,
                      height: .6.sh,
                      child: AvatarGlow(
                        animate: state.isRecording,
                        glowColor: redColor,
                        glowRadiusFactor: .5,
                        curve: Curves.bounceInOut,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mic_rounded,
                                color: Colors.white,
                                size: 100.sp,
                              ),
                              Text(
                                '$twoDigitMinutes:$twoDigitSeconds',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                            style:
                                OutlinedButton.styleFrom(side: BorderSide.none),
                            onPressed: ()  {
                              if (!state.isRecording) {
                                context
                                  .read<AudioCubit>()
                                  .playFile(state.audioFile!.path);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPodcastPage(
                                          audioFile: state.audioFile!)));
                              }
                            },
                            child: Text(
                              S.of(context).Next,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: greyColor,
                            thickness: 2,
                            endIndent: 10,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.all(20),
                          ),
                          onPressed: () async {
                            context.read<RecordCubit>().stopRecording();
                          },
                          child: Icon(
                            state.isRecording
                                ? Icons.play_arrow_rounded
                                : Icons.stop_rounded,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: greyColor,
                            thickness: 2,
                            endIndent: 10,
                          ),
                        ),
                        OutlinedButton(
                            style:
                                OutlinedButton.styleFrom(side: BorderSide.none),
                            onPressed: () {},
                            child: Text(
                              S.of(context).Cancel,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            )),
                      ],
                    ),
                  ),
                  40.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    context.read<RecordCubit>().close();
    super.dispose();
  }
}
