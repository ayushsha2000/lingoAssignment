import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingoassignment/constants/k_spacing.dart';

String timeAgoSinceDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays > 8) {
    return DateFormat.yMMMd().format(date); 
  } else if ((difference.inDays / 7).floor() >= 1) {
    return '${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() > 1 ? 's' : ''} ago';
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'Just now';
  }
}

BorderRadius defaultBorderRadius = const BorderRadius.only(
    topRight: Radius.circular(Spacing.spacingMedium),
    bottomRight: Radius.circular(Spacing.spacingMedium),
    topLeft: Radius.circular(Spacing.spacingMedium),
    bottomLeft: Radius.circular(Spacing.spacingMedium),
  );
