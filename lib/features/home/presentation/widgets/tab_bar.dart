import 'package:flutter/material.dart';
import 'package:mahatacast/core/localization-provider/localization.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
    required this.content,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
        child: Text(
          content,
          style: TextStyle(
              fontFamily: Provider.of<LocaleNotifier>(context).isArabic
                  ? 'Cairo'
                  : 'Outfit'),
        ),
      ),
    );
  }
}
