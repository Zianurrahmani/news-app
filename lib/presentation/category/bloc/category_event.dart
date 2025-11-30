abstract class CategoryEvent {}

class SelectCategory extends CategoryEvent {
  final String category;
  SelectCategory(this.category);
}
