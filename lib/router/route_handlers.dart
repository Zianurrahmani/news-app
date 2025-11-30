import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/category/screens/category_result_screen.dart';
import 'package:news_app/presentation/category/screens/category_screen.dart';
import 'package:news_app/presentation/home/bloc/home_bloc.dart';

import 'package:news_app/presentation/home/screens/home_screen.dart';
import 'package:news_app/presentation/search/bloc/search_bloc.dart';
import 'package:news_app/presentation/search/screens/search_screen.dart';
import 'package:news_app/services/news_service.dart';

Handler homeHandler = Handler(
  handlerFunc: (context, params) {
    return BlocProvider(
      create: (_) => HomeCubit(NewsService())..loadNews(),
      child: HomeScreen(),
    );
  },
);

Handler searchHandler = Handler(
  handlerFunc: (context, params) {
    return BlocProvider(
      create: (_) => SearchBloc(NewsService()),
      child: SearchScreen(),
    );
  },
);

Handler categoryHandler = Handler(
  handlerFunc: (_, __) {
    return CategoryScreen();
  },
);

Handler categoryResultHandler = Handler(
  handlerFunc: (context, params) {
    final category = context?.settings?.arguments as String;
    return CategoryResultScreen(category: category);
  },
);

// Handler detailHandler = Handler(
//   handlerFunc: (context, params) {
//     final jsonString = params["data"]?.first;
//     final article = ArticleModel.fromJson(jsonDecode(jsonString!));

//     return DetailPage(article: article);
//   },
// );
