import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/intro/pages/splash_page.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/features/auth/bloc/auth_bloc.dart';

class LogoutMessage extends StatelessWidget {
  const LogoutMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: .7.sw,
        height: .15.sh,
        padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
            color: backgoundColor, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            children: [
              Text(
                S.of(context).wantToLogOut,
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              25.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.of(context).Cancel,
                        style: TextStyle(
                            color: darkGrey,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      )),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.authModelStatus == AuthStatus.loading) {
                        BotToast.showLoading();
                      } else if (state.authModelStatus ==
                          AuthStatus.authFailed) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: S.of(context).LogoutSuccess);
                        ServiceFunctions.deleteUserToken();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SplashPage(),
                            ));
                      } else {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: S.of(context).LogoutFailed);
                        Navigator.pop(context);
                      }
                    },
                    listenWhen: (previous, current) =>
                        previous.authModelStatus != current.authModelStatus,
                    child: TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(GetLogoutEvent());
                        },
                        child: Text(
                          S.of(context).Yes,
                          style: TextStyle(
                              color: purpleColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
