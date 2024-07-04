import 'package:flutter/material.dart';
import 'base_colors.dart';

Widget floatingActionButton(BuildContext context, Function() onPressed) {
  return FloatingActionButton(
    backgroundColor: BaseColors.iconColor,
    shape: const CircleBorder(),
    onPressed: onPressed,
    child: const Icon(Icons.add, color: Colors.white),
  );
}
