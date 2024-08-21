import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/widgets/back_button.dart';
import 'package:mahatacast/features/explore/bloc/explore_bloc.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/presentation/widgets/podcast_home_list.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({super.key, required this.title, required this.podcastList});
  final String title;
  final List<PodcastModel> podcastList;

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 40, right: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomBackButton(),
              ServiceFunctions.isArabic()
                  ? 70.horizontalSpace
                  : 40.horizontalSpace,
              Text(
                widget.title,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Divider(
          color: lightGreyColor,
          thickness: 0.5,
        ),
        Expanded(
          child: BlocBuilder<ExploreBloc, ExploreState>(
            builder: (context, state) {
              if (widget.podcastList.isEmpty) {
                return Column(
                  children: [
                    100.verticalSpace,
                    SvgPicture.asset(
                      "assets/icons/library/favorite-empty.svg",
                      width: .6.sw,
                    ),
                    10.verticalSpace,
                    Text(
                      S.of(context).YourFavoriteIsEmpty,
                      style: TextStyle(
                          color: lightGreyColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: widget.podcastList.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: PodcastHomeList(
                              podcast: widget.podcastList[index]),
                        ));
              }
            },
          ),
        )
      ]),
    );
  }
}
