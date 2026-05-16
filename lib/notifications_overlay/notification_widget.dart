import 'package:flutter/material.dart';
import 'package:flutter_overlay_example/notifications_overlay/notification_model.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationModel notification;
  final Function(NotificationModel notification) onClose;

  const NotificationWidget({super.key, required this.notification, required this.onClose});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.notification.autoCloseDuration);

    if (widget.notification.autoClose) {
      _controller.addStatusListener((status) {
        if (widget.notification.autoCloseCounterClockwise == false && status == AnimationStatus.dismissed) {
          widget.onClose(widget.notification);
        } else if (widget.notification.autoCloseCounterClockwise == true && status == AnimationStatus.completed) {
          widget.onClose(widget.notification);
        }
      });

      if (widget.notification.autoCloseCounterClockwise) {
        _controller.forward();
      } else {
        _controller.reverse(from: 1);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.notification.icon != null) ...[widget.notification.icon!, const SizedBox(width: 8)],
          Expanded(child: Text(widget.notification.message)),
          Row(
            children: [
              const SizedBox(width: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  if (widget.notification.autoClose && widget.notification.showAutoCloseIndicator)
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CircularProgressIndicator(value: _controller.value, strokeWidth: 2, color: Colors.blue);
                      },
                    ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: () {
                      if (widget.notification.autoClose) {
                        _controller.stop();
                      }
                      widget.onClose(widget.notification);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
