import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/features/home/presentation/pages/comments_page.dart';
import 'package:mahatacast/generated/l10n.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key, required this.podcastId});
  final int podcastId;

  @override
  State<RatingPage> createState() => _RatinPageState();
}

List<bool> selectStar = [false, false, false, false, false];
ValueNotifier<int> rate = ValueNotifier(0);
TextEditingController commentController = TextEditingController();
final formKey = GlobalKey<FormState>();

class _RatinPageState extends State<RatingPage> {
  @override
  void initState() {
    rate.value = 0;
    commentController.text = "";
    selectStar = [false, false, false, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).RateAndReview,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp),
                ),
                90.verticalSpace,
                Text(
                  "${S.of(context).Rating} (${rate.value}/5)",
                  style: TextStyle(
                      color: lightGreyColor, fontWeight: FontWeight.w600),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectStar[0]) {
                            selectStar[0] = true;
                            selectStar[1] = false;
                            selectStar[2] = false;
                            selectStar[3] = false;
                            selectStar[4] = false;
                          } else {
                            selectStar[0] = !selectStar[0];
                            print("one");
                            print(selectStar[0]);
                          }
                          rate.value = 1;
                        });
                      },
                      child: Icon(
                        Icons.star_rate_rounded,
                        color: (selectStar[0] ||
                                selectStar[1] ||
                                selectStar[2] ||
                                selectStar[3] ||
                                selectStar[4])
                            ? redColor
                            : redColor.withOpacity(.4),
                        size: 35.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (selectStar[1]) {
                          selectStar[0] = true;
                          selectStar[1] = true;
                          selectStar[2] = false;
                          selectStar[3] = false;
                          selectStar[4] = false;
                        } else {
                          selectStar[1] = !selectStar[1];
                          print("two");
                          print(selectStar[1]);
                        }
                        rate.value = 2;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.star_rate_rounded,
                        color: (selectStar[1] ||
                                selectStar[2] ||
                                selectStar[3] ||
                                selectStar[4])
                            ? redColor
                            : redColor.withOpacity(.4),
                        size: 35.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectStar[2]) {
                            selectStar[0] = true;
                            selectStar[1] = true;
                            selectStar[2] = true;
                            selectStar[3] = false;
                            selectStar[4] = false;
                          } else {
                            selectStar[2] = !selectStar[2];
                            print("three");
                            print(selectStar[2]);
                          }
                          rate.value = 3;
                        });
                      },
                      child: Icon(
                        Icons.star_rate_rounded,
                        color: (selectStar[2] || selectStar[3] || selectStar[4])
                            ? redColor
                            : redColor.withOpacity(.4),
                        size: 35.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectStar[3]) {
                            selectStar[0] = true;
                            selectStar[1] = true;
                            selectStar[2] = true;
                            selectStar[3] = true;
                            selectStar[4] = false;
                          } else {
                            selectStar[3] = !selectStar[3];
                            print("four");
                            print(selectStar[3]);
                          }
                          rate.value = 4;
                        });
                      },
                      child: Icon(
                        Icons.star_rate_rounded,
                        color: (selectStar[3] || selectStar[4])
                            ? redColor
                            : redColor.withOpacity(.4),
                        size: 35.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectStar[4]) {
                            selectStar[0] = true;
                            selectStar[1] = true;
                            selectStar[2] = true;
                            selectStar[3] = true;
                            selectStar[4] = true;
                          } else {
                            selectStar[4] = !selectStar[4];
                            print("five");
                            print(selectStar[4]);
                          }
                          rate.value = 5;
                        });
                      },
                      child: Icon(
                        Icons.star_rate_rounded,
                        color: (selectStar[4])
                            ? redColor
                            : redColor.withOpacity(.4),
                        size: 35.sp,
                      ),
                    ),
                  ],
                ),
                30.verticalSpace,
                Text(
                  S.of(context).Review,
                  style: TextStyle(
                      color: lightGreyColor, fontWeight: FontWeight.w600),
                ),
                15.verticalSpace,
                TextFormField(
                  controller: commentController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: S.of(context).ThisTsFantasticPodcast,
                    hintStyle: TextStyle(
                        color: greyColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                          color: redColor,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                          color: redColor,
                        )),
                  ),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocListener<PodcastBloc, PodcastState>(
                      listener: (context, state) {
                        if (state.rateAndReviewStatus ==
                            PodcastStatus.loading) {
                          BotToast.showLoading();
                        } else if (state.rateAndReviewStatus ==
                            PodcastStatus.success) {
                          BotToast.closeAllLoading();
                          BotToast.showText(text: S.of(context).reviewSuccess);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CommentPage(podcastId: widget.podcastId),
                              ));
                        } else if (state.rateAndReviewStatus ==
                            PodcastStatus.failed) {
                          BotToast.closeAllLoading();
                          BotToast.showText(text: S.of(context).tryAgain);
                        }
                      },
                      listenWhen: (previous, current) {
                        return previous.rateAndReviewStatus !=
                            current.rateAndReviewStatus;
                      },
                      child: TextButton(
                          onPressed: () {
                            if (commentController.text.isEmpty) {
                              BotToast.showText(
                                  text: S.of(context).writeComment);
                            } else {
                              print(" th podcast id : ${widget.podcastId}");
                              print(" the rating : ${rate.value}");
                              print(commentController.text);
                              context.read<PodcastBloc>().add(
                                  RateAndReviewEvent(
                                      podcastId: widget.podcastId,
                                      rate: rate.value,
                                      comment: commentController.text));
                            }
                          },
                          child: Text(
                            S.of(context).Post,
                            style: TextStyle(
                                color: Colors.green.shade400,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
