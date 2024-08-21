import 'package:flutter/material.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/generated/l10n.dart';

class ExplainMessage extends StatelessWidget {
  const ExplainMessage({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgoundColor,
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
