import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/home/bloc/home_state.dart';
import 'package:news_app/services/news_service.dart';

class HomeBloc extends Cubit<HomeState> {
  final NewsService _service;

  HomeBloc(this._service) : super(HomeState.initial());

  static const int pageSize = 5;

  Future<void> loadNews() async {
    emit(state.copyWith(isLoading: true));

    final articles = await _service.fetchTopHeadlinesUSA();

    final initialVisible = articles.take(pageSize).toList();

    emit(state.copyWith(
      allArticles: articles,
      visibleArticles: initialVisible,
      isLoading: false,
      hasMore: articles.length > initialVisible.length,
    ));
  }

  Future<void> refresh() async {
    await loadNews();
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final currentLen = state.visibleArticles.length;
    final nextItems = state.allArticles.skip(currentLen).take(pageSize).toList();

    final updatedVisible = [...state.visibleArticles, ...nextItems];

    emit(state.copyWith(
      visibleArticles: updatedVisible,
      isLoadingMore: false,
      hasMore: updatedVisible.length < state.allArticles.length,
    ));
  }
}
