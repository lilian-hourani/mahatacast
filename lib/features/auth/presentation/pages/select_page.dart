import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/features/auth/bloc/auth_bloc.dart';
import 'package:mahatacast/features/auth/presentation/widgets/content_select_box.dart';
import 'package:mahatacast/features/main/main_page.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  List<int> contentsIds = [];
  void toggleBox(int id) {
    print(id);
    setState(() {
      if (contentsIds.contains(id)) {
        contentsIds.remove(id);
      } else {
        contentsIds.add(id);
      }
    });
  }

  void isSelected() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('select', true);
  }

  @override
  void didChangeDependencies() {
    context.read<AuthBloc>().add(GetAllContentEvent());
    context.read<AuthBloc>().add(GetNotificationTokenEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/background.png'),
          Padding(
            padding: EdgeInsets.only(top: .07.sh, right: .05.sw, left: .05.sw),
            child: Column(
              children: [
                Text(
                  S.of(context).WhatyourInterest,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 40),
                  child: Text(
                    S.of(context).selectOne,
                    style: TextStyle(fontSize: 14, color: greyColor),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state.contentListStatus == AuthStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else if (state.contentListStatus ==
                          AuthStatus.getSuccess) {
                        return ListView(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              runSpacing: 5,
                              spacing: 5,
                              children: List.generate(
                                state.contentList.length,
                                (index) {
                                  final isSelected = contentsIds.contains(
                                      state.contentList[index].contentId);
                                  return GestureDetector(
                                    onTap: () => toggleBox(
                                        state.contentList[index].contentId!),
                                    child: ContentSelectBox(
                                      content:
                                          state.contentList[index].contentName!,
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
                          ],
                        );
                      } else {
                        return Center(
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(GetAllContentEvent());
                            },
                            child: Text(
                              S.of(context).tryAgain,
                              style: TextStyle(
                                  color: textButtonColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: .05.sh),
                  child: BlocListener<AuthBloc, AuthState>(
                    listenWhen: (previous, current) {
                      return previous.selectContentStatus !=
                          current.selectContentStatus;
                    },
                    listener: (context, state) {
                      if (state.selectContentStatus == AuthStatus.loading) {
                        BotToast.showLoading();
                      } else if (state.selectContentStatus ==
                          AuthStatus.selectSuccess) {
                        BotToast.closeAllLoading();
                        BotToast.showText(
                            text: S.of(context).successfullySelect);
                        isSelected();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      } else if (state.selectContentStatus ==
                          AuthStatus.selectFailed) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: S.of(context).failureSelect);
                      }
                    },
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            fixedSize: Size(1.sw, .075.sh),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17))),
                        onPressed: () {
                          print(contentsIds);
                          context
                              .read<AuthBloc>()
                              .add(SelectContentEvent(contentIds: contentsIds));
                        },
                        child: Text(
                          S.of(context).Continue,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
