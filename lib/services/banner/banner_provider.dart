

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../const_config/const_config.dart';
import '../../models/banner.dart';

class BannerProvider with ChangeNotifier {
  late List<Banners> banners = [];
  late bool bannersIsLoading = false;

  void addBanners(List<Banners> bs) {
    banners = bs;
    notifyListeners();
  }

/*  void addRecentBanner(Banners b) {
    banners.add(b);
    notifyListeners();
  }


  int recentBannerId() {
    return banners.last.id + 1;

  }*/

  Future<bool> fetchBanners() async {
    bannersIsLoading = true;
    try {
      final url = Uri.parse('$baseUrl/customer/banners');
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        addBanners(bannerResponseFromMap(response.body).banners);
        bannersIsLoading = false;
        return true;
      } else {
        bannersIsLoading = false;
        return false;
      }
    } catch (e) {
      bannersIsLoading = false;
      return false;
    }
  }

}
