import 'package:velvet_app/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;

  ProductLoaded({required this.products, required this.filteredProducts});
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});
}
