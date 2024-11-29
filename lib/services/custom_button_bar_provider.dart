



import 'package:flutter/material.dart';

class CustomButtonBarProvider extends ChangeNotifier {

  String _selectedSize = '';
  String _selectedColor = '';

  String get selectedSize => _selectedSize;
  String get selectedColor => _selectedColor;


  void setSelectedSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }

  void setSelectedColor(String color) {
    _selectedColor = color;
    notifyListeners();
  }

  void resetSizeColor(){
    _selectedColor = 'reset';
    _selectedSize = 'reset';
    notifyListeners();
  }
}