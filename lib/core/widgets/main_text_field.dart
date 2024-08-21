import 'package:flutter/material.dart';
import 'package:mahatacast/core/constants/colors.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    this.borderColor,
    this.onChanged,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isPassword = true,
    this.enabled = true,
    this.autoFocus = false,
    this.error = false,
    this.smallSuffixIcon = false,
    this.borderRadius,
    this.maxLines = 1,
    this.hintColor,
    this.width,
    this.height,
    this.maxlength,
    this.label,
    this.fillColor = Colors.white,
    required this.hint,
    this.counterText,
    this.onSubmitted,
    required this.controller,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final TextInputAction textInputAction;
  final Color? borderColor;
  final double? width;
  final Function(String)? onSubmitted;
  final double? height;
  final int? maxlength;
  final String? hint;
  final String? counterText;
  final Color? hintColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool enabled;
  final bool autoFocus;
  final bool smallSuffixIcon;
  final bool error;
  final int maxLines;
  final BorderRadius? borderRadius;
  final Color fillColor;
  final Function(String)? onChanged;
  final String? label;
  final AutovalidateMode? autovalidateMode;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField>
    with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addObserver(this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.width,
      height: 80,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        onFieldSubmitted: widget.onSubmitted,
        onTap: () {
          final lastSelectionPosition = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length - 1),
          );

          final afterLastSelectionPosition = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length),
          );

          if (widget.controller.selection == lastSelectionPosition) {
            widget.controller.selection = afterLastSelectionPosition;
          }
        },
        textInputAction: widget.textInputAction,
        cursorColor: widget.borderColor ?? Theme.of(context).primaryColor,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        maxLength: widget.maxlength,
        onChanged: widget.onChanged,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          constraints: BoxConstraints(maxWidth: size.width),
          label: widget.label == null ? null : Text(widget.label!),
          labelStyle: TextStyle(
            color: beigeColor,
            fontSize: size.width * .035,
          ),
          filled: true,
          fillColor: widget.fillColor,
          hintText: widget.hint,
          counterText: widget.counterText,
          hintStyle: TextStyle(
            fontSize: size.width * .035,
            color: widget.hintColor ?? Colors.grey.shade700,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            borderSide:
                BorderSide(color: widget.borderColor ?? Colors.grey.shade300),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            borderSide: BorderSide(
              color: widget.error
                  ? Theme.of(context).colorScheme.error
                  : Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            borderSide: BorderSide(
                color: widget.borderColor ?? Theme.of(context).primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints: widget.smallSuffixIcon
              ? BoxConstraints(maxWidth: size.width * .15)
              : null,
          suffixIcon: widget.suffixIcon,
          suffixIconConstraints: widget.smallSuffixIcon
              ? BoxConstraints(maxWidth: size.width * .15)
              : null,
          contentPadding: widget.maxLines != 1
              ? null
              : const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        obscureText: !widget.isPassword,
        enableSuggestions: widget.isPassword,
        autocorrect: widget.isPassword,
        autovalidateMode: widget.autovalidateMode,
      ),
    );
  }
}
