import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_papb/service/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  late tz.Location jakarta;

  setUpAll(() {
    tz.initializeTimeZones();
    jakarta = tz.getLocation('Asia/Jakarta');
  });

  group('nextInstanceOfHour', () {
    test('returns today when the hour is still ahead', () {
      final now = tz.TZDateTime(jakarta, 2026, 11, 13, 8, 30);

      final next = NotificationService.nextInstanceOfHour(now, 10);

      expect(next, tz.TZDateTime(jakarta, 2026, 11, 13, 10));
    });

    test('returns tomorrow when the hour has passed', () {
      final now = tz.TZDateTime(jakarta, 2026, 11, 13, 10, 0, 1);

      final next = NotificationService.nextInstanceOfHour(now, 10);

      expect(next, tz.TZDateTime(jakarta, 2026, 11, 14, 10));
    });

    test('returns tomorrow at exactly the scheduled time', () {
      final now = tz.TZDateTime(jakarta, 2026, 11, 13, 10);

      final next = NotificationService.nextInstanceOfHour(now, 10);

      expect(next, tz.TZDateTime(jakarta, 2026, 11, 14, 10));
    });

    test('rolls over to the next month', () {
      final now = tz.TZDateTime(jakarta, 2026, 11, 30, 23);

      final next = NotificationService.nextInstanceOfHour(now, 10);

      expect(next, tz.TZDateTime(jakarta, 2026, 12, 1, 10));
    });
  });
}
