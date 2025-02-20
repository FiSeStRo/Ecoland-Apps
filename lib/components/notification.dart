import 'package:flutter/material.dart';

enum NotificationType { success, error, warning }

class CustomNotification extends StatelessWidget {
  final String message;
  final NotificationType type;
  final VoidCallback onClose;

  const CustomNotification({
    super.key,
    required this.message,
    required this.type,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case NotificationType.success:
        backgroundColor = const Color(0xFF4CAF50);
        icon = Icons.check_circle;
        break;
      case NotificationType.error:
        backgroundColor = const Color(0xFFE57373);
        icon = Icons.error;
        break;
      case NotificationType.warning:
        backgroundColor = const Color(0xFFFFB74D);
        icon = Icons.warning;
        break;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

void showCustomNotification(
  BuildContext context, {
  required String message,
  required NotificationType type,
  int durationInSeconds = 0,
}) {
  OverlayState? overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: CustomNotification(
        message: message,
        type: type,
        onClose: () {
          overlayEntry.remove();
        },
      ),
    ),
  );

  overlayState.insert(overlayEntry);
  if (durationInSeconds != 0) {
    Future.delayed(Duration(seconds: durationInSeconds), () {
      overlayEntry.remove();
    });
  }
  ;
}
