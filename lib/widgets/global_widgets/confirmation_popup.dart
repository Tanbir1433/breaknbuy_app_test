import 'package:flutter/material.dart';
import '../../const_config/color_config.dart';
import '../buttons/simple_button.dart';

class ConfirmationPopup extends StatelessWidget {

  final String? popupTitle;
  final String? popupContent;
  final String? leftButtonTitle;
  final String? rightButtonTitle;
  final Color? confirmColor;
  final Function onClickConfirm;
  final Function onClickCancel;

  const ConfirmationPopup({
    super.key,
    this.popupTitle,
    this.popupContent,
    this.leftButtonTitle,
    this.rightButtonTitle, required this.onClickConfirm, required this.onClickCancel, this.confirmColor,
  });



  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
        elevation: 1,
        title: Text(popupTitle ?? "Confirm Delete?"),
        content: Text(popupContent ??
            "Are you sure? This data will be deleted permanently"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:35,left: 5),
            child: Column(
              children: [
                SimpleButton(
                  onClick: () {
                    onClickConfirm();
                  },
                  text: leftButtonTitle ?? "Confirm",
                  backGroundColor: confirmColor ?? MyColor.red,
                ),
                const SizedBox(height: 20),
                SimpleButton(
                  onClick: () {
                    onClickCancel();
                  },
                  text: rightButtonTitle ?? "Cancel",
                ),
              ],
            ),
          ),
        ],
      );
  }
}
