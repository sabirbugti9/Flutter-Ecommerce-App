import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet_app/blocs/product/product_event.dart';
import 'package:velvet_app/blocs/product/product_state.dart';
import 'package:velvet_app/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<LoadProducts>(
      (event, emit) async {
        emit(ProductLoading());
        try {
          final products = await repository.getProducts();
          emit(ProductLoaded(products: products, filteredProducts: products));
        } catch (e) {
          emit(ProductError(message: e.toString()));
        }
      },
    );

    on<FilterProducts>(
      (event, emit) async {
        if (state is ProductLoaded) {
          final currentState = state as ProductLoaded;
          final filtered = currentState.products
              .where((product) => product.category == event.category)
              .toList();
          emit(ProductLoaded(
              products: currentState.products, filteredProducts: filtered));
        }
      },
    );
  }
}
