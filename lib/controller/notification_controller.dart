import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/service/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _notifications = Get.find();

  final permissionGranted = RxnBool();
  final isBusy = false.obs;

  @override
  void onInit() {
    super.onInit();
    _refreshPermission();
  }

  Future<void> _refreshPermission() async {
    permissionGranted.value = await _notifications.areNotificationsEnabled();
  }

  Future<void> requestPermission() => _run(() async {
    permissionGranted.value = await _notifications.requestPermission();
  });

  Future<void> showWithPayloadAndCustomSound() =>
      _run(_notifications.showWithPayloadAndCustomSound);

  Future<void> showBigPicture() => _run(_notifications.showBigPicture);

  Future<void> scheduleDailyReminder() => _run(() async {
    await _notifications.scheduleDailyReminder();
    _snackbar(
      'Scheduled',
      'Reminder set for ${NotificationService.dailyReminderHour}:00 every day',
    );
  });

  Future<void> showPendingNotifications() => _run(() async {
    final pending = await _notifications.pendingNotifications();
    await Get.dialog(
      AlertDialog(
        title: Text('${pending.length} pending notification(s)'),
        content: pending.isEmpty
            ? const Text('Nothing is scheduled.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final item in pending)
                    Text('#${item.id} ${item.title ?? '(no title)'}'),
                ],
              ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Close')),
        ],
      ),
    );
  });

  Future<void> cancelAll() => _run(() async {
    await _notifications.cancelAll();
    _snackbar('Cancelled', 'All notifications were cancelled');
  });

  Future<void> _run(Future<void> Function() action) async {
    if (isBusy.value) return;
    isBusy.value = true;
    try {
      await action();
    } catch (e) {
      _snackbar('Error', e.toString());
    } finally {
      isBusy.value = false;
    }
  }

  void _snackbar(String title, String message) =>
      Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
}
