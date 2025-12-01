import 'package:fluro/fluro.dart';
import 'package:news_app/presentation/category/screens/category_result_screen.dart';
import 'package:news_app/presentation/category/screens/category_screen.dart';

import 'package:news_app/presentation/home/screens/home_screen.dart';
import 'package:news_app/presentation/main/screens/main_screen.dart';
import 'package:news_app/presentation/notification/screens/notification_screen.dart';
import 'package:news_app/presentation/profile/screens/profile_screen.dart';
import 'package:news_app/presentation/search/screens/search_screen.dart';

Handler mainHandler = Handler(
  handlerFunc: (context, param) {
    return MainScreen();
  },
);

Handler homeHandler = Handler(
  handlerFunc: (context, param) {
    return HomeScreen();
  },
);

Handler searchHandler = Handler(
  handlerFunc: (context, param) {
    return SearchScreen();
  },
);

Handler categoryHandler = Handler(
  handlerFunc: (context, param) {
    return CategoryScreen();
  },
);

Handler categoryResultHandler = Handler(
  handlerFunc: (context, param) {
    final category = context?.settings?.arguments as String;
    return CategoryResultScreen(category: category);
  },
);

Handler profileHandler = Handler(
  handlerFunc: (context, param) {
    return ProfileScreen();
  },
);
Handler notifHandler = Handler(
  handlerFunc: (context, param) {
    return NotificationScreen();
  },
);

// Handler detailHandler = Handler(
//   handlerFunc: (context, params) {
//     final jsonString = params["data"]?.first;
//     final article = ArticleModel.fromJson(jsonDecode(jsonString!));

//     return DetailPage(article: article);
//   },
// );
