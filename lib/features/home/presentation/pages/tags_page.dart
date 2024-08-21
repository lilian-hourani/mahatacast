import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/widgets/main_text_field.dart';
import 'package:mahatacast/features/auth/presentation/widgets/content_select_box.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/generated/l10n.dart';

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

TextEditingController tagController = TextEditingController();

class _TagPageState extends State<TagPage> {
  List<String> createdTags = [];
  List<int> tags = [];
  void toggleBox(int id) {
    setState(() {
      if (tags.contains(id)) {
        tags.remove(id);
      } else {
        tags.add(id);
      }
    });
  }

  @override
  void didChangeDependencies() {
    context.read<PodcastBloc>().add(GetAllTagsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"))),
        child: Padding(
          padding: EdgeInsets.only(left: 25.sp, right: 25.sp, top: 40.sp),
          child: Column(
            children: [
              Text(
                S.of(context).WhatAreYouTagging,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              5.verticalSpace,
              Text(
                S.of(context).selectOne,
                style: TextStyle(fontSize: 14, color: greyColor),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: .65.sw,
                    child: Center(
                      child: MainTextField(
                        prefixIcon: null,
                        hint: S.of(context).AddYourTags,
                        hintColor: lightGreyColor,
                        controller: tagController,
                        fillColor: Colors.white,
                        borderColor: beigeColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: BlocListener<PodcastBloc, PodcastState>(
                      listener: (context, state) {
                        if (state.createTagStatus == PodcastStatus.loading) {
                          BotToast.showLoading();
                        } else if (state.createTagStatus ==
                            PodcastStatus.success) {
                          BotToast.closeAllLoading();
                          BotToast.showText(text: S.of(context).TagsSuccess);
                          context.read<PodcastBloc>().add(GetAllTagsEvent());
                        } else if (state.createTagStatus ==
                            PodcastStatus.failed) {
                          BotToast.closeAllLoading();
                          BotToast.showText(text: S.of(context).TagsFailed);
                        }
                      },
                      listenWhen: (previous, current) =>
                          previous.createTagStatus != current.createTagStatus,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: purpleColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            tagController.text.trim();
                            createdTags = tagController.text.split(" ");
                            createdTags.removeWhere((tag) => tag.isEmpty);
                            print(createdTags);
                            context
                                .read<PodcastBloc>()
                                .add(CreateTagEvent(tags: createdTags));
                            print("ok ^ ^");
                          },
                          child: Text(
                            S.of(context).add,
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
              Expanded(
                child: BlocBuilder<PodcastBloc, PodcastState>(
                  buildWhen: (previous, current) =>
                      previous.tagListStatus != current.tagListStatus,
                  builder: (context, state) {
                    if (state.tagListStatus == PodcastStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else if (state.tagListStatus == PodcastStatus.success) {
                      return ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.sp),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              runSpacing: 5,
                              spacing: 5,
                              children: List.generate(
                                state.tagList.length,
                                (index) {
                                  final isSelected =
                                      tags.contains(state.tagList[index].tagId);
                                  return GestureDetector(
                                    onTap: () =>
                                        toggleBox(state.tagList[index].tagId!),
                                    child: ContentSelectBox(
                                      content:
                                          "#${state.tagList[index].tagName!}",
                                      boxColor: isSelected
                                          ? Colors.black
                                          : lightestGreyColor,
                                      fontColor: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(S.of(context).failed),
                      );
                    }
                  },
                ),
              ),
              20.verticalSpace,
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(1.sw, .09.sh),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17))),
                  onPressed: () {
                    Navigator.pop(context, tags);
                  },
                  child: Text(
                    S.of(context).Next,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
