// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/make_channel_message.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/blocs/record-cubit/record_cubit.dart';
import 'package:mahatacast/features/home/presentation/pages/post_podcast_page.dart';
import 'package:mahatacast/features/home/presentation/pages/record_podcast_page.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({super.key, required this.pageIndex});
  final ValueNotifier<int> pageIndex;

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

Future _displayBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: .3.sh,
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: SvgPicture.asset("assets/icons/home/line.svg")),
        SizedBox(
          height: .03.sh,
        ),
        Text(
          S.of(context).StartPublishing,
          style: TextStyle(
              color: greyColor, fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: .05.sh,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                bool hasChannel = await ServiceFunctions.hasChannel();
                if (hasChannel) {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.audio);
                  if (result == null) {
                    return;
                  }
                  // open single file
                  final file = File(result.files.first.path!);
                  context.read<AudioCubit>().playFile(file.path);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostPodcastPage(audioFile: file),
                      ));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => const MakeChannelMessage());
                }
              },
              child: Column(children: [
                SvgPicture.asset(
                  "assets/icons/home/gallery.svg",
                  width: 50,
                  color: textButtonColor,
                ),
                Text(
                  S.of(context).gallery,
                  style: TextStyle(
                      color: lightGreyColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ),
            SizedBox(
              width: .07.sw,
            ),
            GestureDetector(
              onTap: () async {
                bool hasChannel = await ServiceFunctions.hasChannel();
                if (hasChannel) {
                  context.read<RecordCubit>().initRecorder();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecorderPage(),
                      ));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => const MakeChannelMessage());
                }
              },
              child: Column(children: [
                SvgPicture.asset(
                  "assets/icons/home/voice.svg",
                  width: 50,
                  color: textButtonColor,
                ),
                Text(
                  S.of(context).recorded,
                  style: TextStyle(
                      color: lightGreyColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ),
            SizedBox(
              width: .07.sw,
            ),
            // Column(children: [
            //   SvgPicture.asset(
            //     "assets/icons/home/pen.svg",
            //     width: 50,
            //     color: textButtonColor,
            //   ),
            //   Text(
            //     S.of(context).written,
            //     style: TextStyle(
            //         color: lightGreyColor,
            //         fontSize: 12.sp,
            //         fontWeight: FontWeight.w500),
            //   )
            // ]),
          ],
        )
      ]),
    ),
  );
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.pageIndex,
      builder: (context, pageValue, _) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)),
          ),
          child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedItemColor: Colors.black,
              currentIndex: pageValue,
              onTap: (value) {
                switch (value) {
                  case 0:
                    {
                      if (pageValue == 0) {
                        break;
                      } else {
                        widget.pageIndex.value = 0;
                      }
                    }
                    break;
                  case 1:
                    {
                      if (pageValue == 1) {
                        break;
                      } else {
                        widget.pageIndex.value = 1;
                      }
                    }
                    break;
                  case 2:
                    {
                      break;
                    }
                  case 3:
                    {
                      if (pageValue == 3) {
                        break;
                      } else {
                        widget.pageIndex.value = 3;
                      }
                    }
                  case 4:
                    {
                      if (pageValue == 4) {
                        break;
                      } else {
                        widget.pageIndex.value = 4;
                      }
                    }
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/home/home.svg",
                      width: .06.sw,
                      color: pageValue == 0 ? Colors.black : greyColor,
                    ),
                    label: S.of(context).home),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/home/explore.svg",
                      width: .06.sw,
                      color: pageValue == 1 ? Colors.black : greyColor,
                    ),
                    label: S.of(context).explore),
                BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        _displayBottomSheet(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: purpleColor,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/home/upload.svg",
                          width: .06.sw,
                          color: pageValue == 2 ? Colors.black : greyColor,
                        ),
                      ),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/home/library.svg",
                      width: .06.sw,
                      color: pageValue == 3 ? Colors.black : greyColor,
                    ),
                    label: S.of(context).library),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/home/profile.svg",
                      width: .06.sw,
                      color: pageValue == 4 ? Colors.black : greyColor,
                    ),
                    label: S.of(context).profile),
              ]),
        );
      },
    );
  }
}
