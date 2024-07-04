import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_colors.dart';
import 'base_strings.dart';

class CustomTextFormField extends StatefulWidget {
  final String? errorText;
  final String? hint;
  final TextStyle? style;
  final String? labelText;
  final bool? enabled;
  final TextEditingController? textEditingController;
  final double? border;
  final FocusNode? focusNode;
  final double? width;
  final double? height;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Color? bgBorderColor = BaseColors.whiteColor;
  final Color? bgColor = BaseColors.whiteColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isPassword;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final bool? obscureText;
  final bool? autofocus;

  final GestureTapCallback? onTap;
  final GestureTapCallback? onEditingComplete;
  final bool? showCursor;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final Iterable<String>? autofillHints;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  const CustomTextFormField(
      {super.key,
      this.hint,
      this.errorText,
      this.focusNode,
      this.enabled,
      this.showCursor,
      this.onTap,
      this.labelText,
      this.textEditingController,
      this.onChanged,
      this.validator,
      this.border,
      this.width,
      this.height,
      this.suffixIcon,
      this.prefixIcon,
      this.isPassword = false,
      this.readOnly = false,
      this.autofocus = false,
      this.textInputAction,
      this.keyboardType,
      this.maxLength,
      this.maxLines,
      this.obscureText,
      this.style,
      this.onSaved,
      this.labelStyle,
      this.hintStyle,
      this.textCapitalization = TextCapitalization.words,
      this.inputFormatters,
      this.autofillHints,
      this.onEditingComplete});

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isToggle = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: BaseColors.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: TextFormField(
            autofocus: widget.autofocus ?? false,
            textAlignVertical: TextAlignVertical.center,
            autofillHints: widget.autofillHints,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.words,
            readOnly: false,
            focusNode: widget.focusNode,
            onSaved: widget.onSaved,
            style: widget.style,
            enabled: widget.enabled,
            maxLines: widget.maxLines ?? 1,
            showCursor: widget.showCursor,
            onTap: widget.onTap,
            inputFormatters: widget.inputFormatters ??
                [
                  LengthLimitingTextInputFormatter(widget.maxLength),
                ],
            validator: widget.validator,
            obscureText: widget.isPassword! ? !isToggle : false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            controller: widget.textEditingController,
            decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: widget.hint,
                hintStyle: widget.hintStyle ??
                    TextStyle(
                        color: BaseColors.hintTextColor.withOpacity(0.6),
                        fontSize: 16,
                        fontFamily: BaseStrings.interFontFamily,
                        fontWeight: FontWeight.normal),
                labelText: widget.labelText,
                labelStyle: widget.labelStyle ??
                    const TextStyle(
                        fontSize: 13,
                        color: BaseColors.textColor,
                        fontFamily: BaseStrings.interFontFamily)),
          ),
        ),
      ),
    );
  }
}