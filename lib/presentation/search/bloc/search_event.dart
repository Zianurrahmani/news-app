import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchKeywordEvent extends SearchEvent {
  final String keyword;
  final String searchBy; // title, description, both

  SearchKeywordEvent(this.keyword, this.searchBy);

  @override
  List<Object?> get props => [keyword, searchBy];
}
