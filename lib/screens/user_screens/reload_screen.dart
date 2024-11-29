import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class ReloadScreen extends StatefulWidget {
  final String screenName;
  const ReloadScreen({super.key, required this.screenName});

  @override
  State<ReloadScreen> createState() => _ReloadScreenState();
}

class _ReloadScreenState extends State<ReloadScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(widget.screenName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'id not found',
        style: TextDesign().bnbBannerText.copyWith(color: MyColor.red),
      )),
    );
  }
}
