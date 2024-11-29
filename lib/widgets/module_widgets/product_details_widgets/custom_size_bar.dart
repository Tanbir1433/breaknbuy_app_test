import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/custom_button_bar_provider.dart';

class CustomSizeBar extends StatelessWidget {

  const CustomSizeBar({super.key, required this.valueList});
  final List<String> valueList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Consumer<CustomButtonBarProvider>(
        builder: (context, customBtnBarProvider, _) {

          return ToggleButtons(
            isSelected: valueList.map((size) => size == customBtnBarProvider.selectedSize).toList(),
            onPressed: (int index) {
              customBtnBarProvider.setSelectedSize(valueList[index]);
            },
            borderWidth: 2,
            selectedColor: Colors.white,
            fillColor: Colors.grey,
            borderColor: Colors.grey,
            selectedBorderColor: Colors.grey,
            borderRadius: BorderRadius.circular(5.0),
            children: valueList
                .map((value) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(value),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}