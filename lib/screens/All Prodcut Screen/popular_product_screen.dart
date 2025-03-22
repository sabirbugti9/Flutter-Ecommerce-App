import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet_app/blocs/product/product_bloc.dart';
import 'package:velvet_app/blocs/product/product_state.dart';
import 'package:velvet_app/screens/detail_product_screen.dart';
import 'package:velvet_app/widgets/product_widget.dart';

class PopularProductScreen extends StatefulWidget {
  const PopularProductScreen({super.key});

  @override
  State<PopularProductScreen> createState() => _PopularProductScreenState();
}

class _PopularProductScreenState extends State<PopularProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: state.filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: 270,
              ),
              itemBuilder: (context, index) {
                final product = state.filteredProducts[index];

                return ProductWidget(
                    product: product,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailProductScreen(product: product)));
                    });
              },
            ),
          );
        }
        return SizedBox.shrink();
      }),
    );
  }
}
