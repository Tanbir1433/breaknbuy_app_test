
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const_config/color_config.dart';
import '../../../services/custom_button_bar_provider.dart';

class CustomColorBar extends StatelessWidget {

  const CustomColorBar({super.key, required this.valueList});
  final List<String> valueList;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width>358?
    SizedBox(
      height: 40,
      child: Consumer<CustomButtonBarProvider>(
        builder: (context, customBtnBarProvider, _) {

          return ToggleButtons(
            isSelected: valueList.map((color) => color == customBtnBarProvider.selectedColor).toList(),
            onPressed: (int index) {
              customBtnBarProvider.setSelectedColor(valueList[index]);
            },

            borderWidth: 2,
            selectedColor: Colors.white,
            fillColor: MyColor.bnbLightRed,
            borderColor: MyColor.bnbLightRed,
            selectedBorderColor: MyColor.bnbLightRed,
            borderRadius: BorderRadius.circular(5.0),
            children: valueList
                .map((value) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ))
                .toList(),
          );
        },
      ),
    ):SizedBox(
      height: 28,
      child: Consumer<CustomButtonBarProvider>(
        builder: (context, customBtnBarProvider, _) {

          return ToggleButtons(
            isSelected: valueList.map((color) => color == customBtnBarProvider.selectedColor).toList(),
            onPressed: (int index) {
              customBtnBarProvider.setSelectedColor(valueList[index]);
            },
            borderWidth: 2,
            selectedColor: Colors.white,
            fillColor: MyColor.bnbLightRed,
            borderColor: MyColor.bnbLightRed,
            selectedBorderColor: MyColor.bnbLightRed,
            borderRadius: BorderRadius.circular(5.0),
            children: valueList
                .map((value) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(value),
            ))
                .toList(),
          );
        },
      ),
    );
  }
}