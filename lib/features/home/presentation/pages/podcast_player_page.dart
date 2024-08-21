import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/blocs/home-bloc/home_bloc.dart';
import 'package:mahatacast/features/home/presentation/pages/comments_page.dart';
import 'package:mahatacast/features/home/presentation/pages/podcast_details_page.dart';
import 'package:mahatacast/features/home/presentation/pages/rating_page.dart';
import 'package:mahatacast/features/home/presentation/widgets/podacast_app_bar.dart';

class PodcastPlayerPage extends StatefulWidget {
  const PodcastPlayerPage({super.key, required this.podcastId});
  final int podcastId;

  @override
  State<PodcastPlayerPage> createState() => _PodcastPlayerPageState();
}

class _PodcastPlayerPageState extends State<PodcastPlayerPage> {
  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 4), () {
      context
          .read<HomeBloc>()
          .add(ShowPocastEvent(podacastId: widget.podcastId));
      context.read<AudioCubit>().listenToDuratin();
      context.read<AudioCubit>().checkFavorite(widget.podcastId);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state.podcastModelStatus == HomeStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (state.podcastModelStatus == HomeStatus.success) {
            final podcast = state.podcastModel;
            return BlocConsumer<AudioCubit, AudioState>(
              listener: (context, state) {
                if (state.isFinished) {
                  context.read<AudioCubit>().addPodcastToListen(
                      podcast!.podcastId!,
                      ServiceFunctions.formatTimeForAPI(
                          BlocProvider.of<AudioCubit>(context).totalDuration));
                  context.read<HomeBloc>().add(GetLatestListenPodcastEvent());
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RatingPage(
                          podcastId: podcast.podcastId!,
                        ),
                      ));
                }
              },
              listenWhen: (previous, current) {
                return previous.isFinished != current.isFinished;
              },
              builder: (context, state) {
                return Column(
                  children: [
                    PodcastAppBar(
                      title: S.of(context).PodcastPlayer,
                    ),
                    12.verticalSpace,
                    Container(
                      width: .75.sw,
                      height: .35.sh,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "$baseUri${podcast!.channelImage}"),
                              fit: BoxFit.cover)),
                    ),
                    20.verticalSpace,
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: lightestGreyColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                ServiceFunctions.downloadPodcast(
                                    "${podcast.podcastPath}");
                                context.read<PodcastBloc>().add(
                                    DownLoadPodcastEvent(
                                        id: podcast.podcastId!));
                                print(
                                    "add to download ${podcast.podcastTitle}");
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/home/download.svg")),
                          Row(
                            children: [
                              Text("${podcast.podcastRate ?? 0}"),
                              5.horizontalSpace,
                              SvgPicture.asset("assets/icons/home/star.svg"),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<AudioCubit>()
                                  .toggleFavorite(podcast.podcastId!);
                            },
                            child: Row(
                              children: [
                                Text("${podcast.podcastFavourites}"),
                                5.horizontalSpace,
                                SvgPicture.asset(
                                    BlocProvider.of<AudioCubit>(context)
                                            .isFavorite
                                        ? "assets/icons/home/heartFill.svg"
                                        : "assets/icons/home/heart.svg"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text("${podcast.podcastListenersNumber}"),
                              5.horizontalSpace,
                              SvgPicture.asset(
                                  "assets/icons/home/listener.svg"),
                            ],
                          )
                        ],
                      ),
                    ),
                    30.verticalSpace,
                    Text(
                      podcast.podcastTitle!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w600),
                    ),
                    5.verticalSpace,
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PodcastDetailsPage(
                              channelId: podcast.channelId!,
                            ),
                          )),
                      child: Text(
                        "${podcast.channelName} ${S.of(context).by} ${podcast.channelOwnerName}",
                        style: TextStyle(
                            color: greyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    40.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ServiceFunctions.formatTime(
                            BlocProvider.of<AudioCubit>(context)
                                .currnetDuration)),
                        SizedBox(
                          width: .7.sw,
                          child: Slider(
                            min: 0,
                            max: BlocProvider.of<AudioCubit>(context)
                                .totalDuration
                                .inSeconds
                                .toDouble(),
                            activeColor: Colors.black,
                            value: BlocProvider.of<AudioCubit>(context)
                                .currnetDuration
                                .inSeconds
                                .toDouble(),
                            onChanged: (value) {
                              context
                                  .read<AudioCubit>()
                                  .seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                        Text(ServiceFunctions.formatTime(
                            BlocProvider.of<AudioCubit>(context)
                                .totalDuration)),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommentPage(
                                        podcastId: podcast.podcastId!),
                                  ));
                            },
                            child: SvgPicture.asset(
                                "assets/icons/home/message.svg")),
                        GestureDetector(
                          onTap: () =>
                              context.read<AudioCubit>().tenSecBackword(),
                          child: SvgPicture.asset(
                              "assets/icons/home/backward_10_seconds.svg"),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AudioCubit>().pauseOrResuem();
                            context.read<AudioCubit>().addPodcastToListen(
                                podcast.podcastId!,
                                ServiceFunctions.formatTimeForAPI(
                                    BlocProvider.of<AudioCubit>(context)
                                        .currnetDuration));
                            context
                                .read<HomeBloc>()
                                .add(GetLatestListenPodcastEvent());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            child: Icon(
                              BlocProvider.of<AudioCubit>(context).isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.read<AudioCubit>().tenSecForward(),
                          child: SvgPicture.asset(
                              "assets/icons/home/forward_10_seconds.svg"),
                        ),
                        const Text("1.0x")
                      ],
                    ),
                    const Spacer(),
                  ],
                );
              },
            );
          } else if (state.podcastModelStatus == HomeStatus.failed) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: ErrorMessage(
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(ShowPocastEvent(podacastId: widget.podcastId));
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
        }),
      ),
    );
  }
}
