import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/localization-provider/localization.dart';
import 'package:mahatacast/core/message_boxs/logout_message.dart';
import 'package:mahatacast/features/profile/blocs/profile-bloc/profile_bloc.dart';
import 'package:mahatacast/features/profile/presentation/pages/check_user_channel_page.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/profile/presentation/pages/user_channel_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int language = ServiceFunctions.isArabic() ? 2 : 1;
  bool isClicked = true;
  bool hasChannel = false;
  @override
  void didChangeDependencies() async {
    context.read<ProfileBloc>().add(GetProfileInfoEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).MyProfile,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ServiceFunctions.isArabic() ? 26.sp : 30.sp),
            ),
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset("assets/images/profile.jpg"),
                    ),
                    10.horizontalSpace,
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state.profileStatus == ProfileStatus.loading) {
                          return const CircularProgressIndicator();
                        } else if (state.profileStatus ==
                            ProfileStatus.success) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.profileModel!.userName!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp),
                              ),
                              Text(
                                state.profileModel!.userEmail!,
                                style: TextStyle(
                                    color: lightGreyColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 90,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: lightestGreyColor,
                                    borderRadius: BorderRadius.circular(40)),
                              )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .shimmer(
                                      duration: 1200.ms,
                                      color: Colors.grey[100],
                                      angle: 120),
                              10.verticalSpace,
                              Container(
                                width: 120,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: lightestGreyColor,
                                    borderRadius: BorderRadius.circular(40)),
                              )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .shimmer(
                                      duration: 1200.ms,
                                      color: Colors.grey[100],
                                      angle: 120),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () async {
                      int? channelId = await ServiceFunctions.getChannelId();
                      if (channelId == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckUserChannel(),
                            ));
                      } else {
                        print("the id is $channelId");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserChannelPage(
                                channelId: channelId,
                              ),
                            ));
                      }
                    },
                    child: Text(
                      S.of(context).ViewChannel,
                      style: TextStyle(
                          color: purpleColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            50.verticalSpace,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: greyColor,
                          ),
                          5.horizontalSpace,
                          Text(
                            S.of(context).Language,
                            style: TextStyle(color: lightGreyColor),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isClicked = !isClicked;
                          });
                        },
                        child: SvgPicture.asset(
                          isClicked
                              ? "assets/icons/home/arrow_down.svg"
                              : "assets/icons/home/arrow_up.svg",
                          color: greyColor,
                          width: 20,
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: !isClicked,
                    child: Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: language,
                          activeColor: textButtonColor,
                          onChanged: (value) {
                            setState(() {
                              print("$value is english");
                              language = value!;
                            });
                            context
                                .read<LocaleNotifier>()
                                .setLocal(const Locale('en'));
                            ServiceFunctions.setLangauge('en');
                          },
                        ),
                        5.horizontalSpace,
                        Text(
                          S.of(context).English,
                          style: TextStyle(color: lightGreyColor),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isClicked,
                    child: Row(
                      children: [
                        Radio<int>(
                          value: 2,
                          groupValue: language,
                          activeColor: textButtonColor,
                          onChanged: (value) {
                            setState(() {
                              print("$value is arabic");
                              language = value!;
                            });
                            context
                                .read<LocaleNotifier>()
                                .setLocal(const Locale('ar'));
                            ServiceFunctions.setLangauge('ar');
                          },
                        ),
                        5.horizontalSpace,
                        Text(
                          S.of(context).Arabic,
                          style: TextStyle(color: lightGreyColor),
                        )
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  const Divider(
                    color: Colors.white,
                    thickness: 1.5,
                  ),
                  10.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => const LogoutMessage());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.power_settings_new_outlined,
                          color: greyColor,
                        ),
                        5.horizontalSpace,
                        Text(
                          S.of(context).Logout,
                          style: TextStyle(color: lightGreyColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
