import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/controller/notification_controller.dart';
import 'package:praktikum_papb/service/notification_service.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification')),
      body: SafeArea(
        child: Obx(() {
          final busy = controller.isBusy.value;
          final granted = controller.permissionGranted.value;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ActionButton(
                label: 'Request permission (${granted ?? '...'})',
                onPressed: busy ? null : controller.requestPermission,
              ),
              _ActionButton(
                label: 'Show notification with payload and custom sound',
                onPressed: busy ? null : controller.showWithPayloadAndCustomSound,
              ),
              _ActionButton(
                label: 'Show notification with big picture',
                onPressed: busy ? null : controller.showBigPicture,
              ),
              _ActionButton(
                label:
                    'Schedule daily ${NotificationService.dailyReminderHour}:00 notification',
                onPressed: busy ? null : controller.scheduleDailyReminder,
              ),
              _ActionButton(
                label: 'Check pending notifications',
                onPressed: busy ? null : controller.showPendingNotifications,
              ),
              _ActionButton(
                label: 'Cancel all notifications',
                onPressed: busy ? null : controller.cancelAll,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _ActionButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FilledButton.tonal(
        onPressed: onPressed,
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}
