import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentSelectBox extends StatefulWidget {
  const ContentSelectBox({super.key, required this.content, required this.boxColor, required this.fontColor});
  final String content;
  final Color boxColor;
  final Color fontColor;

  @override
  State<ContentSelectBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentSelectBox> {
  //ValueNotifier<bool> isPressed = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: .21.sw,
      height: .07.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: widget.boxColor,
      ),
      child: Center(
          child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          widget.content,
          style: TextStyle(
            fontSize: 14.sp,
            color: widget.fontColor ,
          ),
        ),
      )),
    );
  }
}
