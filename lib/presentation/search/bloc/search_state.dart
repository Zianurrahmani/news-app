import 'package:equatable/equatable.dart';
import 'package:news_app/presentation/home/models/article_model.dart';

class SearchState extends Equatable {
  final bool loading;
  final List<ArticleModel> results;
  final String? error;

  const SearchState({
    this.loading = false,
    this.results = const [],
    this.error,
  });

  SearchState copyWith({
    bool? loading,
    List<ArticleModel>? results,
    String? error,
  }) {
    return SearchState(
      loading: loading ?? this.loading,
      results: results ?? this.results,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, results, error];
}
