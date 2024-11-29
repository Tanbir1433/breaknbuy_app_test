
import 'package:breaknbuy_app/widgets/module_widgets/product_details_widgets/user_review.dart';
import 'package:flutter/material.dart';

import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../../models/product_details/one_product.dart';

class ProductsReviewCard extends StatelessWidget {
  final List<Review> reviews;

  const ProductsReviewCard({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.white,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Customer Reviews',
                  style: TextDesign().bnbSubHeaderText,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                direction: Axis.horizontal,
                children: reviews.map((r) {
                  return UserReview(
                    reviewerName: r.userName,
                    reviewerComment: r.review ?? '',
                    reviewerRating: r.ratingValue.toString(),
                  );
                }).toList())
          ],
        ),
      ),
    );
  }
}
