import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/category/bloc/category_bloc.dart';
import 'package:news_app/presentation/category/bloc/category_event.dart';
import 'package:news_app/presentation/category/bloc/category_state.dart';
import 'package:news_app/presentation/home/widgets/home_card.dart';
import 'package:news_app/services/news_service.dart';

class CategoryResultScreen extends StatelessWidget {
  final String category;

  const CategoryResultScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryBloc(NewsService())..add(SelectCategory(category)),
      child: Scaffold(
        appBar: AppBar(title: Text(category.toUpperCase())),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text(state.error!));
            }

            if (state.articles.isEmpty) {
              return Center(child: Text("No news found"));
            }

            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                return HomeCard(article: state.articles[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
