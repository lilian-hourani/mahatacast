import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/features/auth/bloc/auth_bloc.dart';
import 'package:mahatacast/features/auth/data/models/content_response_model.dart';
import 'package:mahatacast/features/home/blocs/home-bloc/home_bloc.dart';
import 'package:mahatacast/features/home/presentation/widgets/home_app_bar.dart';
import 'package:mahatacast/features/home/presentation/widgets/home_tab.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_podcast_home_list.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_recently_played.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_tab_bar.dart';
import 'package:mahatacast/features/home/presentation/widgets/recently_played_list_tile.dart';
import 'package:mahatacast/features/home/presentation/widgets/tab_bar.dart';
import 'package:mahatacast/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  //final int contentNum;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Content> contents = [];

  @override
  Future<void> didChangeDependencies() async {
    print('changed');
    context.read<HomeBloc>().add(GetLatestListenPodcastEvent());
    context.read<HomeBloc>().add(GetHomeContentListEvent());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 12, vsync: this);
    _tabController.addListener(() {
      print("Current tab index: ${_tabController.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 1.2.sh,
          child: Column(
            children: [
              const HomeAppBar(),
              //const HomeTextField(),
              SizedBox(
                height: .01.sh,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.latestListenPodcastStatus !=
                    current.latestListenPodcastStatus,
                builder: (context, state) {
                  if (state.latestListenPodcastStatus == HomeStatus.loading) {
                    return const LoadindRecntlyPlaying();
                  } else if (state.latestListenPodcastStatus ==
                      HomeStatus.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Recently,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        RecentlyPlayedPodcastTile(
                            podcast: state.latestListenPodcast!),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.homeContentListStatus !=
                    current.homeContentListStatus,
                builder: (context, state) {
                  if (state.homeContentListStatus == HomeStatus.loading) {
                    return const LoadingTabBar();
                  } else if (state.homeContentListStatus ==
                      HomeStatus.success) {
                    contents = state.homeContentList;
                    return TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: contents
                          .map((content) =>
                              HomeTabBar(content: content.contentName!))
                          .toList(),
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
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.homeContentListStatus !=
                    current.homeContentListStatus,
                builder: (context, state) {
                  if (state.homeContentListStatus == HomeStatus.loading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: .4.sh,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return const LoadingPodcastHomeList();
                              },
                            ))
                      ],
                    );
                  } else if (state.homeContentListStatus ==
                      HomeStatus.success) {
                    return Expanded(
                        child: TabBarView(
                            controller: _tabController,
                            children: contents
                                .map((content) =>
                                    HomeTab(contentId: content.contentId!))
                                .toList()));
                  } else {
                    return Expanded(
                      child: ErrorMessage(onPressed: () {
                        context.read<AuthBloc>().add(GetAllContentEvent());
                      }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
