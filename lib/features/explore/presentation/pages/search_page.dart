import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/no_internet_message.dart';
import 'package:mahatacast/features/explore/bloc/explore_bloc.dart';
import 'package:mahatacast/features/explore/presentation/widgets/text_form_field.dart';
import 'package:mahatacast/features/home/presentation/widgets/podcast_home_list.dart';
import 'package:mahatacast/generated/l10n.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              ExploreTextField(
                onChanged: (value) {
                  context
                      .read<ExploreBloc>()
                      .add(SearchBasedOnTitleEvent(title: value));
                },
              ),
              20.verticalSpace,
              SizedBox(
                height: 600,
                child: BlocBuilder<ExploreBloc, ExploreState>(
                  builder: (context, state) {
                    if (state.resultListStatus == ExploreStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else if (state.resultListStatus ==
                        ExploreStatus.success) {
                      if (state.resultList.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              50.verticalSpace,
                              SvgPicture.asset(
                                "assets/icons/explore/noresult.svg",
                                width: .8.sw,
                              ),
                              10.verticalSpace,
                              Text(
                                S.of(context).SorryNoResult,
                                style: TextStyle(
                                    color: lightGreyColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: state.resultList.length,
                            itemBuilder: (context, index) => PodcastHomeList(
                                podcast: state.resultList[index]));
                      }
                    } else if (state.resultListStatus == ExploreStatus.failed) {
                      return NoInternetMessage(
                        onPressed: () {},
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
