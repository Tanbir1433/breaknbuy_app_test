import 'package:flutter/material.dart';

import '../../../../const_config/text_config.dart';
import '../../../const_config/color_config.dart';

class ProductDescriptionCard extends StatelessWidget {
  final String description;

  const ProductDescriptionCard({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.white,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text(
                    'Product Specification',
                    style: TextDesign().bnbSubHeaderText,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Text(description)
          ],
        ),
      ),
    );
  }
}
