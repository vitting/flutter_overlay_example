import 'package:flutter/material.dart';
import 'package:flutter_overlay_example/notifications_overlay/notification_model.dart';

typedef NotificationListener = Function(NotificationModel? notification);

class NotificationsOverlayManager {
  static final NotificationsOverlayManager _instance = NotificationsOverlayManager._internal();

  factory NotificationsOverlayManager() {
    return _instance;
  }

  NotificationsOverlayManager._internal();

  OverlayPortalController? _currentController;

  NotificationListener? _listener;

  void setController(OverlayPortalController controller) {
    _currentController = controller;
  }

  void dispose() {
    if (_currentController != null && _currentController!.isShowing) {
      _currentController!.hide();
    }

    _currentController = null;
    removeListener();
  }

  /// Add a listener for overlay open/close state changes
  void addListener(NotificationListener listener) {
    _listener = listener;
  }

  /// Remove the overlay state listener
  void removeListener() {
    _listener = null;
  }

  /// Notify listener about overlay state change
  void _notifyStateChange(NotificationModel? notification) {
    if (_currentController != null && _listener != null) {
      _listener!(notification);
    }
  }

  void showNotification(NotificationModel notification) {
    if (_currentController != null && _currentController!.isShowing == false) {
      _currentController!.show();
    }

    _notifyStateChange(notification);
  }

  void closeOverlay() {
    if (_currentController != null && _currentController!.isShowing) {
      _currentController!.hide();
    }
  }

  void clearAllNotifications() {
    if (_currentController != null && _currentController!.isShowing) {
      _currentController!.hide();
    }

    _notifyStateChange(null);
  }
}
