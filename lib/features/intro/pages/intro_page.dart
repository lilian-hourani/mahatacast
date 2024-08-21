import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mahatacast/features/main/main_page.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  void isFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstTime', true);
  }

  @override
  void didChangeDependencies() {
    //context.read<AuthBloc>().add(GetContentNum());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: .05.sh),
                child: SizedBox(
                  height: .32.sh,
                  width: 1.sw,
                  child: Lottie.asset(
                    'assets/images/animation/Animation.json',
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          10.verticalSpace,
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: ServiceFunctions.isArabic()
                      ? const EdgeInsets.only(right: 20)
                      : const EdgeInsets.only(left: 20),
                  child: Text(
                    S.of(context).intro1,
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 30.sp,
                        fontFamily:
                            ServiceFunctions.isArabic() ? 'Cairo' : 'Orbiton',
                        fontWeight: ServiceFunctions.isArabic()
                            ? FontWeight.w800
                            : FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: ServiceFunctions.isArabic()
                      ? const EdgeInsets.only(right: 20)
                      : const EdgeInsets.only(left: 20),
                  child: Text(
                    S.of(context).intro2,
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 30,
                        fontFamily:
                            ServiceFunctions.isArabic() ? 'Cairo' : 'Orbiton',
                        fontWeight: ServiceFunctions.isArabic()
                            ? FontWeight.w800
                            : FontWeight.w900,
                        color: lightGreyColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(400, 60),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17))),
                      onPressed: () {
                        isFirstTime();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      },
                      child: Text(
                        S.of(context).intro3,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextButton(
                        onPressed: () {
                          isFirstTime();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: Text(
                          S.of(context).signup,
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
