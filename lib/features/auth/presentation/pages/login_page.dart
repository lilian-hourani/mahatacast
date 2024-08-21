import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/localization-provider/localization.dart';
import 'package:mahatacast/core/message_boxs/explain_message.dart';
import 'package:mahatacast/features/main/main_page.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/core/widgets/main_text_field.dart';
import 'package:mahatacast/features/auth/bloc/auth_bloc.dart';
import 'package:mahatacast/features/auth/presentation/pages/sign_up_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) async {
        if (state.authModelStatus == AuthStatus.loading) {
          BotToast.showLoading(clickClose: false);
        } else if (state.authModelStatus == AuthStatus.authSuccess) {
          BotToast.closeAllLoading();
          await ServiceFunctions.setUserToken(state.authModel!.token!);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        } else if (state.authModelStatus == AuthStatus.authFailed) {
          BotToast.closeAllLoading();
          BotToast.showText(text: "try again");
        }
      },
      listenWhen: (previous, current) {
        return previous.authModelStatus != current.authModelStatus;
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset('assets/images/background.png'),
              Padding(
                padding: const EdgeInsets.all(25),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  style:
                      OutlinedButton.styleFrom(backgroundColor: Colors.black),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: .12.sh, left: .08.sw, right: .08.sw),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context).loginTitle,
                            style: TextStyle(
                                fontSize: 36.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: .02.sh),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            MainTextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              validator: (email) {
                                if (email != null &&
                                    RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                      caseSensitive: false,
                                    ).hasMatch(email)) {
                                  return null;
                                } else {
                                  return S.of(context).validEmail;
                                }
                              },
                              height: 150,
                              fillColor: Colors.white,
                              borderColor: beigeColor,
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/auth/Message.svg',
                                    color: beigeColor,
                                  )),
                              suffixIcon: GestureDetector(
                                  onTap: () => showDialog(
                                        context: context,
                                        builder: (context) => ExplainMessage(
                                            title: S.of(context).email,
                                            content:
                                                S.of(context).emailExplain),
                                      ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/auth/lamp.svg',
                                        color: beigeColor,
                                      ))),
                              hint: S.of(context).email,
                              hintColor: beigeColor,
                            ),
                            const SizedBox(height: 30),
                            MainTextField(
                              controller: passwordController,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return S.of(context).vaildPassword;
                                } else if (p0.length < 8) {
                                  return S.of(context).shortPassword;
                                }
                                return null;
                              },
                              height: 100,
                              fillColor: Colors.white,
                              borderColor: beigeColor,
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/auth/Lock.svg',
                                    color: beigeColor,
                                  )),
                              hint: S.of(context).password,
                              hintColor: beigeColor,
                              counterText: '',
                              isPassword: _obscured,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                child: GestureDetector(
                                  onTap: _toggleObscured,
                                  onLongPress: () => showDialog(
                                    context: context,
                                    builder: (context) => ExplainMessage(
                                        title: S.of(context).password,
                                        content: S
                                            .of(context)
                                            .confirmpasswordExplian),
                                  ),
                                  child: Icon(
                                    _obscured
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    color: beigeColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     TextButton(
                            //         onPressed: () {},
                            //         child: Text(
                            //           'Forgot Password?',
                            //           style: TextStyle(
                            //               color: Colors.black,
                            //               fontSize: 14.sp,
                            //               fontWeight: FontWeight.bold),
                            //         )),
                            //   ],
                            // ),
                            SizedBox(height: .1.sh),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    fixedSize: Size(1.sw, .075.sh),
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(17))),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(GetLoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text));
                                  }
                                },
                                child: Text(
                                  S.of(context).login,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 18,
                                      left: Provider.of<LocaleNotifier>(context)
                                              .isArabic
                                          ? 0
                                          : 40,
                                      right:
                                          Provider.of<LocaleNotifier>(context)
                                                  .isArabic
                                              ? 30
                                              : 0),
                                  child: Text(
                                    S.of(context).donotHaveAcount,
                                    style: TextStyle(
                                        fontSize: 14.sp, color: greyColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpPage()));
                                      },
                                      child: Text(
                                        S.of(context).signup,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
