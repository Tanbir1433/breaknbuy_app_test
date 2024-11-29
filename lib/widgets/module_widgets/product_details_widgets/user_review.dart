import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../const_config/text_config.dart';
import '../../../const_config/color_config.dart';

class UserReview extends StatelessWidget {
  final String reviewerName;
  final String reviewerComment;
  final String reviewerRating;
  final TextStyle? textStyle;
  const UserReview({
    super.key,
    required this.reviewerName,
    required this.reviewerComment,
    this.textStyle,
    required this.reviewerRating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            RatingBar.builder(
              initialRating: double.parse(reviewerRating),
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              ignoreGestures: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            Text(reviewerName, style: textStyle ?? TextDesign().bnbBodyText)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(reviewerComment,
            style:
                textStyle ?? TextDesign().bnbBodyText.copyWith(fontSize: 15)),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 1,
          color: MyColor.bnbFlashWhite,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
