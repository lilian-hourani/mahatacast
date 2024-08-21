// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_podcast_home_list.dart';
import 'package:mahatacast/features/home/presentation/widgets/podcast_home_list.dart';

import '../../blocs/home-bloc/home_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key, required this.contentId});
  final int contentId;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void didChangeDependencies() async {
    // bool isVisitor = await ServiceFunctions.checkIsVisitor();
    // if (isVisitor) {
    //   context
    //       .read<HomeBloc>()
    //       .add(SelectContentWithVisitorEvent(contentId: widget.contentId));
    // } else {
    //   context
    //       .read<HomeBloc>()
    //       .add(SelectContentWithVisitorEvent(contentId: widget.contentId));
    // }
    context
        .read<HomeBloc>()
        .add(SelectContentWithVisitorEvent(contentId: widget.contentId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 9.sh,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.homeListStatus == HomeStatus.loading) {
                return SizedBox(
                    height: .4.sh,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const LoadingPodcastHomeList();
                      },
                    ));
              } else if (state.homeListStatus == HomeStatus.success) {
                return ListView.builder(
                  itemCount: state.homeList.length,
                  itemBuilder: (context, index) {
                    return PodcastHomeList(
                      podcast: state.homeList[index],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("failed"),
                );
              }
            },
          ),
        )
      ],
    )));
  }
}
