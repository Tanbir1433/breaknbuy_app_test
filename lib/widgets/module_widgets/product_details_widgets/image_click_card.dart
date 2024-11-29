import 'package:flutter/material.dart';

import '../../../const_config/color_config.dart';
import '../../global_widgets/custome_image_network_card.dart';

class ImageClickCard extends StatelessWidget {
  final String imageUrl;
  final Function onClick;
  final bool isSelected;
  const ImageClickCard(
      {super.key,
      required this.imageUrl,
      required this.onClick,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: isSelected ? 1 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: isSelected ? MyColor.bnbLightBlue : MyColor.bnbScaffold,
          width: isSelected ? 2 : 1,
        ),
      ),
      color: MyColor.white,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: SizedBox(
          height: 80,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CustomImageNetworkCard(
              imagePath: imageUrl,
              // width: 100,
              // height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
