import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/home/presentation/podcast_tabs/details_tab.dart';
import 'package:mahatacast/features/home/presentation/podcast_tabs/episodes_tab.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_podcast_details.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_podcast_home_list.dart';
import 'package:mahatacast/features/home/presentation/widgets/tab_bar.dart';
import 'package:mahatacast/features/library/bloc/library_bloc.dart';
import 'package:mahatacast/features/profile/blocs/channel-bloc/channel_bloc.dart';
import 'package:mahatacast/features/profile/presentation/widgets/channel_app_bar.dart';
import 'package:mahatacast/generated/l10n.dart';

class PodcastDetailsPage extends StatefulWidget {
  const PodcastDetailsPage({super.key, required this.channelId});
  final int channelId;

  @override
  State<PodcastDetailsPage> createState() => _PodcastDetailsPageState();
}

class _PodcastDetailsPageState extends State<PodcastDetailsPage> {
  @override
  void didChangeDependencies() {
    context.read<ChannelBloc>().add(ShowChannelInfo(id: widget.channelId));
    context.read<ChannelBloc>().add(ShowChannelPodcasts(id: widget.channelId));
    context
        .read<ChannelBloc>()
        .add(CheckChannelFollowEvent(id: widget.channelId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<HomeTabBar> podcastTabs = [
      HomeTabBar(content: S.of(context).Episodes),
      HomeTabBar(content: S.of(context).Details),
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(children: [
              ChannelAppBar(
                title: S.of(context).PodcastDetails,
               
              ),
              SizedBox(
                height: .03.sh,
              ),
              BlocBuilder<ChannelBloc, ChannelState>(
                builder: (context, state) {
                  if (state.channelInfoStatus == ChannelStatus.loading) {
                    return const LoadingPodcastDetails();
                  } else if (state.channelInfoStatus == ChannelStatus.success) {
                    return Column(
                      children: [
                        SizedBox(
                          height: .3.sh,
                          width: .8.sw,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "$assetUri${state.channelInfo?.channelImage!}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: .02.sh,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: .1.sw),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.channelInfo!.channelName!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: .02.sw,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${state.channelInfo!.channelFollowersNumber}",
                                        style: TextStyle(
                                            color: greyColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                      ),
                                      5.horizontalSpace,
                                      SvgPicture.asset(
                                        "assets/icons/home/follower.svg",
                                        color: greyColor,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: .02.sh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                                backgroundColor: lightestGreyColor,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      "assets/icons/home/share.svg",
                                      color: greyColor,
                                    ))),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    fixedSize: Size(.4.sw, .06.sh),
                                    backgroundColor: state.isFollowed
                                        ? lightestGreyColor
                                        : Colors.black),
                                onPressed: () {
                                  context.read<ChannelBloc>().add(
                                      ToggleFollowEvent(
                                          id: state.channelInfo!.id!));
                                  context
                                      .read<LibraryBloc>()
                                      .add(GetFollowedChannelsListEvent());
                                },
                                child: Text(
                                  state.isFollowed
                                      ? S.of(context).Followed
                                      : S.of(context).Follow,
                                  style: TextStyle(
                                      color: state.isFollowed
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                )),
                            CircleAvatar(
                                backgroundColor: lightestGreyColor,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      "assets/icons/home/download.svg",
                                      color: greyColor,
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: .02.sh,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                        child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: .25.sh,
                      width: .75.sw,
                      decoration: BoxDecoration(
                          color: lightestGreyColor,
                          borderRadius: BorderRadius.circular(20)),
                    ));
                  }
                },
              ),
              TabBar(
                tabs: podcastTabs,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                    color: purpleColor,
                    borderRadius: BorderRadius.circular(25)),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp),
                unselectedLabelStyle: TextStyle(
                    color: greyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp),
              ),
              SizedBox(
                height: .02.sh,
              ),
              Expanded(
                  child: TabBarView(children: [
                BlocBuilder<ChannelBloc, ChannelState>(
                  builder: (context, state) {
                    if (state.channelPodcastStatus == ChannelStatus.loading) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                    const LoadingPodcastHomeList()),
                          ),
                        ],
                      );
                    } else if (state.channelPodcastStatus ==
                        ChannelStatus.success) {
                      return EpisodesTab(
                        episoes: state.podcastList!,
                      );
                    } else {
                      return Center(
                        child: Text(S.of(context).failed),
                      );
                    }
                  },
                ),
                BlocBuilder<ChannelBloc, ChannelState>(
                  builder: (context, state) {
                    if (state.descriptionStatus == ChannelStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.descriptionStatus ==
                        ChannelStatus.success) {
                      return DetailsTab(
                          channelName: state.channelInfo!.channelName!,
                          description: state.description!);
                    } else {
                      return Center(
                        child: Text(S.of(context).failed),
                      );
                    }
                  },
                ),
              ]))
            ])),
      ),
    );
  }
}
