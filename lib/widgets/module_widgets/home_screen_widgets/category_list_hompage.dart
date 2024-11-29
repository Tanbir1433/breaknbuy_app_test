
import 'package:flutter/material.dart';

import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../footer_widgets/clickable_icon_text.dart';

class CategoryListHomepage extends StatelessWidget {
  const CategoryListHomepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: TextDesign().bnbSubHeaderText,
          ),
          const SizedBox(
            height: 15,
          ),
          const ClickableIconText(
            url: '/RecommendedProduct',
            icon: Icons.star,
            iconColor: MyColor.bnbGrey,
            text: 'Recommended',
            textColor: MyColor.bnbSpaceBlue,
          ),
          const SizedBox(
            height: 10,
          ),
          const ClickableIconText(
            url: '/DiscountProduct',
            icon: Icons.discount_rounded,
            iconColor: MyColor.bnbGrey,
            text: 'Discounted',
            textColor: MyColor.bnbSpaceBlue,
          ),
          const SizedBox(
            height: 10,
          ),
          const ClickableIconText(
            url: '/NewArrivalProduct',
            icon: Icons.new_releases_rounded,
            iconColor: MyColor.bnbGrey,
            text: 'New Arrivals',
            textColor: MyColor.bnbSpaceBlue,
          ),
          const SizedBox(
            height: 10,
          ),
          const ClickableIconText(
            url: '/AllProduct',
            icon: Icons.all_inclusive_rounded,
            iconColor: MyColor.bnbGrey,
            text: 'All Products',
            textColor: MyColor.bnbSpaceBlue,
          ),
        ],
      ),
    );
  }
}
