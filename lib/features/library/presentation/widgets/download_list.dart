import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/presentation/pages/podcast_player_page.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key, required this.podcast});
  final PodcastModel podcast;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: GestureDetector(
        onTap: () async {
          print(podcast.podcastId);
          context
              .read<AudioCubit>()
              .playNetWork("$assetUri${podcast.podcastPath}");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PodcastPlayerPage(
                  podcastId: podcast.podcastId!,
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, right: 10),
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
                        height: 65,
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/images/laoding.png"),
                            placeholder:
                                const AssetImage("assets/images/laoding.png"),
                            image: NetworkImage(
                                "$assetUri${podcast.channelImage}")),
                      ),
                    ),
                    10.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "${podcast.podcastTitle}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${podcast.channelName}",
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
                          width: 170,
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
                                  SvgPicture.asset(
                                    'assets/icons/library/paper.svg',
                                    width: 18.sp,
                                  ),
                                  2.horizontalSpace,
                                  Text(
                                    "${podcast.podcastSize!.toStringAsFixed(3)} MB",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
