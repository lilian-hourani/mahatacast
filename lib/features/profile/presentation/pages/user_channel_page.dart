import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/deleted_channel_message.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/core/message_boxs/update_image_message.dart';
import 'package:mahatacast/features/home/presentation/podcast_tabs/details_tab.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_podcast_home_list.dart';
import 'package:mahatacast/features/home/presentation/widgets/tab_bar.dart';
import 'package:mahatacast/features/profile/blocs/channel-bloc/channel_bloc.dart';
import 'package:mahatacast/features/profile/presentation/widgets/channel_app_bar.dart';
import 'package:mahatacast/features/profile/presentation/widgets/channel_episodes_tab.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class UserChannelPage extends StatefulWidget {
  const UserChannelPage({super.key, required this.channelId});
  final int channelId;

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  File? imageFile;
  @override
  void didChangeDependencies() {
    context
        .read<ChannelBloc>()
        .add(CheckAndShowChannelEvent(id: widget.channelId));
    context.read<ChannelBloc>().add(ShowChannelPodcasts(id: widget.channelId));
    

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
            child: Column(
              children: [
                ChannelAppBar(
                  title: S.of(context).Channel,
                ),
                SizedBox(
                  height: .03.sh,
                ),
                BlocBuilder<ChannelBloc, ChannelState>(
                  builder: (context, state) {
                    if (state.checkDeleteStatus == ChannelStatus.loading) {
                      return SizedBox(
                        height: .8.sh,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      );
                    } else if (state.checkDeleteStatus ==
                        ChannelStatus.deleted) {
                      return const DeletedChannelMessage();
                    } else if (state.checkDeleteStatus ==
                        ChannelStatus.undeleted) {
                      return SizedBox(
                        height: .8.sh,
                        child: Column(children: [
                          BlocBuilder<ChannelBloc, ChannelState>(
                            builder: (context, state) {
                              if (state.channelInfoStatus ==
                                  ChannelStatus.loading) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 30, left: 20, right: 20),
                                  height: .25.sh,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: lightestGreyColor),
                                )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
                                    .shimmer(
                                        duration: 1200.ms,
                                        color: Colors.grey[100],
                                        angle: 120);
                              } else if (state.channelInfoStatus ==
                                  ChannelStatus.success) {
                                return Column(children: [
                                  SizedBox(
                                    height: .25.sh,
                                    width: .8.sw,
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            height: .25.sh,
                                            width: .75.sw,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                "$assetUri${state.channelInfo!.channelImage!}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (state.channelInfo!
                                                    .channelApprove !=
                                                0) {
                                              if ((await Permission
                                                          .storage.status) !=
                                                      PermissionStatus
                                                          .granted ||
                                                  (await Permission
                                                          .manageExternalStorage
                                                          .status) !=
                                                      PermissionStatus
                                                          .granted ||
                                                  (await Permission
                                                          .accessMediaLocation
                                                          .status) !=
                                                      PermissionStatus
                                                          .granted) {
                                                await Permission.storage
                                                    .request();
                                                await Permission
                                                    .manageExternalStorage
                                                    .request();
                                              }
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          type: FileType.image);
                                              if (result == null) {
                                                return;
                                              }
                                              imageFile = File(
                                                  result.files.first.path!);
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    UpdateChannelImageMessage(
                                                        image: imageFile!,
                                                        channelId: state
                                                            .channelInfo!.id!),
                                              );
                                            } else {
                                              BotToast.showText(
                                                  text: S
                                                      .of(context)
                                                      .channelDidnotApproved);
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icons/profile/edit-photo.svg",
                                            width: 35,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: .04.sh,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: .1.sw),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                ]);
                              } else {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 30, left: 20, right: 20),
                                  height: .25.sh,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: lightestGreyColor),
                                );
                              }
                            },
                          ),
                          20.verticalSpace,
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
                                if (state.channelPodcastStatus ==
                                    ChannelStatus.loading) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: 3,
                                            itemBuilder: (context, index) =>
                                                const LoadingPodcastHomeList()),
                                      ),
                                    ],
                                  );
                                } else if (state.channelPodcastStatus ==
                                    ChannelStatus.success) {
                                  if (state.channelInfo!.channelApprove! == 0) {
                                    return Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        S.of(context).channelDidnotApproved,
                                        style: TextStyle(
                                            color: greyColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    );
                                  } else if (state.podcastList!.isEmpty) {
                                    return Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        S.of(context).postingpodcast,
                                        style: TextStyle(
                                            color: greyColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    );
                                  } else {
                                    return ChannelEpisodesTab(
                                      episoes: state.podcastList!,
                                    );
                                  }
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            BlocBuilder<ChannelBloc, ChannelState>(
                              builder: (context, state) {
                                if (state.descriptionStatus ==
                                    ChannelStatus.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.descriptionStatus ==
                                    ChannelStatus.success) {
                                  return DetailsTab(
                                      channelName:
                                          state.channelInfo!.channelName!,
                                      description: state.description!);
                                } else {
                                  return Center(
                                    child: Text(S.of(context).failed),
                                  );
                                }
                              },
                            ),
                          ]))
                        ]),
                      );
                    } else {
                      return ErrorMessage(
                        onPressed: () {
                          context
                              .read<ChannelBloc>()
                              .add(ShowChannelInfo(id: widget.channelId));
                          context
                              .read<ChannelBloc>()
                              .add(ShowChannelPodcasts(id: widget.channelId));
                          context.read<ChannelBloc>().add(
                              CheckAndShowChannelEvent(
                                  id: widget.channelId));
                        },
                      );
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}
