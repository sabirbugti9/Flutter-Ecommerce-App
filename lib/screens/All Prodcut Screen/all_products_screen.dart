import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet_app/blocs/product/product_bloc.dart';
import 'package:velvet_app/blocs/product/product_event.dart';
import 'package:velvet_app/screens/All%20Prodcut%20Screen/popular_product_screen.dart';
import 'package:velvet_app/screens/notification_screen.dart';
import 'package:velvet_app/screens/profile_screen.dart';
import 'package:velvet_app/screens/transaction_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = 'ALL'; // Menyimpan kategori yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarBuilder(),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            // Tab bar
            TabBar(
              labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 14,
              ),
              tabs: [
                Tab(text: 'Popular'),
                Tab(text: 'Latest'),
                Tab(text: 'Best Seller'),
                Tab(text: 'Price'),
              ],
            ),

            // Product Category
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryItem(context, 'ALL', Icons.menu),
                  categoryItem(context, 'Clothes', Icons.checkroom_outlined),
                  categoryItem(
                      context, 'Electronics', Icons.phone_android_outlined),
                ],
              ),
            ),

            // Tab Bar Content
            Expanded(
              child: TabBarView(
                children: [
                  PopularProductScreen(),
                  TransactionScreen(),
                  NotificationScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget kategori yang reusable
  Widget categoryItem(BuildContext context, String category, IconData icon) {
    bool isActive = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });

        if (category == 'ALL') {
          context.read<ProductBloc>().add(LoadProducts());
        } else {
          context.read<ProductBloc>().add(FilterProducts(category: category));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: isActive ? Colors.red.shade500 : Colors.black),
            SizedBox(height: 5),
            Text(
              category,
              style: TextStyle(
                fontSize: 13,
                color: isActive ? Colors.red.shade500 : Colors.black,
              ),
            ),
          ],
        ),
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
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
      ],
    );
  }
}
