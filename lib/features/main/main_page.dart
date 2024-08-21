import 'package:flutter/material.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/widgets/bottom_appbar.dart';
import 'package:mahatacast/features/explore/presentation/pages/explore_page.dart';
import 'package:mahatacast/features/home/presentation/pages/home_page.dart';
import 'package:mahatacast/features/library/presentation/pages/library_page.dart';
import 'package:mahatacast/features/profile/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  
  @override
  State<MainPage> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainPage> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, value, _) {
          return Scaffold(
            backgroundColor: backgoundColor,
            body: IndexedStack(index: value, children: const [
              HomePage(),
               ExplorePage(),
               SizedBox(),
               LibraryPage(),
               ProfilePage()
            ]),
            bottomNavigationBar: CustomBottomAppBar(pageIndex: pageIndex),
          );
        });
  }
}
