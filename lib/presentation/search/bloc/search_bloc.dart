import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/services/news_service.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NewsService newsService;

  SearchBloc(this.newsService) : super(const SearchState()) {
    on<SearchKeywordEvent>(_onSearch);
  }

  Future<void> _onSearch(SearchKeywordEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final articles = await newsService.searchNews(event.keyword);

      // Filter manually based on dropdown (title / description)
      final filtered = articles.where((a) {
        switch (event.searchBy) {
          case "Title":
            return a.title.toLowerCase().contains(event.keyword.toLowerCase());
          case "Description":
            return a.description?.toLowerCase().contains(event.keyword.toLowerCase()) ?? false;
          default:
            return (a.title.toLowerCase().contains(event.keyword.toLowerCase())) ||
                (a.description?.toLowerCase().contains(event.keyword.toLowerCase()) ?? false);
        }
      }).toList();

      emit(state.copyWith(loading: false, results: filtered));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: "Search failed. Please try again.",
      ));
    }
  }
}
