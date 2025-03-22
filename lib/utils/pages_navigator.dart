import 'package:flutter/material.dart';
import 'package:velvet_app/screens/home_screen.dart';
import 'package:velvet_app/screens/notification_screen.dart';
import 'package:velvet_app/screens/profile_screen.dart';
import 'package:velvet_app/screens/transaction_screen.dart';
import 'package:velvet_app/screens/wishlist_screen.dart';

class PagesNavigator extends StatefulWidget {
  const PagesNavigator({super.key});

  @override
  State<PagesNavigator> createState() => _PagesNavigatorState();
}

class _PagesNavigatorState extends State<PagesNavigator> {
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    WishlistScreen(),
    TransactionScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red.shade500,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: navigateBottomBar,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: 'Transaction'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), label: 'Notification'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
