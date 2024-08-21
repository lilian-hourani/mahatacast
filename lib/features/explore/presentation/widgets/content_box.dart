import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/explore/presentation/pages/see_all_page.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/explore/presentation/widgets/podcast_box.dart';
import 'package:mahatacast/generated/l10n.dart';

class ContentBox extends StatefulWidget {
  const ContentBox(
      {super.key, required this.contentTitle, required this.podcastList});
  final String contentTitle;
  final List<PodcastModel> podcastList;
  @override
  State<ContentBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: .02.sh),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.contentTitle,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeAllPage(
                          title: widget.contentTitle,
                          podcastList: widget.podcastList),
                    )),
                child: Text(
                  S.of(context).SeeAll,
                  style: TextStyle(
                      color: purpleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: .26.sh,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.podcastList.length,
            itemBuilder: (context, index) {
              return PodcastBox(
                episo: widget.podcastList[index],
              );
            },
          ),
        ),
        SizedBox(
          height: .03.sh,
        )
      ],
    );
  }
}
