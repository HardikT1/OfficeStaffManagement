import 'package:flutter/material.dart';

import 'base_colors.dart';
import 'base_strings.dart';

class CustomButton extends StatefulWidget {
  final String? btnNameText;
  final Color backgroundColor;
  final Color textColor;
  final Function()? onTap;

  const CustomButton(
      {super.key,
      this.btnNameText,
      this.onTap,
      this.backgroundColor = BaseColors.skyBlueColor,
      this.textColor = BaseColors.whiteColor});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.50,
          height: 50,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              widget.btnNameText ?? "",
              style: TextStyle(
                  color: widget.textColor,
                  fontSize: 14,
                  fontFamily: BaseStrings.interFontFamily,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
