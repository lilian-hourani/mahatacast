import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/core/widgets/back_button.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/features/home/presentation/widgets/podcast_home_list.dart';
import 'package:mahatacast/generated/l10n.dart';

class PodcastBasedOnTagPage extends StatefulWidget {
  const PodcastBasedOnTagPage(
      {super.key, required this.tagId, required this.tagName});
  final int tagId;
  final String tagName;

  @override
  State<PodcastBasedOnTagPage> createState() => _PodcastBasedOnTagPageState();
}

class _PodcastBasedOnTagPageState extends State<PodcastBasedOnTagPage> {
  @override
  void didChangeDependencies() {
    context
        .read<PodcastBloc>()
        .add(ShowPodcastBasedOnTagEvent(tagId: widget.tagId));
    super.didChangeDependencies();
  }

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
              70.horizontalSpace,
              Text(
                "#${widget.tagName}",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
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
          child: BlocBuilder<PodcastBloc, PodcastState>(
            builder: (context, state) {
              if (state.podcastListBasedOnTagStatus == PodcastStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else if (state.podcastListBasedOnTagStatus ==
                  PodcastStatus.success) {
                if (state.podcastListBasedOnTag.isEmpty) {
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
                      itemCount: state.podcastListBasedOnTag.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: PodcastHomeList(
                                podcast: state.podcastListBasedOnTag[index]),
                          ));
                }
              } else {
                return ErrorMessage(
                  onPressed: () {
                    context
                        .read<PodcastBloc>()
                        .add(ShowPodcastBasedOnTagEvent(tagId: widget.tagId));
                  },
                );
              }
            },
          ),
        )
      ]),
    );
  }
}
