import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/report_podcast_message.dart';
import 'package:mahatacast/core/message_boxs/visiter_message.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/presentation/pages/podcast_player_page.dart';

class PodcastHomeList extends StatefulWidget {
  const PodcastHomeList({super.key, required this.podcast});
  final PodcastModel podcast;

  @override
  State<PodcastHomeList> createState() => _PodcastHomeListState();
}

class _PodcastHomeListState extends State<PodcastHomeList> {
  ReceivePort receivePort = ReceivePort();
  int progress = 0;
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });
    });
    FlutterDownloader.registerCallback((id, status, progress) {
      SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
      sendPort?.send([id, status, progress]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: GestureDetector(
        onTap: () async {
          bool isVisitor = await ServiceFunctions.checkIsVisitor();
          if (isVisitor) {
            showDialog(
                context: context, builder: (context) => const VisiterMessege());
          } else {
            print(widget.podcast.podcastId);
            context
                .read<AudioCubit>()
                .playNetWork("$assetUri${widget.podcast.podcastPath}");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PodcastPlayerPage(
                    podcastId: widget.podcast.podcastId!,
                  ),
                ));
          }
        },
        onLongPress: () => showDialog(
          context: context,
          builder: (context) =>
              ReportPodcastMessage(podcastId: widget.podcast.podcastId!),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 80,
                      height: 65,
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset("assets/images/laoding.png"),
                          placeholder:
                              const AssetImage("assets/images/laoding.png"),
                          image: NetworkImage(
                              "$assetUri${widget.podcast.channelImage}")),
                    ),
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          "${widget.podcast.podcastTitle}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.podcast.channelName}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/home/clock.svg",
                                  color: Colors.grey.shade400,
                                  width: 18,
                                ),
                                SizedBox(
                                  width: .005.sh,
                                ),
                                Text(widget.podcast.podcastDuration!,
                                    style: TextStyle(
                                        color: greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp)),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/library/paper.svg',
                                  width: 18.sp,
                                ),
                                2.horizontalSpace,
                                Text(
                                  "${widget.podcast.podcastSize!.toStringAsFixed(3)} MB",
                                  style: TextStyle(
                                      color: greyColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: () async {
                  ServiceFunctions.downloadPodcast(
                      "${widget.podcast.podcastPath}");
                  context
                      .read<PodcastBloc>()
                      .add(DownLoadPodcastEvent(id: widget.podcast.podcastId!));
                  print("add to download ${widget.podcast.podcastTitle}");
                },
                child: SvgPicture.asset(
                  'assets/icons/explore/downlaod.svg',
                  width: 20.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
