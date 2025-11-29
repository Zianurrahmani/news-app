import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/home/bloc/home_bloc.dart';

import 'package:news_app/presentation/home/screens/home_screen.dart';
import 'package:news_app/services/news_service.dart';

Handler homeHandler = Handler(
  handlerFunc: (context, params) {
    return BlocProvider(
      create: (_) => HomeCubit(NewsService())..loadNews(),
      child: HomeScreen(),
    );
  },
);

// Handler detailHandler = Handler(
//   handlerFunc: (context, params) {
//     final jsonString = params["data"]?.first;
//     final article = ArticleModel.fromJson(jsonDecode(jsonString!));

//     return DetailPage(article: article);
//   },
// );
