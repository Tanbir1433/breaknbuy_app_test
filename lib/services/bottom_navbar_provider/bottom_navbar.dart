import 'package:breaknbuy_app/screens/login&signup_screens/login_screen.dart';
import 'package:breaknbuy_app/screens/login&signup_screens/signup_screen.dart';
import 'package:breaknbuy_app/screens/user_screens/cart_screen.dart';
import 'package:breaknbuy_app/screens/user_screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

class BottomNavbarProvider extends ChangeNotifier {
  int _currentIndex = 0;

  final List<Widget> _screen = [
    const HomeScreen(),
    const CartScreen(),
    const LoginScreen(),
    const SignupScreen(),
  ];

  int get currentIndex => _currentIndex;

  List<Widget> get screens => _screen;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
