import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/services/notification_service.dart';
import 'router/router.dart';
import 'router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await NotificationService.init();
  await Hive.initFlutter();
  await Hive.openBox('notifications');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground Message Received!");

    if (message.notification != null) {
      print("Title: ${message.notification!.title}");
      print("Body: ${message.notification!.body}");
    }
  });

  AppRouter.setupRouter();

  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.router.generator,
      initialRoute: Routes.main,
    );
  }
}
