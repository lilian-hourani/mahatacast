import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/localization-provider/localization.dart';
import 'package:mahatacast/features/intro/pages/intro_page.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

int language = 1;

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: .1.sw),
          width: 1.sw,
          height: 1.sh,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(30),
                height: .25.sh,
                decoration: BoxDecoration(
                    color: lightestGreyColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).SelectAppLangauge,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    10.verticalSpace,
                    Row(
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
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
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
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: textButtonColor,
                  ),
                  TextButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IntroPage(),
                          )),
                      child: Text(
                        S.of(context).Next,
                        style: TextStyle(
                            color: textButtonColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
              const Spacer(),
              const Spacer(),
            ],
          )),
    );
  }
}
