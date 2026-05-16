import 'package:flutter/material.dart';

class NotificationModel {
  final String message;
  final Widget? icon;
  final bool autoClose;
  final bool showAutoCloseIndicator;
  final Duration autoCloseDuration;
  final bool autoCloseCounterClockwise;
  const NotificationModel({
    required this.message,
    this.icon,
    this.autoClose = true,
    this.showAutoCloseIndicator = true,
    this.autoCloseDuration = const Duration(seconds: 5),
    this.autoCloseCounterClockwise = false,
  });
}
