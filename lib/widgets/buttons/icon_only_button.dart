import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';


class IconOnlyButton extends StatelessWidget {
  const IconOnlyButton({
    super.key,
    required this.onClick,
  });

  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick(),
      child: const Icon(
        Icons.edit,
        color: MyColor.mtMainGreen,
      ),
    );
  }
}
