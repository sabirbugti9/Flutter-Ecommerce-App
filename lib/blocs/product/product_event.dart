abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class FilterProducts extends ProductEvent {
  final String category;

  FilterProducts({required this.category});
}
