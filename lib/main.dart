import 'package:flutter/material.dart';
import 'router/router.dart';
import 'router/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: Routes.search,
    );
  }
}
