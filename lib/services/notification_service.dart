import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;
  static final _local = FlutterLocalNotificationsPlugin();
  static final _box = Hive.box('notifications');

  static Future<void> init() async {
    // Request permission
    await _messaging.requestPermission();

    final token = await _messaging.getToken();
    print("🔥 FCM TOKEN: $token");

    // Init local notifications
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _local.initialize(settings);

    // Foreground messages
    FirebaseMessaging.onMessage.listen(_handleMessage);

    // Background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  }

  static void _handleMessage(RemoteMessage message) async {
    final title = message.notification?.title ?? "No Title";
    final body = message.notification?.body ?? "No Body";

    // Save to Hive
    await _saveNotification(title, body);

    // Display notification
    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> _saveNotification(String title, String body) async {
    await _box.add({
      "title": title,
      "body": body,
      "timestamp": DateTime.now().toIso8601String(),
      "read": false,
    });
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService._handleMessage(message);
}
