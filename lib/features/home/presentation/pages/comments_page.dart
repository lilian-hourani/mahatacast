import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/core/widgets/back_button.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/features/home/presentation/widgets/comment_box.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_comment_box.dart';
import 'package:mahatacast/generated/l10n.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.podcastId});
  final int podcastId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void didChangeDependencies() {
    context
        .read<PodcastBloc>()
        .add(GetPodcastCommentsEvent(id: widget.podcastId));
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
                S.of(context).Comments,
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
              if (state.commentsListStatus == PodcastStatus.loading) {
                return ListView.separated(
                    itemCount: 4,
                    separatorBuilder: (context, index) => Divider(
                          color: lightGreyColor,
                          thickness: .2,
                        ),
                    itemBuilder: (context, index) => const LoadingCommentBox());
              } else if (state.commentsListStatus == PodcastStatus.success) {
                if (state.commentsList.isEmpty) {
                  return Column(
                    children: [
                      100.verticalSpace,
                      SvgPicture.asset(
                        "assets/icons/library/emptydownload.svg",
                        width: .6.sw,
                      ),
                      10.verticalSpace,
                      Text(
                        S.of(context).EmptyComments,
                        style: TextStyle(
                            color: lightGreyColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                } else {
                  return ListView.separated(
                      itemCount: state.commentsList.length,
                      separatorBuilder: (context, index) => Divider(
                            color: lightGreyColor,
                            thickness: .2,
                          ),
                      itemBuilder: (context, index) => CommentBox(
                            comment: state.commentsList[index],
                          ));
                }
              } else {
                return ErrorMessage(
                  onPressed: () {
                    context
                        .read<PodcastBloc>()
                        .add(GetPodcastCommentsEvent(id: widget.podcastId));
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
