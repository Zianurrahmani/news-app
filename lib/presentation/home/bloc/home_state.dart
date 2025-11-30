import 'package:news_app/presentation/home/models/article_model.dart';

class HomeState {
  final List<ArticleModel> allArticles; // full fetched list
  final List<ArticleModel> visibleArticles; // currently shown (pagination)
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;

  HomeState({
    required this.allArticles,
    required this.visibleArticles,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
  });

  int get itemCount => hasMore ? visibleArticles.length + 1 : visibleArticles.length;

  bool isLoaderIndex(int index) => hasMore && index == visibleArticles.length;

  factory HomeState.initial() {
    return HomeState(
      allArticles: [],
      visibleArticles: [],
      isLoading: false,
      isLoadingMore: false,
      hasMore: true,
    );
  }

  HomeState copyWith({
    List<ArticleModel>? allArticles,
    List<ArticleModel>? visibleArticles,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return HomeState(
      allArticles: allArticles ?? this.allArticles,
      visibleArticles: visibleArticles ?? this.visibleArticles,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
