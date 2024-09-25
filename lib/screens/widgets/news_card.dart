import 'package:flutter/material.dart';
import 'package:lingoassignment/constants/k_colors.dart';
import 'package:lingoassignment/constants/k_spacing.dart';


class NewsCard extends StatelessWidget {
  final Widget child;
  const NewsCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(
                Spacing.spacingSmall + Spacing.spacingMicro)),
        padding: const EdgeInsets.symmetric(
            horizontal: Spacing.spacingBase, vertical: Spacing.spacingMedium),
        margin: const EdgeInsets.all(
          Spacing.spacingBase,
        ),
        child: child);
  }
}
