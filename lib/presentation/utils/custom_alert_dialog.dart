import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_staff_management/presentation/utils/base_assets.dart';

import 'base_colors.dart';
import 'base_strings.dart';

void showCustomDialog(BuildContext context, Widget upperButton, Widget lowerButton,
    {bool isOffice = false, bool isTitle = false}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: !isOffice
                          ? InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(BaseAssets.backArrowIcon),
                            )
                          : const SizedBox(),
                    ),
                    isTitle
                        ? const Expanded(
                            child: Text(
                            softWrap: true,
                            BaseStrings.deleteStaffMemberText,
                            style: TextStyle(
                                color: BaseColors.blackColor,
                                fontSize: 20,
                                fontFamily: BaseStrings.interFontFamily,
                                fontWeight: FontWeight.w700),
                            maxLines: 20,
                          ))
                        : const SizedBox(),
                  ],
                ),
                upperButton,
                lowerButton
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = isOffice
            ? Tween(begin: const Offset(0, 1), end: Offset.zero)
            : Tween(begin: const Offset(1, 0), end: Offset.zero);
      } else {
        tween = isOffice
            ? Tween(begin: const Offset(0, -1), end: Offset.zero)
            : Tween(begin: const Offset(1, 0), end: Offset.zero);
      }
      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
