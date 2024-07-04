import 'package:flutter/material.dart';

import '../utils/base_colors.dart';
import '../utils/base_strings.dart';

class OfficeFailureWidget extends StatelessWidget {
  final String? message;

  const OfficeFailureWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          message ?? "",
          style: const TextStyle(
              fontFamily: BaseStrings.interFontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: BaseColors.textColor),
        ),
      ),
    );
  }
}
