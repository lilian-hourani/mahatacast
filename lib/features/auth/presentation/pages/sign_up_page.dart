import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/localization-provider/localization.dart';
import 'package:mahatacast/core/message_boxs/explain_message.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/core/widgets/main_text_field.dart';
import 'package:mahatacast/features/auth/bloc/auth_bloc.dart';
import 'package:mahatacast/features/auth/presentation/pages/login_page.dart';
import 'package:mahatacast/features/auth/presentation/pages/select_page.dart';
import 'package:mahatacast/features/intro/pages/intro_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  GlobalKey globalKeyOne = GlobalKey();
  GlobalKey globalKeyTwo = GlobalKey();
  GlobalKey globalKeyThree = GlobalKey();
  GlobalKey globalKeyFour = GlobalKey();
  GlobalKey globalKeyFive = GlobalKey();
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
              MaterialPageRoute(builder: (context) => const SelectPage()));
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
                          builder: (context) => const IntroPage(),
                        ));
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
                padding: const EdgeInsets.only(top: 93, left: 29),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 29),
                            child: Text(
                              S.of(context).signupTitle,
                              style: TextStyle(
                                  fontSize: 36.sp,
                                  fontFamily: ServiceFunctions.isArabic()
                                      ? 'Cairo'
                                      : 'Outfit',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 47, right: 31),
                        child: Column(
                          children: [
                            MainTextField(
                              controller: nameController,
                              validator: (name) {
                                if (!(name != null && name.length >= 3)) {
                                  return S.of(context).EnterName;
                                }
                                return null;
                              },
                              height: 150,
                              fillColor: Colors.white,
                              borderColor: beigeColor,
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/auth/Profile.svg',
                                    color: beigeColor,
                                  )),
                              suffixIcon: GestureDetector(
                                  onTap: () => showDialog(
                                        context: context,
                                        builder: (context) => ExplainMessage(
                                            title: S.of(context).fullName,
                                            content: S.of(context).nameExplain),
                                      ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/auth/lamp.svg',
                                        color: beigeColor,
                                      ))),
                              hint: S.of(context).fullName,
                              hintColor: beigeColor,
                            ),
                            const SizedBox(height: 15),
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
                            const SizedBox(height: 15),
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
                                        content: S.of(context).passwordExplain),
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
                            const SizedBox(height: 15),
                            MainTextField(
                              controller: confirmPasswordController,
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
                              hint: S.of(context).confirmPassword,
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
                                        title: S.of(context).confirmPassword,
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
                            const SizedBox(height: 40),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    fixedSize: Size(1.sw, .075.sh),
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(17))),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (confirmPasswordController.text !=
                                        passwordController.text) {
                                      BotToast.showText(
                                          text: S
                                              .of(context)
                                              .passwordDoesnotMatch);
                                    } else {
                                      context.read<AuthBloc>().add(
                                          GetRegistEvent(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              confirmPassword:
                                                  confirmPasswordController
                                                      .text));
                                    }
                                  }
                                },
                                child: Text(
                                  S.of(context).signup,
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
                                    S.of(context).arleady,
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
                                                    const LoginPage()));
                                      },
                                      child: Text(
                                        S.of(context).login,
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
