import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:mahatacast/features/home/presentation/pages/podcast_details_page.dart';
import 'package:mahatacast/features/library/bloc/library_bloc.dart';
import 'package:mahatacast/features/library/presentation/pages/download_page.dart';
import 'package:mahatacast/features/library/presentation/pages/favorite_page.dart';
import 'package:mahatacast/features/library/presentation/pages/notification_page.dart';
import 'package:mahatacast/generated/l10n.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void didChangeDependencies() {
    context.read<LibraryBloc>().add(GetFollowedChannelsListEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: .06.sw,
              right: .06.sw,
              top: .02.sh,
              bottom: .02.sh,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).Library,
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        )),
                    child: SvgPicture.asset(
                      "assets/icons/library/bill.svg",
                      width: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DownloadsPage(),
                      )),
                  child: Container(
                    width: 170,
                    height: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        S.of(context).Downloads,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritePage(),
                      )),
                  child: Container(
                    width: 170,
                    height: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: lightGreyColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        S.of(context).Favorites,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.sp,
            color: lightGreyColor,
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              children: [
                Text(
                  S.of(context).followedChannels,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: greyColor),
                ),
                10.horizontalSpace,
                SvgPicture.asset(
                  "assets/icons/home/arrow_down.svg",
                  color: greyColor,
                  width: 25,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: BlocBuilder<LibraryBloc, LibraryState>(
                builder: (context, state) {
                  if (state.followedChannelsListStatus ==
                      LibraryStatus.loading) {
                    return GridView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        decoration: BoxDecoration(
                            color: lightestGreyColor,
                            borderRadius: BorderRadius.circular(20)),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .shimmer(
                              duration: 1200.ms,
                              color: Colors.grey[100],
                              angle: 120),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                    );
                  } else if (state.followedChannelsListStatus ==
                      LibraryStatus.success) {
                    return GridView.builder(
                      itemCount: state.followedChannelsList.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PodcastDetailsPage(
                                  channelId:
                                      state.followedChannelsList[index].id!),
                            )),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage("assets/images/laoding.png"),
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset("assets/images/laoding.png"),
                              image: NetworkImage(
                                  "$baseUri${state.followedChannelsList[index].channelImage!}")),
                        ),
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                    );
                  } else {
                    return Center(
                      child: TextButton(
                          onPressed: () {
                            context
                                .read<LibraryBloc>()
                                .add(GetFollowedChannelsListEvent());
                          },
                          child: Text(
                            S.of(context).tryAgain,
                            style: TextStyle(color: textButtonColor),
                          )),
                    );
                  }
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
