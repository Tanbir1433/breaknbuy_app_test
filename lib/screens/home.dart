import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/bottom_navbar_provider/bottom_navbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider =
        Provider.of<BottomNavbarProvider>(context, listen: false);
    return Scaffold(
      body: bottomNavProvider.screens[bottomNavProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavProvider.currentIndex,
        onTap: (index) => bottomNavProvider.updateIndex(index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login_outlined),
            activeIcon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
      ),
    );
  }
}
