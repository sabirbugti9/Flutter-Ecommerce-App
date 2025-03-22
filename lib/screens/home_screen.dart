import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet_app/blocs/product/product_bloc.dart';
import 'package:velvet_app/blocs/product/product_state.dart';
import 'package:velvet_app/list/categories_list.dart';
import 'package:velvet_app/screens/All%20Prodcut%20Screen/all_products_screen.dart';
import 'package:velvet_app/screens/detail_product_screen.dart';
import 'package:velvet_app/widgets/categories_widget.dart';
import 'package:velvet_app/widgets/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarBuilder(),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            promoSection(),
            SizedBox(height: 18,),
            categoriesSection(),
            SizedBox(height: 18,),
            RecommendedPart(),
            RecommendedProduct(),
          ],
        ),
        ),
      ),
     
    );
  }

































  Column categoriesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.category_outlined, size: 30, color: Colors.red),
              Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              )
            ],
          ),
        ),
        SizedBox(height: 18),
        Container(
          height: 190,
          width: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 20,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final item = categories[index];

                return CategoriesWidget(icon: item['icon'], text: item['text']);
              },
            ),
          ),
        ),
      ],
    );
  }

  SizedBox promoSection() {
    return SizedBox(
      height: 215,
      width: 350,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                height: 180,
                width: 320,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 255, 131, 131),
                        Colors.red
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12)),

                // Promo Banner Content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.sell,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Best Seller!',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Discover the perfect\nshopping journey!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllProductsScreen()));
                      },
                      child: Text(
                        'Shop Now!',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Banner Image
          Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/model-1.png',
                height: 210,
              ))
        ],
      ),
    );
  }

  AppBar appBarBuilder() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: TextField(
        controller: searchController,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            hintText: 'What are you looking for?',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey))),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
      ],
    );
  }
}

class RecommendedProduct extends StatelessWidget {
  const RecommendedProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is ProductLoaded) {
        final recommendedProducts = state.products.take(5).toList();

        return SizedBox(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendedProducts.length,
              itemBuilder: (context, index) {
                final product = state.products[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 170,
                      child: ProductWidget(
                          product: product,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DetailProductScreen(product: product)));
                          })),
                );
              }),
        );
      }
      return SizedBox.shrink();
    });
  }
}

class RecommendedPart extends StatelessWidget {
  const RecommendedPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.thumb_up_alt_outlined, size: 25, color: Colors.red),
              SizedBox(width: 5),
              Text(
                'Recommended',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllProductsScreen()));
            },
            child: Text(
              'See more',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
