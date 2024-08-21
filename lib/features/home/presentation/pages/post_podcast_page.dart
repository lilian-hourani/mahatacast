import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/core/widgets/main_text_field.dart';
import 'package:mahatacast/features/auth/bloc/auth_bloc.dart';
import 'package:mahatacast/features/auth/presentation/widgets/content_select_box.dart';
import 'package:mahatacast/features/home/presentation/pages/tags_page.dart';
import 'package:mahatacast/core/widgets/back_button.dart';

class PostPodcastPage extends StatefulWidget {
  const PostPodcastPage({super.key, required this.audioFile});
  final File audioFile;
  @override
  State<PostPodcastPage> createState() => _PostPodcastPageState();
}

class _PostPodcastPageState extends State<PostPodcastPage> {
  ValueNotifier<bool> isclicked = ValueNotifier(false);
  final TextEditingController podcastTitleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<int> selectedTags = [];
  int? selectedContent;
  void toggleBox(int id) {
    setState(() {
      if (selectedContent != id) {
        selectedContent = id;
      }
    });
  }
  @override
  void didChangeDependencies() {
    context.read<AuthBloc>().add(GetAllContentEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AudioCubit>().listenToDuratin();
    return Form(
      key: formKey,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"))),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomBackButton(),
                  10.verticalSpace,
                  Text(
                    S.of(context).AddPodcastDetails,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 30.sp),
                  ),
                  60.verticalSpace,
                  BlocBuilder<AudioCubit, AudioState>(
                    builder: (context, state) {
                      context.read<AudioCubit>().listenToDuratin();
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<AudioCubit>().pauseOrResuem();
                              },
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  BlocProvider.of<AudioCubit>(context).isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  size: 26.sp,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: .6.sw,
                                      child: Slider(
                                        min: 0,
                                        max:
                                            BlocProvider.of<AudioCubit>(context)
                                                .totalDuration
                                                .inSeconds
                                                .toDouble(),
                                        activeColor: Colors.black,
                                        inactiveColor: Colors.white,
                                        value:
                                            BlocProvider.of<AudioCubit>(context)
                                                .currnetDuration
                                                .inSeconds
                                                .toDouble(),
                                        onChanged: (value) {
                                          context.read<AudioCubit>().seek(
                                              Duration(seconds: value.toInt()));
                                        },
                                      ),
                                    ),
                                    Text(ServiceFunctions.formatTime(
                                        BlocProvider.of<AudioCubit>(context)
                                            .totalDuration)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Text(
                                      ServiceFunctions.calculateSize(
                                          widget.audioFile),
                                      style: TextStyle(fontSize: 10.sp)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  20.verticalSpace,
                  MainTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: podcastTitleController,
                    validator: (title) {
                      if (title == null) {
                        return S.of(context).podcastAddTitle;
                      }
                      return null;
                    },
                    height: 150,
                    fillColor: Colors.white,
                    borderColor: beigeColor,
                    prefixIcon: null,
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Icon(
                          Icons.edit_outlined,
                          color: beigeColor,
                        )),
                    hint: S.of(context).PodcastTitle,
                    hintColor: beigeColor,
                  ),
                  10.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      isclicked.value = !isclicked.value;
                    },
                    child: ValueListenableBuilder(
                      valueListenable: isclicked,
                      builder: (context, value, child) => Container(
                          height: value ? 310 : 50,
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: beigeColor)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).Content,
                                    style: TextStyle(
                                      fontSize: .035.sw,
                                      color: beigeColor,
                                    ),
                                  ),
                                  Icon(
                                    value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: beigeColor,
                                  )
                                ],
                              ),
                              Visibility(
                                visible: value,
                                child: Expanded(
                                  child: BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      if (state.contentListStatus ==
                                          AuthStatus.loading) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        );
                                      } else if (state.contentListStatus ==
                                          AuthStatus.getSuccess) {
                                        return ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Wrap(
                                              alignment: WrapAlignment.center,
                                              runSpacing: 5,
                                              spacing: 5,
                                              children: List.generate(
                                                state.contentList.length,
                                                (index) {
                                                  final isSelected =
                                                      (selectedContent ==
                                                          state
                                                              .contentList[
                                                                  index]
                                                              .contentId!);
                                                  return GestureDetector(
                                                    onTap: () => toggleBox(state
                                                        .contentList[index]
                                                        .contentId!),
                                                    child: ContentSelectBox(
                                                      content: state
                                                          .contentList[index]
                                                          .contentName!,
                                                      boxColor: isSelected
                                                          ? Colors.black
                                                          : lightestGreyColor,
                                                      fontColor: isSelected
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Center(
                                          child: Text(S.of(context).failed),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  20.verticalSpace,
                  Container(
                      height: 60,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: beigeColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).Tags,
                            style: TextStyle(
                              fontSize: .035.sw,
                              color: beigeColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              selectedTags = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TagPage(),
                                  ));
                            },
                            child: Icon(
                              Icons.add,
                              color: beigeColor,
                            ),
                          )
                        ],
                      )),
                  80.verticalSpace,
                  BlocListener<PodcastBloc, PodcastState>(
                    listener: (context, state) {
                      if (state.upLoadStatus == PodcastStatus.loading) {
                        BotToast.showLoading();
                      } else if (state.upLoadStatus == PodcastStatus.success) {
                        BotToast.closeAllLoading();
                        BotToast.showText(
                            text: S.of(context).UploadedSuccessfully);
                        Navigator.pop(context);
                      } else if (state.upLoadStatus == PodcastStatus.failed) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: S.of(context).didnotUploaded);
                      }
                    },
                    listenWhen: (previous, current) {
                      return previous.upLoadStatus != current.upLoadStatus;
                    },
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            fixedSize: Size(1.sw, .09.sh),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17))),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print(podcastTitleController.text);
                            print(selectedContent);
                            print(selectedTags);
                            print(ServiceFunctions.formatTimeForAPI(
                                BlocProvider.of<AudioCubit>(context)
                                    .totalDuration));
                            if (selectedContent == null) {
                              BotToast.showText(
                                  text: S.of(context).chooseContent);
                            } else {
                              context.read<PodcastBloc>().add(
                                  UpLoadPodcastEvent(
                                      title: podcastTitleController.text,
                                      podcast: widget.audioFile,
                                      contentId: selectedContent!,
                                      tags: selectedTags,
                                      duration:
                                          ServiceFunctions.formatTimeForAPI(
                                              BlocProvider.of<AudioCubit>(
                                                      context)
                                                  .totalDuration)));
                            }
                          }
                        },
                        child: Text(
                          S.of(context).Next,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
