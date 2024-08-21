import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/are_you_sure_message.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/presentation/pages/podcast_player_page.dart';

class EpisodeBox extends StatefulWidget {
  const EpisodeBox({super.key, required this.episo, required this.index});
  final PodcastModel episo;
  final int index;

  @override
  State<EpisodeBox> createState() => _PodcastListTileState();
}

class _PodcastListTileState extends State<EpisodeBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PodcastPlayerPage(
                podcastId: widget.episo.podcastId!,
              ),
            )),
        child: SizedBox(
          width: 1.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 80,
                      height: 60,
                      child: Image.network(
                        "$assetUri${widget.episo.channelImage!}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: .02.sw,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.episo.podcastTitle} (0${widget.index + 1})",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                      SizedBox(
                        height: .01.sh,
                      ),
                      SizedBox(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/home/clock.svg"),
                                SizedBox(
                                  width: .005.sh,
                                ),
                                Text(widget.episo.podcastDuration!,
                                    style: TextStyle(
                                        color: greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp)),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/library/paper.svg"),
                                SizedBox(
                                  width: .005.sh,
                                ),
                                Text(
                                    "${widget.episo.podcastSize!.toStringAsFixed(3)} MB",
                                    style: TextStyle(
                                        color: greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                  onTap: () => showDialog(
                        context: context,
                        builder: (context) => AreYouSureMessage(
                            podcastId: widget.episo.podcastId!,
                            channelId: widget.episo.channelId!),
                      ),
                  child: SvgPicture.asset("assets/icons/library/delete.svg"))
            ],
          ),
        ),
      ),
    );
  }
}
