import 'package:flutter/material.dart';
import 'package:flutter_overlay_example/notifications_overlay/notification_model.dart';
import 'package:flutter_overlay_example/notifications_overlay/notifications_overlay.dart';
import 'package:flutter_overlay_example/notifications_overlay/notifications_overlay_manager.dart';
import 'package:gap/gap.dart';

class NotificationsExample extends StatelessWidget {
  static const String routeName = '/notifications';
  const NotificationsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications Example')),
      backgroundColor: Colors.white,
      extendBody: true,
      body: Center(
        child: NotificationsOverlay(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  NotificationsOverlayManager().showNotification(NotificationModel(message: 'This is a notification! ${DateTime.now()},'));
                },
                child: const Text('Show Notification '),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  NotificationsOverlayManager().showNotification(
                    NotificationModel(
                      message: 'This is a notification! ${DateTime.now()}',
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                    ),
                  );
                },
                child: const Text('Show Notification with Icon'),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  NotificationsOverlayManager().showNotification(
                    NotificationModel(
                      message: 'This is a notification! ${DateTime.now()}',
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      autoCloseCounterClockwise: true,
                    ),
                  );
                },
                child: const Text('Show Notification with Auto-Close Indicator Counter-Clockwise'),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  NotificationsOverlayManager().showNotification(
                    NotificationModel(
                      message: 'This is a notification! ${DateTime.now()}',
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      showAutoCloseIndicator: false,
                    ),
                  );
                },
                child: const Text('Show Notification without Auto-Close Indicator'),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  NotificationsOverlayManager().showNotification(
                    NotificationModel(
                      message: 'This is a notification! ${DateTime.now()}',
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      autoClose: false,
                    ),
                  );
                },
                child: const Text('Show Notification without Auto-Close'),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  NotificationsOverlayManager().clearAllNotifications();
                },
                child: const Text('Clear All Notifications'),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  NotificationsOverlayManager().closeOverlay();
                },
                child: const Text('Hide Notifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
