import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/visiter_message.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/presentation/pages/podcast_details_page.dart';
import 'package:mahatacast/features/home/presentation/pages/podcast_player_page.dart';

class PodcastBox extends StatelessWidget {
  const PodcastBox({super.key, required this.episo});
  final PodcastModel episo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            bool isVisitor = await ServiceFunctions.checkIsVisitor();
            if (isVisitor) {
              showDialog(
                  context: context,
                  builder: (context) => const VisiterMessege());
            } else {
              context
                  .read<AudioCubit>()
                  .playNetWork("$assetUri${episo.podcastPath}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PodcastPlayerPage(
                      podcastId: episo.podcastId!,
                    ),
                  ));
            }
          },
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 12),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("$assetUri${episo.channelImage}"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12)),
                width: .5.sw,
                height: .2.sh,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: Container(
                        width: .35.sw,
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.white.withOpacity(.01),
                              Colors.white.withOpacity(.05)
                            ]),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(children: [
                          SizedBox(
                            width: .01.sw,
                          ),
                          SizedBox(
                            height: 30,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: SvgPicture.asset(
                                "assets/icons/home/Play_fill.svg",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            episo.podcastDuration!,
                            style: TextStyle(
                                color: greyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp),
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: .5.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: .4.sw,
                    child: Text(
                      episo.podcastTitle!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PodcastDetailsPage(
                            channelId: episo.channelId!,
                          ),
                        )),
                    child: Text(episo.channelName!,
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp)),
                  ),
                ],
              ),
              SizedBox(
                width: 30,
                child: GestureDetector(
                  onTap: () {
                    ServiceFunctions.downloadPodcast("${episo.podcastPath}");
                    context
                        .read<PodcastBloc>()
                        .add(DownLoadPodcastEvent(id: episo.podcastId!));
                    print("add to download ${episo.podcastTitle}");
                  },
                  child: GestureDetector(
                    onTap: () {
                      ServiceFunctions.downloadPodcast("${episo.podcastPath}");
                      context
                          .read<PodcastBloc>()
                          .add(DownLoadPodcastEvent(id: episo.podcastId!));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: SvgPicture.asset(
                        "assets/icons/home/upload_cerli.svg",
                        width: 15,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
