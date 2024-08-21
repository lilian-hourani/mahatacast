import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/localization-provider/localization.dart';
import 'package:mahatacast/features/auth/bloc/auth_bloc.dart';
import 'package:mahatacast/features/auth/presentation/pages/select_page.dart';
import 'package:mahatacast/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mahatacast/features/intro/pages/lan_page.dart';
import 'package:mahatacast/features/main/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 4), () {
      context.read<AuthBloc>().add(CheckAuthEvent());
      context.read<AuthBloc>().add(CheckSelectEvent());
      context.read<LocaleNotifier>().initLocal();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state.authModelStatus);
        if (state.authModelStatus == AuthStatus.intro) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LanguagePage(),
              ));
        } else if (state.authModelStatus == AuthStatus.authFailed) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpPage(),
              ));
        } else if ((state.authModelStatus == AuthStatus.authSuccess &&
                state.selectContentStatus == AuthStatus.intro) ||
            (state.authModelStatus == AuthStatus.authSuccess &&
                state.selectContentStatus == AuthStatus.selectFailed)) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectPage(),
              ));
        } else if ((state.authModelStatus == AuthStatus.authSuccess &&
            state.selectContentStatus == AuthStatus.selectSuccess)) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ));
        }
      },
      listenWhen: (previous, current) {
        return previous.authModelStatus != current.authModelStatus ||
            previous.selectContentStatus != current.selectContentStatus;
      },
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarGlow(
              animate: true,
              glowColor: purpleColor,
              glowRadiusFactor: .5,
              curve: Curves.bounceInOut,
              child: Image.asset(
                "assets/images/logo.png",
                width: 130,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        )),
      ),
    );
  }
}
