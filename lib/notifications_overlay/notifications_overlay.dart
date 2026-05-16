import 'package:flutter/material.dart';
import 'package:flutter_overlay_example/notifications_overlay/notification_model.dart';
import 'package:flutter_overlay_example/notifications_overlay/notification_widget.dart';
import 'package:flutter_overlay_example/notifications_overlay/notifications_overlay_manager.dart';

class NotificationsOverlay extends StatefulWidget {
  final Widget child;
  const NotificationsOverlay({super.key, required this.child});

  @override
  State<NotificationsOverlay> createState() => _NotificationsOverlayState();
}

class _NotificationsOverlayState extends State<NotificationsOverlay> {
  final OverlayPortalController _controller = OverlayPortalController();
  final List<NotificationModel> _notifications = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    NotificationsOverlayManager().setController(_controller);

    NotificationsOverlayManager().addListener((notification) {
      setState(() {
        if (notification != null) {
          _notifications.add(notification);
        } else {
          _notifications.clear();
        }
      });
    });
  }

  @override
  void dispose() {
    NotificationsOverlayManager().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (context) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Material(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _notifications.map((notification) {
                      return NotificationWidget(
                        key: ObjectKey(notification),
                        notification: notification,
                        onClose: (notificationToRemove) {
                          setState(() {
                            _notifications.remove(notificationToRemove);

                            if (_notifications.isEmpty) {
                              _controller.hide();
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
