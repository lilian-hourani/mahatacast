import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/presentation/pages/podcast_player_page.dart';

class RecentlyPlayedPodcastTile extends StatelessWidget {
  const RecentlyPlayedPodcastTile({super.key, required this.podcast});
  final PodcastModel podcast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: .03.sh,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: .2.sw,
                  height: .07.sh,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.hardEdge,
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage("assets/images/laoding.png"),
                      image: NetworkImage("$assetUri${podcast.channelImage}"))),
              SizedBox(
                width: .01.sh,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      podcast.podcastTitle!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ),
                  5.verticalSpace,
                  SizedBox(
                    width: 180,
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
                            Text(podcast.podcastDuration!,
                                style: TextStyle(
                                    color: greyColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp)),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/library/paper.svg"),
                            SizedBox(
                              width: .005.sh,
                            ),
                            Text(
                                "${podcast.podcastSize!.toStringAsFixed(2)} MB",
                                style: TextStyle(
                                    color: greyColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              print(podcast.podcastId);
              context
                  .read<AudioCubit>()
                  .playNetWork("$baseUri${podcast.podcastPath}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PodcastPlayerPage(
                      podcastId: podcast.podcastId!,
                    ),
                  ));
            },
            child: CircleAvatar(
              backgroundColor: greenColor,
              child: SvgPicture.asset("assets/icons/home/Play_fill.svg"),
            ),
          )
        ],
      ),
    );
  }
}
