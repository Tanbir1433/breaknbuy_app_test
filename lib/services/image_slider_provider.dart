import 'package:flutter/material.dart';

class ImageSliderProvider with ChangeNotifier {
  late String selectedImage;
  late int smallSelectedImageIndex;

  late List<String> imageList=[];




  void changeSmallSelectedImageIndex(int i) {
    smallSelectedImageIndex=i;
    notifyListeners();
  }



  void changeSelectedImage(String url) {
    selectedImage = url;
    notifyListeners();
  }
}
