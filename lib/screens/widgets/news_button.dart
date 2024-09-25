// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lingoassignment/constants/k_colors.dart';

enum NewsButtonType { primary, tertiary }

class NewsButton extends StatelessWidget {
  final Widget title;
  final Function()? onPressed;
  final double? radius;
  final NewsButtonType type;
  const NewsButton(
      {this.onPressed,
      required this.title,
      super.key,
      required this.type,
      this.radius});
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NewsButtonType.primary:
        return ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor:
                  MaterialStateProperty.all(AppColors.primaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10.0),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Center(
                child: title));

      case NewsButtonType.tertiary:
        return TextButton(
          onPressed: onPressed,
          child: title,
        );
    }
  }
}
