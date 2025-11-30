import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/category/bloc/category_event.dart';
import 'package:news_app/presentation/category/bloc/category_state.dart';
import 'package:news_app/services/news_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final NewsService service;

  CategoryBloc(this.service) : super(CategoryState()) {
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onSelectCategory(
    SelectCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(
      selectedCategory: event.category,
      loading: true,
      error: null,
    ));

    try {
      final data = await service.getNewsByCategory(event.category);
      emit(state.copyWith(articles: data, loading: false));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: "Failed to load category news",
      ));
    }
  }
}
