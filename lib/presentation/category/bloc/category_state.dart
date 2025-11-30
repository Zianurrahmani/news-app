import 'package:news_app/presentation/home/models/article_model.dart';

class CategoryState {
  final String? selectedCategory;
  final List<ArticleModel> articles;
  final bool loading;
  final String? error;

  CategoryState({
    this.selectedCategory,
    this.articles = const [],
    this.loading = false,
    this.error,
  });

  CategoryState copyWith({
    String? selectedCategory,
    List<ArticleModel>? articles,
    bool? loading,
    String? error,
  }) {
    return CategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      articles: articles ?? this.articles,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
