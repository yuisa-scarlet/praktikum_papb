import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/routes/app_routes.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends GetxService {
  static const _icon = '@mipmap/ic_launcher';
  static const _bigPictureAsset = 'assets/images/notification_banner.png';
  static const dailyReminderHour = 10;

  static const _payloadId = 1;
  static const _bigPictureId = 2;
  static const _dailyReminderId = 3;

  // On Android 8+ the sound belongs to the channel, so the custom sound gets its own channel.
  static const _customSoundDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'custom_sound',
      'Custom sound',
      channelDescription: 'Notifications that play the app chime',
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    ),
  );

  static const _dailyReminderDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'daily_reminder',
      'Daily reminder',
      channelDescription: 'Reminder shown every day',
    ),
  );

  final FlutterLocalNotificationsPlugin _plugin;

  String? _launchPayload;

  NotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  Future<NotificationService> init() async {
    await _configureLocalTimezone();

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings(_icon),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) =>
          _openPayload(response.payload),
    );

    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _launchPayload = launchDetails!.notificationResponse?.payload;
    }
    return this;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezone.identifier));
    } catch (e) {
      debugPrint('Unknown device timezone, falling back to UTC: $e');
      tz.setLocalLocation(tz.UTC);
    }
  }

  /// Call once the first route is on screen, so a tap that cold-started the app still navigates.
  void handleLaunchPayload() {
    final payload = _launchPayload;
    _launchPayload = null;
    _openPayload(payload);
  }

  void _openPayload(String? payload) {
    if (payload == null || !payload.startsWith('/')) return;
    Get.toNamed(payload);
  }

  Future<bool> areNotificationsEnabled() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    return await android?.areNotificationsEnabled() ?? false;
  }

  Future<bool> requestPermission() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }

    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    return await ios?.requestPermissions(alert: true, badge: true, sound: true) ??
        false;
  }

  /// Tapping it opens the post detail page named in the payload.
  Future<void> showWithPayloadAndCustomSound({int postId = 1}) {
    return _plugin.show(
      id: _payloadId,
      title: 'New post for you',
      body: 'Tap to read post #$postId',
      notificationDetails: _customSoundDetails,
      payload: AppRoutes.postDetailPath(postId),
    );
  }

  Future<void> showBigPicture() async {
    final bytes = await rootBundle.load(_bigPictureAsset);
    final picture = ByteArrayAndroidBitmap(bytes.buffer.asUint8List());

    await _plugin.show(
      id: _bigPictureId,
      title: 'Big picture',
      body: 'Expand to see the image',
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'big_picture',
          'Big picture',
          channelDescription: 'Notifications with a large image',
          largeIcon: picture,
          styleInformation: BigPictureStyleInformation(
            picture,
            hideExpandedLargeIcon: true,
            contentTitle: 'Big picture',
            summaryText: 'Image from app assets',
          ),
        ),
      ),
    );
  }

  /// Inexact scheduling avoids the SCHEDULE_EXACT_ALARM permission; Android may delay it by a few minutes.
  Future<void> scheduleDailyReminder() {
    return _plugin.zonedSchedule(
      id: _dailyReminderId,
      title: 'Daily reminder',
      body: 'Time to check the latest posts',
      scheduledDate: nextInstanceOfHour(tz.TZDateTime.now(tz.local), dailyReminderHour),
      notificationDetails: _dailyReminderDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: AppRoutes.home,
    );
  }

  Future<List<PendingNotificationRequest>> pendingNotifications() =>
      _plugin.pendingNotificationRequests();

  Future<void> cancelAll() => _plugin.cancelAll();

  @visibleForTesting
  static tz.TZDateTime nextInstanceOfHour(tz.TZDateTime now, int hour) {
    final today = tz.TZDateTime(now.location, now.year, now.month, now.day, hour);
    if (today.isAfter(now)) return today;
    return tz.TZDateTime(now.location, now.year, now.month, now.day + 1, hour);
  }
}
