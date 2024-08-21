import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/explore/bloc/explore_bloc.dart';
import 'package:mahatacast/features/explore/presentation/pages/search_page.dart';
import 'package:mahatacast/features/explore/presentation/widgets/loading_content_box.dart';
import 'package:mahatacast/features/explore/presentation/widgets/content_box.dart';
import 'package:mahatacast/generated/l10n.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void didChangeDependencies() {
    context.read<ExploreBloc>().add(GetLatestPodcastsEvent());
    context.read<ExploreBloc>().add(GetMostListendPodcastsEvent());
    context.read<ExploreBloc>().add(GetTopRatedPodcastsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(right: .06.sw, left: .06.sw, top: .05.sh),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).Explore,
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
            ),
            15.verticalSpace,
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    )),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              "assets/icons/home/search.svg",
                            ),
                          ),
                          Text(
                            S.of(context).SearchPodcast,
                            style: TextStyle(
                                color: greyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/icons/home/Mic.svg",
                        ),
                      ),
                    ],
                  ),
                )),
            20.verticalSpace,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Search History",
            //       style:
            //           TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
            //     ),
            //     GestureDetector(
            //       onTap: () {},
            //       child: Text("Clear",
            //           style: TextStyle(
            //               color: purpleColor,
            //               fontWeight: FontWeight.w600,
            //               fontSize: 13.sp)),
            //     ),
            //   ],
            // ),
            40.verticalSpace,
            BlocBuilder<ExploreBloc, ExploreState>(
              builder: (context, state) {
                if (state.latestListStatus == ExploreStatus.loading) {
                  return LoadingContentBox(
                      contentTitle: S.of(context).LatestPodcasts);
                } else if (state.latestListStatus == ExploreStatus.success) {
                  return ContentBox(
                    contentTitle: S.of(context).LatestPodcasts,
                    podcastList: state.latestList,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder<ExploreBloc, ExploreState>(
              builder: (context, state) {
                if (state.mostListenedListStatus == ExploreStatus.loading) {
                  return LoadingContentBox(
                      contentTitle: S.of(context).MostListened);
                } else if (state.mostListenedListStatus ==
                    ExploreStatus.success) {
                  return ContentBox(
                    contentTitle: S.of(context).MostListened,
                    podcastList: state.mostListenedList,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder<ExploreBloc, ExploreState>(
              builder: (context, state) {
                if (state.topRatedListStatus == ExploreStatus.loading) {
                  return LoadingContentBox(
                      contentTitle: S.of(context).TopCategories);
                } else if (state.topRatedListStatus == ExploreStatus.success) {
                  return ContentBox(
                    contentTitle: S.of(context).TopCategories,
                    podcastList: state.topRatedList,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
